import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plinkozeusquiz/bloc/index.dart';

class QuestionFormWidget extends StatelessWidget {
  const QuestionFormWidget(
      {Key? key,
      required this.question,
      required this.goNext,
      required this.finish,
      required this.lastQuestion,
      required this.index})
      : super(key: key);
  final Map<String, dynamic> question;
  final bool lastQuestion;
  final int index;
  final void Function() goNext;
  final void Function() finish;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '$index. ${question['questionText']}',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontWeight: FontWeight.w400,
            fontSize: 24,
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        Expanded(
            child: Column(
          children: List.generate(question['answers'].length, (index) {
            List<String> markers = ['a)', 'b)', 'c)', 'd)'];

            return Expanded(
              child: InkWell(
                highlightColor: Colors.white.withOpacity(0),
                splashColor: Colors.white.withOpacity(0),
                radius: 0,
                onTap: () {
                  context
                      .read<GameCubit>()
                      .increment(question['answers'][index]['score']);
                  goNext();
                  if (lastQuestion) {
                    finish();
                  }
                },
                child: Container(
                    width: MediaQuery.of(context).size.width * 1,
                    alignment: Alignment.centerLeft,
                    padding:
                        const EdgeInsets.only(left: 22, top: 12, bottom: 12),
                    margin: const EdgeInsets.only(bottom: 18),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: Colors.white.withOpacity(0.22), width: 0.75),
                        color: const Color.fromRGBO(47, 44, 51, 1.0)),
                    child: Text(
                        '${markers[question['answers'].indexOf(question['answers'][index])]} ${question['answers'][index]['text']}',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.white.withOpacity(0.7)))),
              ),
            );
          }),
        )),
        const SizedBox(
          height: 140,
        )
      ],
    );
  }
}
