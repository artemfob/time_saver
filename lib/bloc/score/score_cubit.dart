import 'package:bloc/bloc.dart';

part 'score_state.dart';

class ScoreCubit extends Cubit<ScoreState> {
  ScoreCubit() : super(ScoreInitial());

  void init() {
    emit(ScoreLoaded(score: 0));
  }

  void increment(double score) {
    emit(ScoreLoaded(score: (state.score ?? 0) + score));
  }

  void decrement() {
    emit(ScoreLoaded(
        score: (state.score ?? 0) > 0 ? state.score ?? 0 - 100 : state.score));
  }

  void drop() {
    emit(ScoreLoaded(score: 0));
  }
}
