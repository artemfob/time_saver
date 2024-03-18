part of 'score_cubit.dart';

abstract class ScoreState {
  final double? score;

  ScoreState({this.score});
}

class ScoreInitial extends ScoreState {}

class ScoreLoaded extends ScoreState {
  ScoreLoaded({required super.score});
}
