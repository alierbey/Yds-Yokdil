import 'package:flutter/material.dart';
import 'package:yds_yokdil/blockmain.dart';
import 'package:yds_yokdil/constant.dart';
import 'package:yds_yokdil/wordmainsecond.dart';
import 'homepage.dart';
import 'questions.dart';
import 'questionmain.dart';
import 'wordmain.dart';
import 'words.dart';
import 'block.dart';
import 'blockmain.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(
    theme: new ThemeData(
      canvasColor: defaultBackgroundColor,
    ),
    debugShowCheckedModeBanner: false,
    initialRoute: "/",
    routes: {
      "/": (context) => HomePage(),
      "/homepage": (context) => HomePage(),
      "/questions": (context) => Question(),
      "/questionmain": (context) => OuestionMain(),
      "/wordmain": (context) => WordMain(),
      "/words": (context) => Word(),
      "/block": (context) => Block(),
      "/blockmain": (context) => BlockMain(),
      "/wordsmainsecond": (context) => WordMainSecond(),
    },
  ));
}
