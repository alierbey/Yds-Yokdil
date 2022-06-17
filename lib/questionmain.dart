import 'dart:convert';

import 'package:flutter/material.dart';
import 'questions.dart';
import 'constant.dart';

class OuestionMain extends StatefulWidget {
  int whSection = 0;
  OuestionMain({
    Key key,
    @required this.whSection,
  }) : super(key: key);
  @override
  State<OuestionMain> createState() => _OuestionMainState();
}

class _OuestionMainState extends State<OuestionMain> {
  var jsonResult;
  List sentence;
  int MenuSayisi = 0;

  Future<void> getData() async {
    try {
      String data = await DefaultAssetBundle.of(context).loadString(
          "assets/data/data" + widget.whSection.toString() + ".json");
      jsonResult = json.decode(data);
      sentence = jsonResult["questions"];
      int dataSayisi = sentence.length;
      print("----- $dataSayisi");

      setState(() {
        MenuSayisi = (dataSayisi / 15).toInt();
      });
      return Text("");
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: defaultBackgroundColor,
        elevation: 0,
        leading: new IconButton(
          icon: new Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () => Navigator.of(context).pop(),
          color: Colors.black,
        ),
      ),
      backgroundColor: defaultBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Image(
                image: AssetImage("assets/images/logo.png"),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                "Aşağıdaki kelime gruplarından birini seçebilirsin",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Colors.black54,
                    fontSize: 14,
                    fontFamily: "Fjalla One"),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                child: Column(
                  children: [
                    for (var i = 0; i < MenuSayisi; i++)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: MenuWidget(
                              text: (i + 1).toString(),
                              subText: "",
                              whSection: widget.whSection,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuWidget extends StatelessWidget {
  const MenuWidget({
    Key key,
    @required this.text,
    @required this.subText,
    @required this.whSection,
  }) : super(key: key);

  final String text;
  final String subText;
  final int whSection;

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        //margin: EdgeInsets.all(5),
        child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      side: BorderSide(color: Colors.white)))),
          onPressed: () {
            whSentenceGroup = int.parse(text) - 1;
            // Navigator.pushNamed(context, "/questions");
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Question(
                      whSentenceGroup: whSentenceGroup, whSection: whSection)),
            );
          },
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.group_work,
                    color: Colors.blueAccent,
                    size: 56,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 1, 10, 1),
                    child: Text(
                      text,
                      style: TextStyle(
                          fontFamily: "Anton",
                          fontWeight: FontWeight.w800,
                          fontSize: 24,
                          color: Colors.black),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
