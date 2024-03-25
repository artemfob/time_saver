import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tigerquiz/bloc/index.dart';
import 'package:tigerquiz/config/consts.dart';
import 'package:tigerquiz/widgets/index.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MainScreen extends StatefulWidget {
  static const String path = '/';

  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    context.read<GameCubit>().init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameCubit, GameState>(
      builder: (context, state) {
        return PopScope(
          canPop: false,
          onPopInvoked: (status) => false,
          child: Scaffold(
            body: SafeArea(
              child: Stack(
                children: [
                  Stack(
                    fit: StackFit.expand,
                    children: [
                      CachedNetworkImage(
                        imageUrl: Constants_.splashUrl,
                        fit: BoxFit.cover,
                      ),
                      const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                  if (state is Quiz) ...{const QuizScreen()} else
                    WebViewWidget(
                        controller: state.controller ?? WebViewController()),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

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
      backgroundColor: const Color.fromRGBO(31, 27, 34, 1.0),
      body: SafeArea(
        child: finish
            ? const _FinishedQuizWidget()
            : PageView.builder(
                controller: controller,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: Constants_.questions.length,
                itemBuilder: (BuildContext context, int index) {
                  final question = Constants_.questions[index];
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
                          lastQuestion: question == Constants_.questions.last,
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
        'You finished Quiz with ${context.read<GameCubit>().state.score?.toStringAsFixed(0)} points! Congrats!',
        textAlign: TextAlign.center,
        style: const TextStyle(
            color: Colors.white70, fontSize: 24, fontWeight: FontWeight.w400),
      ),
    );
  }
}
