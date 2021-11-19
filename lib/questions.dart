import 'package:flutter/material.dart';
import 'package:yds_yokdil/constant.dart';
import 'dart:math';
import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';

import 'package:yds_yokdil/homepage.dart';

class Question extends StatefulWidget {
  int whSection = 0;
  int whSentenceGroup = 0;
  Question({
    Key key,
    @required this.whSentenceGroup,
    @required this.whSection,
  }) : super(key: key);
  @override
  _QuestionState createState() => _QuestionState();
}

enum TtsState { playing, stopped, paused, continued }

class _QuestionState extends State<Question> {
  AudioCache _audioCache = new AudioCache();

  // Ekrana gelen sorunun indisini verir
  int _hangiCumle = 0;

  List<dynamic> data;

  // Gelecek olan 15 sorunun olduğu listeyi
  // random bir şekilde karıştırmak için kullanıyorum
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

  // 15 soruluk listenin elemanlarını tutan değişken
  var ids = [];
  // ids belirlendikten sonra random bir şekilde karıştırlan liste
  var randomList = [];
  // cevapların random bir şekilde karıştırıldığı liste
  var randomAnswerIds = [];

  void fonksiyon() {
    int start = 15 * whSentenceGroup;
    int end = start + 15;
    print("Başlangıc $start son $end");
    for (int i = start; i < end; i++) {
      ids.add(i);
    }
  }

  List<dynamic> fonksiyonCevapMix() {
    if (_hangiCumle < randomList.length) {
      print("---------- $_hangiCumle. ------------");
      randomAnswerIds = [];
      print("$whSentenceGroup. gruptaki sorular");
      print("Listenin $_hangiCumle. sırasındaki cümle");
      var cumleNo = randomList[_hangiCumle];
      print("Bu cümle json dosyasındaki $cumleNo. cümle");
      int start = 15 * whSentenceGroup;
      randomAnswerIds.add(randomList[_hangiCumle]);
      var random = new Random();
      while (randomAnswerIds.length < 4) {
        var n = random.nextInt(15);
        bool mevcut = false;
        for (var i in randomAnswerIds) {
          if (i == start + n) {
            mevcut = true;
          }
        }
        if (!mevcut) {
          randomAnswerIds.add(start + n);
        }
      }
      randomAnswerIds = shuffle(randomAnswerIds);
      print(randomAnswerIds);
      return randomAnswerIds;
    }
  }

  List sentenceArray;
  var jsonResult;

  Future<void> getData() async {
    try {
      String data = await DefaultAssetBundle.of(context)
          .loadString("assets/data/data.json");
      jsonResult = json.decode(data);
      sentenceArray = jsonResult["questions"][0]["sentenceArray"];
      print(jsonResult["questions"][0]["sentenceArray"]);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  @override
  void initState() {
    setState(() {
      _audioCache = AudioCache(
        // prefix: 'audio/',
        fixedPlayer: AudioPlayer()..setReleaseMode(ReleaseMode.STOP),
      );

      fonksiyon();
      randomList = shuffle(ids);
      randomAnswerIds = fonksiyonCevapMix();
      print(randomList);
    });
  }

  int secenek0 = 2;
  int secenek1 = 2;
  int secenek2 = 2;
  int secenek3 = 2;

  void cevap(int whCevap) {
    if (randomList[_hangiCumle] == randomAnswerIds[whCevap]) {
      _audioCache.play('audio/correct.mp3');
      islemYap(whCevap, 1);

      Future.delayed(const Duration(milliseconds: 1000), () {
        setState(() {
          islemYap(whCevap, 2);
          _hangiCumle++;
          fonksiyonCevapMix();
        });
      });
    } else {
      _audioCache.play('audio/wrong.mp3');
      print("yanlış cevap");

      // yanlış cevap verilen sorunuyu listenin sonuna ekleyerek tekrar sorulmasını sağlayacağız.
      randomList.add(randomList[_hangiCumle]);

      Future.delayed(const Duration(milliseconds: 100), () {
        setState(() {
          islemYap(whCevap, 0);
        });
      });

      // doğru cevabu bulup işaretleyiyoruz
      Future.delayed(const Duration(milliseconds: 1000), () {
        setState(() {
          // diger şıklardan hangisinin doğru olduğunu bulmak için her şıkkı karşılaştırıyoruz.
          // randomList[_hangiCumle] nin çıktısı [4, 7, 11, 1, 8, 3, 9, 2, 6, 12, 5, 10, 14, 13, 0]
          // randomAnswerIds nin [8, 7, 3, 4] çıktısı. hangiCumle 0. cümledir. böylece yukarıdaki uzun listede ilk soru
          // olan 4 ile random 3 tane cevap gelmiştir. 8,7,3,4 gibi. bu durumda randomAnswerIds içinde dolaşıyoruz ve
          // 4 ün indexini bulmamız gerekiyor. Aşağıdaki kod bunu gerçekleştirmekte.
          for (var i = 0; i < randomAnswerIds.length; i++) {
            if (randomAnswerIds[i] == randomList[_hangiCumle]) {
              islemYap(i, 1);
              print("dogru cevap listenin $i sıkkında");
            }
          }
        });
      });

      // Diğer soruya geçmemiz gerekiyor. Ve geçerken işaretlenen şıkları temizlememiz gerekiyor.
      Future.delayed(const Duration(milliseconds: 2500), () {
        setState(() {
          print("sıfırlandı ve diğer soruya geçildi");
          secenek0 = 2;
          secenek1 = 2;
          secenek2 = 2;
          secenek3 = 2;
          _hangiCumle++;
          fonksiyonCevapMix();
        });
      });
    }
  }

  void islemYap(int whOption, int process) {
    switch (whOption) {
      case 0:
        secenek0 = process;
        break;
      case 1:
        secenek1 = process;
        break;
      case 2:
        secenek2 = process;
        break;
      case 3:
        secenek3 = process;
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: new IconButton(
            icon: new Icon(
              Icons.arrow_back_ios,
            ),
            onPressed: () => Navigator.of(context).pop(),
            color: Colors.black,
          ),
          title: Text(
            "Quiz",
            style: TextStyle(color: Colors.grey),
          ),
          backgroundColor: Color(0xffEEF3F7),
          elevation: 0,
        ),
        body: Center(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // üst taraftaki soruların ilerlediğini göstermek için kullanılan containerlar
                // eğer soruların gösterimi bitti ise kaldırıyoruz.

                (_hangiCumle < randomList.length)
                    ? Container(
                        padding: EdgeInsets.all(5),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              for (var i = 0; i < randomList.length; i++)
                                Container(
                                    margin: EdgeInsets.symmetric(horizontal: 3),
                                    width: 5,
                                    height: 5,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3),
                                      color: (i < _hangiCumle)
                                          ? Color(0xff797CFC)
                                          : Colors.black12,
                                    ))
                            ],
                          ),
                        ),
                      )
                    : Container(),
                SizedBox(
                  height: 30,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xffEEF3F7),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                                    .loadString('assets/data/data' +
                                        widget.whSection.toString() +
                                        '.json'),
                                builder: (context, snapshot) {
                                  // Decode the JSON
                                  var new_data =
                                      json.decode(snapshot.data.toString());

                                  if (new_data == null) {
                                    return CircularProgressIndicator();
                                  } else if (_hangiCumle == randomList.length) {
                                    return FinishWidget(
                                      whSection: widget.whSection,
                                      whSentenceGrup: widget.whSentenceGroup,
                                    );
                                  } else {
                                    return Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(20),
                                          child: Text(
                                            new_data["questions"]
                                                    [randomList[_hangiCumle]]
                                                ["question"],
                                            //data[_hangiCumle]["question"],
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
                                                cevap(0);
                                              });
                                            },
                                            padding: EdgeInsets.all(20),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            color: secenek0 == 2
                                                ? Colors.white
                                                : secenek0 == 1
                                                    ? Colors.lime
                                                    : Colors.red,
                                            // secenek0 ? Colors.lime : Colors.white,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                width: double.infinity,
                                                child: Text(
                                                  new_data["questions"]
                                                          [randomAnswerIds[0]]
                                                      ["answers"],
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16,
                                                    color: Color(0xff9B54E4),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: FlatButton(
                                            onPressed: () {
                                              setState(() {
                                                cevap(1);
                                              });
                                            },
                                            padding: EdgeInsets.all(20),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            color: secenek1 == 2
                                                ? Colors.white
                                                : secenek1 == 1
                                                    ? Colors.lime
                                                    : Colors.red,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                width: double.infinity,
                                                child: Text(
                                                  new_data["questions"]
                                                          [randomAnswerIds[1]]
                                                      ["answers"],
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16,
                                                    color: Color(0xff9B54E4),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: FlatButton(
                                            onPressed: () {
                                              setState(() {
                                                cevap(2);
                                              });
                                            },
                                            padding: EdgeInsets.all(20),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            color: secenek2 == 2
                                                ? Colors.white
                                                : secenek2 == 1
                                                    ? Colors.lime
                                                    : Colors.red,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                width: double.infinity,
                                                child: Text(
                                                  new_data["questions"]
                                                          [randomAnswerIds[2]]
                                                      ["answers"],
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16,
                                                    color: Color(0xff9B54E4),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: FlatButton(
                                            onPressed: () {
                                              setState(() {
                                                cevap(3);
                                              });
                                            },
                                            padding: EdgeInsets.all(20),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            color: secenek3 == 2
                                                ? Colors.white
                                                : secenek3 == 1
                                                    ? Colors.lime
                                                    : Colors.red,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                width: double.infinity,
                                                child: Text(
                                                  new_data["questions"][
                                                          randomAnswerIds[
                                                              3]]["answers"]
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16,
                                                    color: Color(0xff9B54E4),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                    //return Text(new_data["questions"][4]["question"]);
                                  }
                                }),
                          ),
                        ),
                      ],
                    ),
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
  final int whSection;
  final int whSentenceGrup;
  FinishWidget({
    Key key,
    @required this.whSentenceGrup,
    @required this.whSection,
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
            whSection: whSection,
            whSentenceGrup: whSentenceGrup,
          ),
        ),
        Expanded(
          child: NewWidget(
            menuIcon: Icons.home,
            text: "Ana Sayfa",
            subText: "Diğer seçeneklere göz atabilirsin",
            whSection: whSection,
            whSentenceGrup: whSentenceGrup,
          ),
        ),
      ],
    );
  }
}

// En son sayfada çıkan tekrar et ve anasayfa menüleri için
class NewWidget extends StatelessWidget {
  const NewWidget({
    Key key,
    @required this.text,
    @required this.subText,
    @required this.menuIcon,
    @required this.whSentenceGrup,
    @required this.whSection,
  }) : super(key: key);

  final String text;
  final String subText;
  final IconData menuIcon;
  final int whSection;
  final int whSentenceGrup;

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Container(
        height: screenHeight * 0.32,
        padding: EdgeInsets.symmetric(horizontal: 10),
        //margin: EdgeInsets.all(5),
        child: FlatButton(
          color: Colors.white,
          padding: EdgeInsets.all(10),
          onPressed: () {
            // Navigator.pushNamed(context, "/");
            if (text == "Tekrar") {
              // Navigator.pushNamed(context, "/questions");
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Question(
                          whSection: whSection,
                          whSentenceGroup: whSentenceGrup,
                        )),
              );
            } else {
              // Navigator.pushNamed(context, "/homepage");
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            }
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
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
                      fontSize: 20,
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
