import 'package:plinkozeus/bloc/game/game_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatelessWidget {
  static const String path = '/web';

  const WebViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameCubit, GameState>(
      builder: (context, state) {
        return PopScope(
          canPop: false,
          onPopInvoked: (status) => false,
          child: Scaffold(
            body: SafeArea(
              child: WebViewWidget(
                  controller: state.controller ?? WebViewController()),
            ),
          ),
        );
      },
    );
  }
}
