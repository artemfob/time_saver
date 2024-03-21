import 'package:bloc/bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit() : super(GameInitial());

  Future init() async {
    emit(Loading());
    emit(Quiz(score: 0));
    //
    // String referrer = await SharedPreferences.getInstance()
    //     .then((value) => value.getString('referrer') ?? "");
    //
    // if (referrer.isEmpty) {
    //   // Platform messages may fail, so we use a try/catch PlatformException.
    //   try {
    //     ReferrerDetails referrerDetails =
    //         await AndroidPlayInstallReferrer.installReferrer;
    //
    //     if (referrerDetails.installReferrer == null) {
    //       referrer = '';
    //     } else {
    //       referrer = referrerDetails.installReferrer!;
    //     } // referrerDetails = referrerDetails;
    //   } catch (e) {
    //     referrer = "error_while_retrieving_referrer";
    //     // referrerDetailsString = 'Failed to get referrer details: $e';
    //   }
    // }
    //
    // final String token = await FirebaseMessaging.instance.getToken() ?? '';
    // final keitaroURL =
    //     '${Constants_.requestUrl}&registrationToken=$token&instref=$referrer';
    //
    // print("KeitaroURL $keitaroURL");
    //
    // final response =
    //     await Dio().get(keitaroURL).then((res) async => await res.data);
    //
    // final bool playGame =
    //     response == Constants_.showWebView && referrer.isNotEmpty;
    //
    // if (playGame) {
    //   await SharedPreferences.getInstance()
    //       .then((value) => value.setString('referrer', referrer));
    //
    //   WebViewController controller = WebViewController()
    //     ..setJavaScriptMode(JavaScriptMode.unrestricted)
    //     ..setBackgroundColor(Colors.transparent.withOpacity(0))
    //     ..setNavigationDelegate(
    //       NavigationDelegate(
    //         onProgress: (int progress) {
    //           // Update loading bar.
    //         },
    //         onPageStarted: (String url) {},
    //         onPageFinished: (String url) {},
    //         onWebResourceError: (WebResourceError error) {},
    //         onNavigationRequest: (NavigationRequest request) {
    //           return NavigationDecision.navigate;
    //         },
    //       ),
    //     )
    //     ..loadRequest(Uri.parse(keitaroURL));
    //   emit(WebView(keitaroUrl: keitaroURL, controller: controller));
    // } else {
    //   emit(Quiz(score: 0));
    // }
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
