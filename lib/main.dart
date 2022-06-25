import 'package:flutter/material.dart';
import 'package:yds_yokdil/balongame.dart';
import 'package:yds_yokdil/blockmain.dart';
import 'package:yds_yokdil/constant.dart';
import 'package:yds_yokdil/eula.dart';
import 'package:yds_yokdil/similarwords.dart';
import 'package:yds_yokdil/word_1_page_info.dart';
import 'package:yds_yokdil/word_2_list_grup.dart';
import 'package:yds_yokdil/word_3_list_section.dart';
import 'package:yds_yokdil/word_4_internet.dart';
import 'homepage.dart';
import 'questions.dart';
import 'questionmain.dart';
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
      "/block": (context) => Block(),
      "/blockmain": (context) => BlockMain(),
      "/similarword": (context) => SimilarWordsPage(),
      "/balongame": (context) => BalonGame(),
      "/eula": (context) => EulaPage(),
      "/privacy": (context) => PrivacyPage(),

// word pages
      "/word_page_info": (context) => WordPageInfo(),
      "/word_list_grup": (context) => WordListGrup(),
      "/word_list_section": (context) => WordListSection(),
      "/word_internet": (context) => WordInternet(),
    },
  ));
}
