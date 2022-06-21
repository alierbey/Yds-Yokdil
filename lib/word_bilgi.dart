import 'package:flutter/material.dart';
import 'package:yds_yokdil/blockmain.dart';
import 'package:yds_yokdil/satinal.dart';
import 'package:yds_yokdil/wordmain.dart';
import 'constant.dart';
import 'questionmain.dart';

class WordBilgiPage extends StatefulWidget {
  int whSection = 0;

  WordBilgiPage({
    Key key,
    @required this.whSection,
  }) : super(key: key);

  @override
  State<WordBilgiPage> createState() => _WordBilgiPageState();
}

class _WordBilgiPageState extends State<WordBilgiPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "",
          ),
        ),
        backgroundColor: Colors.amber,
        elevation: 0,
        leading: new IconButton(
          icon: new Icon(
            Icons.arrow_back_ios,
          ),
          // onPressed: () => Navigator.pushNamed(context, "/homepage"),
          onPressed: () => Navigator.pop(context),
          color: Colors.black,
        ),
      ),
      backgroundColor: Colors.amber,
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
                      text: "Yds Kelimeler",
                      subText:
                          "İlk 45 Kelimeyi ücretsiz öğrenebilirsin, 45 kelimeden sonra premium üye olmanız gerekir",
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
                      menuIcon: Icons.workspace_premium,
                      text: "Premium Üye",
                      subText:
                          "Premium üye olarak diğer bütün kelime gruplarını indirebilirsiniz.",
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
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: menuSection == 1
                ? MaterialStateProperty.all<Color>(Colors.cyanAccent)
                : MaterialStateProperty.all<Color>(Colors.white),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ))),
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
                builder: (context) => SatilAlPage(),
              ),
            );
          }
        },
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
