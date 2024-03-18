import 'package:freezed_annotation/freezed_annotation.dart';

part 'model.freezed.dart';
part 'model.g.dart';

@freezed
class QuestionModel with _$QuestionModel {
  QuestionModel._();

  factory QuestionModel(
      {required String questionText,
      required List<AnswerModel> answers}) = _QuestionModel;

  factory QuestionModel.fromJson(Map<String, dynamic> json) =>
      _$QuestionModelFromJson(json);
}

@freezed
class AnswerModel with _$AnswerModel {
  AnswerModel._();

  factory AnswerModel({required String text, required double score}) =
      _AnswerModel;

  factory AnswerModel.fromJson(Map<String, dynamic> json) =>
      _$AnswerModelFromJson(json);
}
