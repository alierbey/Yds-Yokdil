import 'package:flutter/material.dart';
import 'package:yds_yokdil/constant.dart';
import 'dart:math';
import 'dart:convert';
import 'package:yds_yokdil/homepage.dart';

class Word extends StatefulWidget {
  int kelimeGrubu;
  int whSection;
  Word({
    Key key,
    @required this.kelimeGrubu,
    @required this.whSection,
  }) : super(key: key);

  @override
  _WordState createState() => _WordState();
}

enum TtsState { playing, stopped, paused, continued }

class _WordState extends State<Word> {
  int _hangiCumle = 0;

  List<dynamic> data;

  List shuffle(List items) {
    var random = new Random();
    for (var i = items.length - 1; i > 0; i--) {
      var n = random.nextInt(i + 1);

      var temp = items[i];
      items[i] = items[n];
      items[n] = temp;
    }

    return items;
  }

  var ids = [];
  var randomList = [];
  var randomAnswerIds = [];

  void fonksiyon() {
    int start = 15 * whSentenceGroup;
    int end = start + 15;
    print("Başlangıc $start son $end");
    for (int i = start; i < end; i++) {
      ids.add(i);
    }
  }

  @override
  void initState() {
    setState(() {
      fonksiyon();
      randomList = shuffle(ids);
      print(randomList);
    });
  }

  @override
  Widget build(BuildContext context) {
    double windowSizeHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Kelimeler",
          style: TextStyle(color: Colors.grey),
        ),
        leading: new IconButton(
          icon: new Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () => Navigator.of(context).pop(),
          color: Colors.black,
        ),
        backgroundColor: Color(0xffEEF3F7),
        elevation: 0,
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xffEEF3F7),
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, (windowSizeHeight / 10), 20, 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 60),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    gradient: LinearGradient(colors: [
                      const Color(0xff797CFC).withOpacity(0.3),
                      const Color(0xffAF35EB).withOpacity(0.3),
                    ]),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    gradient: LinearGradient(colors: [
                      const Color(0xff797CFC).withOpacity(0.6),
                      const Color(0xffAF35EB).withOpacity(0.6),
                    ]),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment(0.8,
                          0.0), // 10% of the width, so there are ten blinds.
                      colors: [
                        const Color(0xffAF35EB),
                        const Color(0xff797CFC)
                      ], // red to yellow
                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        spreadRadius: 5,
                        blurRadius: 50,
                        offset: Offset(0, 5),
                      )
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 30, 10, 30),
                    child: FutureBuilder(
                        future: DefaultAssetBundle.of(context).loadString(
                            "assets/data/data" +
                                widget.whSection.toString() +
                                ".json"),
                        builder: (context, snapshot) {
                          // Decode the JSON
                          var new_data = json.decode(snapshot.data.toString());

                          if (new_data == null) {
                            return CircularProgressIndicator();
                          } else if (_hangiCumle == 15) {
                            return FinishWidget();
                          } else {
                            return Column(
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(20),
                                      child: Text(
                                        new_data["questions"]
                                                [randomList[_hangiCumle]]
                                            ["question"],
                                        //data[_hangiCumle]["questions"],
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: FlatButton(
                                        onPressed: () {
                                          setState(() {
                                            _hangiCumle++;
                                          });
                                        },
                                        padding: EdgeInsets.all(20),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        color: Colors.white,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            width: double.infinity,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  new_data["questions"][
                                                          randomList[
                                                              _hangiCumle]]
                                                      ["answers"],
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16,
                                                    color: Color(0xff9B54E4),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            new_data["questions"]
                                                    [randomList[_hangiCumle]]
                                                ["sentence"],
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                              color: Color(0xffffffff),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        setState(() {
                                          _hangiCumle++;
                                        });
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          gradient: LinearGradient(
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            colors: [
                                              Color(0xff7D77FB),
                                              Color(0xffAC39EC)
                                            ],
                                          ),
                                        ),
                                        padding: EdgeInsets.all(20),
                                        child: Center(
                                          child: Text(
                                            "Sonraki",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                            //return Text(new_data["questions"][4]["Word"]);
                          }
                        }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FinishWidget extends StatelessWidget {
  const FinishWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: NewWidget(
            menuIcon: Icons.repeat,
            text: "Tekrar",
            subText: "Tekrar yaparak daha başarılı olabilirsin",
          ),
        ),
        Expanded(
          child: NewWidget(
            menuIcon: Icons.home,
            text: "Ana Sayfa",
            subText: "Diğer seçeneklere göz atabilirsin",
          ),
        ),
      ],
    );
  }
}

class NewWidget extends StatelessWidget {
  const NewWidget({
    Key key,
    @required this.text,
    @required this.subText,
    @required this.menuIcon,
  }) : super(key: key);

  final String text;
  final String subText;
  final IconData menuIcon;

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Container(
        height: screenHeight * 0.32,
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: FlatButton(
          color: Colors.white,
          padding: EdgeInsets.all(10),
          onPressed: () {
            // Navigator.pushNamed(context, "/");
            if (text == "Tekrar") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Word()),
              );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            }
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(padding: EdgeInsets.only(top: 20)),
              Icon(
                menuIcon,
                color: Colors.lightBlue,
                size: 64,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 15, 10, 5),
                child: Text(
                  text,
                  style: TextStyle(
                      fontFamily: "Anton",
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
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
                      fontSize: 14,
                      color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}