import 'package:flutter/material.dart';
import 'package:yds_yokdil/blockmain.dart';
import 'package:yds_yokdil/wordmain.dart';
import 'constant.dart';
import 'questionmain.dart';

class YokdilMainPage extends StatefulWidget {
  // 0 - Fen bilimleri
  // 1 - Sosyal bilimler
  // 2 - Sağlık bilimleri

  int whSection = 1;

  YokdilMainPage({
    Key key,
    @required this.whSection,
  }) : super(key: key);

  @override
  State<YokdilMainPage> createState() => _YokdilMainPageState();
}

class _YokdilMainPageState extends State<YokdilMainPage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    String whSectionString = "";

    if (widget.whSection == 1)
      whSectionString = "Fen Bilimleri";
    else if (widget.whSection == 2)
      whSectionString = "Sosyal Bilimler";
    else if (widget.whSection == 3) whSectionString = "Sağlık Bilimleri";
    return Scaffold(
      appBar: AppBar(
        backgroundColor: defaultBackgroundColor,
        elevation: 0,
      ),
      backgroundColor: defaultBackgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: beyHorizontalPadding),
          child: Column(
            children: [
              Image(
                image: AssetImage("assets/images/logo.png"),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  "Öğrenme şeklini kendin belirle",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: Colors.black54,
                      fontSize: 24,
                      fontFamily: "Fjalla One"),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: HomeMenuWidget(
                      menuIcon: Icons.web_rounded,
                      text: "Yökdil " + whSectionString + " Kelimeler",
                      subText:
                          "Blok çeviri sayesinde kelimelerin cümleler içinde kullanımıyla kalıcı öğrenme sağlayabilirsin.",
                      menuSection: 0,
                      whSection: widget.whSection,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: HomeMenuWidget(
                      menuIcon: Icons.web_rounded,
                      text: "Yökdil " + whSectionString + " Quiz",
                      subText:
                          "Blok çeviri sayesinde kelimelerin cümleler içinde kullanımıyla kalıcı öğrenme sağlayabilirsin.",
                      menuSection: 1,
                      whSection: widget.whSection,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeMenuWidget extends StatelessWidget {
  const HomeMenuWidget({
    Key key,
    @required this.text,
    @required this.subText,
    @required this.menuIcon,
    @required this.menuSection,
    @required this.whSection,
  }) : super(key: key);

  final String text;
  final String subText;
  final IconData menuIcon;
  final int menuSection;
  final int whSection;

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: screenHeight * 0.26,
      margin: EdgeInsets.all(5),
      child: FlatButton(
        color: Colors.white,
        padding: EdgeInsets.all(10),
        onPressed: () {
          if (menuSection == 0) {
            // Navigator.pushNamed(context, "/questionmain");
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WordMain(
                  whSection: whSection,
                ),
              ),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => OuestionMain(
                        whSection: whSection,
                      )),
            );
          }
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(padding: EdgeInsets.only(top: 0)),
            Icon(menuIcon, size: 48, color: Colors.blueAccent),
            // Image(
            //   image: AssetImage("assets/images/menu1.png"),
            // ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 15, 10, 5),
              child: Text(
                text,
                style: TextStyle(
                    fontFamily: "Anton",
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                    color: Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Text(
                subText,
                style: TextStyle(
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.normal,
                    fontSize: 13,
                    color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
