import 'package:app_generator/bloc/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScoreCounterWidget extends StatelessWidget {
  const ScoreCounterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.amberAccent.withOpacity(0.8),
          borderRadius: BorderRadius.circular(100)),
      child: Text(
        (context.watch<ScoreCubit>().state.score ?? 0).toStringAsFixed(0),
        style: const TextStyle(
            fontSize: 20, fontWeight: FontWeight.w700, color: Colors.redAccent),
      ),
    );
  }
}
