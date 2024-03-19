import 'package:app_generator/bloc/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScoreCounterWidget extends StatelessWidget {
  const ScoreCounterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      (context.watch<ScoreCubit>().state.score ?? 0).toStringAsFixed(0),
      style: TextStyle(
          fontSize: 56,
          fontWeight: FontWeight.w700,
          color: Colors.white.withOpacity(0.7)),
    );
  }
}
