import 'package:flutter/material.dart';
import 'questions.dart';
import 'constant.dart';

class BlockMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Blok Çeviri",
          style: TextStyle(color: Colors.grey),
        ),
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
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Image(
                image: AssetImage("assets/images/logo.png"),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Text(
                "Aşağıdaki kelime gruplarından birini seçebilirsin",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Colors.black54,
                    fontSize: 16,
                    fontFamily: "Fjalla One"),
              ),
            ),
            Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: MenuWidget(
                          text: "1",
                          subText: "",
                        ),
                      ),
                      Expanded(
                        child: MenuWidget(
                          text: "2",
                          subText: "",
                        ),
                      ),
                      Expanded(
                        child: MenuWidget(
                          text: "3",
                          subText: "",
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: MenuWidget(
                          text: "4",
                          subText: "",
                        ),
                      ),
                      Expanded(
                        child: MenuWidget(
                          text: "5",
                          subText: "",
                        ),
                      ),
                      Expanded(
                        child: MenuWidget(
                          text: "6",
                          subText: "",
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: MenuWidget(
                          text: "7",
                          subText: "",
                        ),
                      ),
                      Expanded(
                        child: MenuWidget(
                          text: "8",
                          subText: "",
                        ),
                      ),
                      Expanded(
                        child: MenuWidget(
                          text: "9",
                          subText: "",
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: MenuWidget(
                          text: "10",
                          subText: "",
                        ),
                      ),
                      Expanded(
                        child: MenuWidget(
                          text: "11",
                          subText: "",
                        ),
                      ),
                      Expanded(
                        child: MenuWidget(
                          text: "12",
                          subText: "",
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: MenuWidget(
                          text: "13",
                          subText: "",
                        ),
                      ),
                      Expanded(
                        child: MenuWidget(
                          text: "14",
                          subText: "",
                        ),
                      ),
                      Expanded(
                        child: MenuWidget(
                          text: "15",
                          subText: "",
                        ),
                      ),
                    ],
                  ),
                ],
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
  }) : super(key: key);

  final String text;
  final String subText;

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5),
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
            Navigator.pushNamed(context, "/block");
          },
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(padding: EdgeInsets.all(5)),
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
                      fontSize: 20,
                      color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
