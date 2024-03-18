part of 'app.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: SplashScreen.path,
    routes: [
      GoRoute(
        path: WebViewScreen.path,
        builder: (context, state) {
          return const WebViewScreen();
        },
      ),
      GoRoute(
        path: SplashScreen.path,
        builder: (context, state) {
          return const SplashScreen();
        },
      ),
      GoRoute(
        path: QuizScreen.path,
        builder: (context, state) {
          return const QuizScreen();
        },
      ),
    ],
  );
}
