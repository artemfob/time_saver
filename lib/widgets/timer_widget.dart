import 'dart:async';

import 'package:flutter/material.dart';

class TimerWidget extends StatefulWidget {
  const TimerWidget({Key? key, required this.nextPage}) : super(key: key);
  final VoidCallback nextPage;
  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  bool start = true;
  int countdown = 30;
  Timer timer = Timer.periodic(Duration(seconds: 1), (timer) {});
  @override
  void initState() {
    start = true;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        start = false;
      });
      timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          countdown = 30 - timer.tick;
        });
        countdown == 0 ? widget.nextPage() : null;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedContainer(
          height: 25,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
          ),
          padding: EdgeInsets.symmetric(
              vertical: 1,
              horizontal: start ? 0 : MediaQuery.of(context).size.width * 1),
          width: (MediaQuery.of(context).size.width * 1),
          duration: const Duration(seconds: 64),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        ),
        Container(
          width: 40,
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: Colors.black87, width: 2),
          ),
          child: Text(countdown.toString(),
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
        )
      ],
    );
  }
}
