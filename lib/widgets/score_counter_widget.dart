import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tigerquiz/bloc/index.dart';

class ScoreCounterWidget extends StatelessWidget {
  const ScoreCounterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          (context.watch<GameCubit>().state.score ?? 0).toStringAsFixed(0),
          style: TextStyle(
              fontSize: 56,
              fontWeight: FontWeight.w700,
              height: 1,
              color: Colors.white.withOpacity(0.7)),
        ),
      ],
    );
  }
}
