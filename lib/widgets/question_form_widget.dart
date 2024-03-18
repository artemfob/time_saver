import 'package:app_generator/bloc/index.dart';
import 'package:app_generator/data/models/question/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuestionFormWidget extends StatelessWidget {
  const QuestionFormWidget(
      {Key? key,
      required this.question,
      required this.goNext,
      required this.finish,
      required this.lastQuestion})
      : super(key: key);
  final QuestionModel question;
  final bool lastQuestion;
  final void Function() goNext;
  final void Function() finish;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          question.questionText,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        Expanded(
            child: Column(
          children: question.answers
              .map((e) => InkWell(
                    highlightColor: Colors.white.withOpacity(0),
                    splashColor: Colors.white.withOpacity(0),
                    radius: 0,
                    onTap: () {
                      context.read<ScoreCubit>().increment(e.score);
                      goNext();
                      if (lastQuestion) {
                        finish();
                      }
                    },
                    child: Container(
                        width: MediaQuery.of(context).size.width * 1,
                        height: 40,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(bottom: 8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.black.withOpacity(0.05)),
                        child: Text(e.text)),
                  ))
              .toList(),
        ))
      ],
    );
  }
}
