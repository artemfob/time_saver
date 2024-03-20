import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plinkozeusquiz/bloc/index.dart';

import 'screens/main.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<GameCubit>(create: (_) => GameCubit()),
          BlocProvider<ScoreCubit>(create: (_) => ScoreCubit()),
        ],
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Generator',
          home: MainScreen(),
        ));
  }
}
