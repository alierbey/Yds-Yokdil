import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:math';
import 'constant.dart';

class SimilarWordsPage extends StatefulWidget {
  const SimilarWordsPage({Key key}) : super(key: key);

  @override
  _SimilarWordsPageState createState() => _SimilarWordsPageState();
}

class _SimilarWordsPageState extends State<SimilarWordsPage> {
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
    int start = 0;
    int end = start + 15;
    print("Başlangıc $start son $end");
    for (int i = start; i < end; i++) {
      ids.add(i);
    }
  }

  @override
  void initState() {
    setState(() {
      print("similar.dart");
      fonksiyon();
      randomList = shuffle(ids);
      print("RandomList $randomList");
    });
  }

  @override
  Widget build(BuildContext context) {
    double windowSizeHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: defaultBackgroundColor,
      appBar: AppBar(
        backgroundColor: Color(0xffEEF3F7),
        elevation: 0,
        title: Text(
          "",
          style: TextStyle(color: Colors.grey),
        ),
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xffEEF3F7),
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 5, 20, 20),
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
                        future: DefaultAssetBundle.of(context)
                            .loadString("assets/data/dataSimilar.json"),
                        builder: (context, snapshot) {
                          // Decode the JSON
                          var new_data = json.decode(snapshot.data.toString());
                          print(new_data);

                          if (new_data == null) {
                            return CircularProgressIndicator();
                          } else {
                            print("hangi $_hangiCumle");
                            if (_hangiCumle > 14) {
                              _hangiCumle = 0;
                            }
                            print("yukle");
                            print("ssdf");

                            return Column(
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(20),
                                      child: Text(
                                        // "sf",

                                        new_data["questions"]
                                            [randomList[_hangiCumle]]["words"],
                                        // new_data["questions"][_hangiCumle]
                                        //     ["words"],
                                        // "occupy\ninvade\nconquer\nannex\nraid",
                                        // data[_hangiCumle]["questions"],
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

                                            // if (_hangiCumle == 14) {
                                            //   _veriKaydet(whSentenceGroup);
                                            // }
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
                                                  new_data["questions"]
                                                      [_hangiCumle]["meaning"],
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
