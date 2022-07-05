import 'package:flutter/material.dart';
import 'package:yds_yokdil/blok.dart';
import 'package:yds_yokdil/constant.dart';
import 'dart:math';
import 'dart:convert';
import 'package:yds_yokdil/homepage.dart';
import 'package:yds_yokdil/word_1_page_info.dart';

import 'package:yds_yokdil/word_3_list_section.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:text_to_speech/text_to_speech.dart';
import 'package:http/http.dart' as http;

class WordInternet extends StatefulWidget {
  int kelimeGrubu;
  int whSection;
  WordInternet({
    Key key,
    @required this.kelimeGrubu,
    @required this.whSection,
  }) : super(key: key);

  @override
  _WordInternetState createState() => _WordInternetState();
}

enum TtsState { playing, stopped, paused, continued }

class _WordInternetState extends State<WordInternet> {
  String tamamlandi = "";

  _veriOku() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    tamamlandi = pref.getString("tamamlandi");
    print(" Tamamlananlar :  $tamamlandi");

    setState(() {
      // print("fontRenk");
    });
  }

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

  _veriKaydet(i) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    if (tamamlandi != null) {
      await pref.setString("tamamlandi", tamamlandi + "," + i.toString());
    } else {
      await pref.setString("tamamlandi", i.toString());
    }

    print("--> kelime tamamlama başarılı Kaydedildi " + i.toString());
  }

  int uzunluk = 0;
  bool isLoading = true;

  Future<String> getInternetData() async {
    print("get data");

    String url = urlGlobal + "words/category/" + widget.whSection.toString();

    var response = await http.get(Uri.parse(url));
    data = json.decode(utf8.decode(response.bodyBytes));

    uzunluk = data.length;
    print("Main.dart VeriSayısı : ${data.length}");

    setState(() {
      isLoading = false; //setting state to false after data loaded
    });
  }

  @override
  void initState() {
    setState(() {
      print("words_internet.dart");
      _veriOku();
      fonksiyon();
      randomList = shuffle(ids);
      print(randomList);
      getInternetData();
    });
  }

  @override
  Widget build(BuildContext context) {
    TextToSpeech tts = TextToSpeech();
    List language = ['en-US', 'tr-TR'];

    double windowSizeHeight = MediaQuery.of(context).size.height;
    return Scaffold(
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
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Center(
                          child: isLoading
                              ? CircularProgressIndicator()
                              //loading widget goes here
                              : Text(
                                  data[_hangiCumle]["word"],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.white,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        margin: new EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: isLoading
                                  ? CircularProgressIndicator()
                                  //loading widget goes here
                                  : Text(
                                      data[_hangiCumle]["wordMeaning"],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                        color: Color(0xff9B54E4),
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: isLoading
                            ? CircularProgressIndicator()
                            //loading widget goes here
                            : Text(
                                data[_hangiCumle]["wordSentence"],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: Color(0xffffffff),
                                ),
                              ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            if (_hangiCumle != 15) {
                              _hangiCumle++;
                            } else {
                              Navigator.pop(context);
                            }
                          });
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [Color(0xff7D77FB), Color(0xffAC39EC)],
                            ),
                          ),
                          padding: EdgeInsets.all(20),
                          child: Center(
                            child: Text(
                              "Sonraki",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
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
        child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      side: BorderSide(color: Colors.white)))),
          onPressed: () {
            // Navigator.pushNamed(context, "/");
            if (text == "Tekrar") {
              hangiCumle = 0;

              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => WordListSection(
                          whSection: 0,
                        )),
              );

              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //       builder: (context) => Word(
              //             kelimeGrubu: null,
              //             whSection: null,
              //           )),
              // );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            }
          },
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
