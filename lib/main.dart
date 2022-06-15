import 'package:flutter/material.dart';
import 'package:yds_yokdil/balongame.dart';
import 'package:yds_yokdil/blockmain.dart';
import 'package:yds_yokdil/constant.dart';
import 'package:yds_yokdil/eula.dart';
import 'package:yds_yokdil/similarwords.dart';
import 'package:yds_yokdil/wordmainsecond.dart';
import 'homepage.dart';
import 'questions.dart';
import 'questionmain.dart';
import 'wordmain.dart';
import 'words.dart';
import 'block.dart';
import 'splash.dart';
import 'blockmain.dart';
import 'similarwords.dart';
import 'privacy.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(
    theme: new ThemeData(
      canvasColor: defaultBackgroundColor,
    ),
    debugShowCheckedModeBanner: false,
    initialRoute: "/",
    routes: {
      "/": (context) => SplashPage(),
      "/homepage": (context) => HomePage(),
      "/questions": (context) => Question(),
      "/questionmain": (context) => OuestionMain(),
      "/wordmain": (context) => WordMain(),
      "/words": (context) => Word(),
      "/block": (context) => Block(),
      "/blockmain": (context) => BlockMain(),
      "/wordsmainsecond": (context) => WordMainSecond(),
      "/similarword": (context) => SimilarWordsPage(),
      "/balongame": (context) => BalonGame(),
      "/eula": (context) => EulaPage(),
      "/privacy": (context) => PrivacyPage(),
    },
  ));
}
