import 'package:app_generator/bloc/game/game_cubit.dart';
import 'package:app_generator/config/consts.dart';
import 'package:app_generator/screens/index.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  static const String path = '/splash';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    context.read<GameCubit>().init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GameCubit, GameState>(
      listener: (context, state) async {
        await Future.delayed(const Duration(seconds: 1)); //todo remove if need
        // if (state is WebView) {
        //   context.go(WebViewScreen.path);
        // } else if (state is Quiz) {
        //   context.go(QuizScreen.path);
        // }
        context.go(QuizScreen.path);
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          CachedNetworkImage(
            imageUrl: Constants_.splashUrl,
            fit: BoxFit.cover,
          ),
          const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
