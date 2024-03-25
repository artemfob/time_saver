import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tigerquiz/bloc/index.dart';
import 'package:tigerquiz/widgets/index.dart';

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
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 30),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black87, width: 2),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16)),
              child: Text(
                '${question['questionText']}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black.withOpacity(0.7),
                  fontWeight: FontWeight.w600,
                  fontSize: 22,
                ),
              ),
            ),
            Positioned(
                top: 0,
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white.withOpacity(0),
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    width: MediaQuery.of(context).size.width * 0.3,
                    decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: Colors.black87, width: 2)),
                    child: Text('#$index',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            color: Colors.black87)),
                  ),
                ))
          ],
        ),
        const SizedBox(
          height: 24,
        ),
        TimerWidget(
          nextPage: goNext,
        ),
        const SizedBox(
          height: 24,
        ),
        Expanded(
            child: Column(
          children: List.generate(question['answers'].length, (index) {
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
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(top: 12, bottom: 12),
                    margin: const EdgeInsets.only(bottom: 18),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: Colors.black.withOpacity(0.92), width: 1.75),
                        color: const Color.fromRGBO(245, 245, 245, 1.0)),
                    child: Text('${question['answers'][index]['text']}',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.black.withOpacity(0.7)))),
              ),
            );
          }),
        )),
      ],
    );
  }
}
