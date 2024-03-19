import 'package:app_generator/bloc/index.dart';
import 'package:app_generator/data/models/question/model.dart';
import 'package:app_generator/data/questions.dart';
import 'package:app_generator/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuizScreen extends StatefulWidget {
  static const String path = '/quiz';

  const QuizScreen({Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  PageController controller = PageController();
  bool finish = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(31, 27, 34, 1.0),
      body: SafeArea(
        child: finish
            ? const _FinishedQuizWidget()
            : PageView.builder(
                controller: controller,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: questions.length,
                itemBuilder: (BuildContext context, int index) {
                  final question = QuestionModel.fromJson(questions[index]);
                  return Container(
                    decoration: const BoxDecoration(
                        color: Color.fromRGBO(31, 27, 34, 1.0)),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          height: 40,
                        ),
                        const ScoreCounterWidget(),
                        const SizedBox(
                          height: 60,
                        ),
                        Expanded(
                            child: QuestionFormWidget(
                          question: question,
                          lastQuestion: questions[index] == questions.last,
                          finish: () async {
                            setState(() {
                              finish = true;
                            });
                          },
                          goNext: () => controller.nextPage(
                              duration: const Duration(milliseconds: 250),
                              curve: Curves.easeOut),
                          index: index + 1,
                        ))
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}

class _FinishedQuizWidget extends StatelessWidget {
  const _FinishedQuizWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'You finished Quiz with ${context.read<ScoreCubit>().state.score?.toStringAsFixed(0)} points! Congrats!',
        style: const TextStyle(color: Colors.white70),
      ),
    );
  }
}
