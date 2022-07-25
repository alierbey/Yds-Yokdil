import 'dart:async';
import 'package:flutter/material.dart';
import 'package:yds_yokdil/balongame.dart';
import 'package:yds_yokdil/constant.dart';
import 'package:yds_yokdil/homepage.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  Timer timer1;
  AnimationController controller1;
  Animation animation1;

  @override
  void initState() {
    // TODO: implement initState

    timer1 = Timer(new Duration(milliseconds: 2500), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => HomePage(),
          // builder: (context) => BalonGame(),
        ),
      );
    });

    controller1 = AnimationController(
        vsync: this, duration: new Duration(milliseconds: 1500));

    animation1 = Tween<double>(begin: 0, end: 40).animate(
        new CurvedAnimation(parent: controller1, curve: Curves.bounceOut))
      ..addListener(() {
        setState(() {});
      });

    controller1.forward();

    super.initState();
  }

  @override
  void dispose() {
    controller1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: defaultBackgroundColor,
      body: Stack(
        children: [
          Positioned.fill(
            left: 0,
            top: -100,
            child: Center(
              child: Text(
                "Şimdi",
                style: TextStyle(fontSize: animation1.value),
              ),
            ),
          ),
          Positioned.fill(
            left: 0,
            top: 0,
            child: Center(
              child: Text(
                "Çalışma",
                style: TextStyle(fontSize: animation1.value),
              ),
            ),
          ),
          Positioned.fill(
            left: 0,
            top: 100,
            child: Center(
              child: Text(
                "Zamanı",
                style: TextStyle(fontSize: animation1.value),
              ),
            ),
          )
        ],
      ),
    );
  }
}
