import 'package:flutter/material.dart';
import 'package:yds_yokdil/blockmain.dart';
import 'package:yds_yokdil/wordmain.dart';
import 'package:yds_yokdil/yokdilmain.dart';
import 'constant.dart';
import 'questionmain.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

final String testID = "yds_premium";

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
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
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  "Öğrenme şeklini kendin belirle",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: Colors.black54,
                      fontSize: 18,
                      fontFamily: "Fjalla One"),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: HomeMenuWidget(
                      menuIcon: Icons.ac_unit_sharp,
                      text: "YDS Kelimeler",
                      subText:
                          "Kelimeleri gözden geçirerek bilmediklerini not alabilirsin.",
                      menuSection: 0,
                    ),
                  ),
                  Expanded(
                    child: HomeMenuWidget(
                      menuIcon: Icons.quiz,
                      text: "Yds Quiz",
                      subText:
                          "Seçenekler arasından doğru olanı bulmaya çalışırken öğrenebilirsin.",
                      menuSection: 1,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: HomeMenuWidgetYokdil(
                      menuIcon: Icons.dashboard_customize,
                      text: "Yökdil",
                      subText: "Fen Bilimleri ",
                      whSection: 1,
                    ),
                  ),
                  Expanded(
                    child: HomeMenuWidgetYokdil(
                      menuIcon: Icons.dashboard_customize,
                      text: "Yökdil",
                      subText: "Sosyal Bilimler",
                      whSection: 2,
                    ),
                  ),
                  Expanded(
                    child: HomeMenuWidgetYokdil(
                      menuIcon: Icons.dashboard_customize,
                      text: "Yökdil",
                      subText: "Sağlık Bilimleri",
                      whSection: 3,
                    ),
                  ),
                ],
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Expanded(
              //       child: HomeMenuWidget(
              //         menuIcon: Icons.web_rounded,
              //         text: "Blok Çeviri",
              //         subText:
              //             "Blok çeviri sayesinde kelimelerin cümleler içinde kullanımıyla kalıcı öğrenme sağlayabilirsin.",
              //       ),
              //     ),
              //   ],
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: HomeMenuWidget(
                      menuIcon: Icons.web_rounded,
                      text: "Blok Çeviri",
                      subText:
                          "Blok çeviri sayesinde kelimelerin cümleler içinde kullanımıyla kalıcı öğrenme sağlayabilirsin.",
                      menuSection: 2,
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
  }) : super(key: key);

  final String text;
  final String subText;
  final IconData menuIcon;
  final int menuSection;

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: screenHeight * 0.30,
      margin: EdgeInsets.all(5),
      child: FlatButton(
        color: Colors.white,
        padding: EdgeInsets.all(10),
        onPressed: () {
          if (menuSection == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => WordMain(
                        whSection: 0,
                      )),
            );
          } else if (menuSection == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => OuestionMain(
                        whSection: 0,
                      )),
            );
          } else if (menuSection == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BlockMain()),
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
                    fontSize: 12,
                    color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeMenuWidgetYokdil extends StatelessWidget {
  const HomeMenuWidgetYokdil({
    Key key,
    @required this.text,
    @required this.subText,
    @required this.menuIcon,
    @required this.whSection,
  }) : super(key: key);

  final String text;
  final String subText;
  final IconData menuIcon;
  final int whSection;

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: screenHeight * 0.20,
      margin: EdgeInsets.all(5),
      child: FlatButton(
        color: Colors.white,
        padding: EdgeInsets.all(10),
        onPressed: () {
          if (text == "Yökdil") {
            // Navigator.pushNamed(context, "/questionmain");
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => YokdilMainPage(whSection: whSection)),
            );
          }
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(padding: EdgeInsets.only(top: 0)),
            Icon(menuIcon, size: 40, color: Colors.blueAccent),
            // Image(
            //   image: AssetImage("assets/images/menu1.png"),
            // ),
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 15, 10, 5),
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
              padding: const EdgeInsets.fromLTRB(5, 1, 10, 5),
              child: Text(
                subText,
                style: TextStyle(
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.normal,
                    fontSize: 12,
                    color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
