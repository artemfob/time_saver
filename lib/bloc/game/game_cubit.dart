import 'dart:ui';

import 'package:android_play_install_referrer/android_play_install_referrer.dart';
import 'package:app_generator/config/consts.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:webview_flutter/webview_flutter.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit() : super(GameInitial());

  Future init() async {
    ReferrerDetails? referrerDetails =
        await AndroidPlayInstallReferrer.installReferrer;

    final response = await Dio()
        .get(Constants_.requestUrl)
        .then((res) async => await res.data);

    final String referrer = referrerDetails.installReferrer ?? '';

    final String token = await FirebaseMessaging.instance.getToken() ?? '';

    final bool playGame =
        response == Constants_.showWebView && referrer.isNotEmpty;

    final webViewUrl =
        '${Constants_.requestUrl}&registrationToken=$token&instref=$referrer';

    if (playGame) {
      WebViewController controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setBackgroundColor(const Color(0x00000000))
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
        ..loadRequest(Uri.parse(webViewUrl));
      emit(WebView(keitaroUrl: webViewUrl, controller: controller));
    } else {
      emit(Quiz());
    }
  }
}
