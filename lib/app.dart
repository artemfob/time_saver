import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tigerquiz/bloc/index.dart';

import 'screens/main.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GameCubit>(
        create: (_) => GameCubit(),
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Trivia of Zeus Quiz',
          home: MainScreen(),
        ));
  }
}
