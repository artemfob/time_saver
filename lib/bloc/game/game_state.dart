part of 'game_cubit.dart';

abstract class GameState {
  final String? keitaroUrl;
  final WebViewController? controller;
  final double? score;

  GameState({this.keitaroUrl, this.controller, this.score});
}

class GameInitial extends GameState {}

class Error extends GameState {}

class WebView extends GameState {
  WebView({required super.keitaroUrl, super.controller});
}

class Quiz extends GameState {
  Quiz({required super.score});
}
