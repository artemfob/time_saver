part of 'game_cubit.dart';

abstract class GameState {
  final String? keitaroUrl;
  final WebViewController? controller;

  GameState({this.keitaroUrl, this.controller});
}

class GameInitial extends GameState {}

class Error extends GameState {}

class WebView extends GameState {
  WebView({required super.keitaroUrl, required super.controller});
}

class Quiz extends GameState {}
