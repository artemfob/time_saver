import 'package:plinkozeus/bloc/index.dart';
import 'package:plinkozeus/screens/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

part 'router.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<GameCubit>(create: (_) => GameCubit()),
          BlocProvider<ScoreCubit>(create: (_) => ScoreCubit()),
        ],
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Generator',
          routerConfig: AppRouter.router,
        ));
  }
}
