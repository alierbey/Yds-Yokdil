import 'package:flutter/material.dart';
import 'constant.dart';
import 'dart:convert';
import 'dart:math';

class Block extends StatefulWidget {
  @override
  _BlockState createState() => _BlockState();
}

class _BlockState extends State<Block> {
  List sentenceArray;
  List translateArray;
  List correctTranslate;
  int hangiCumle = 0;

  var ids = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
  var randomList = [];

  List shuffle(List items) {
    var random = new Random();

    // Go through all elements.
    for (var i = items.length - 1; i > 0; i--) {
      // Pick a pseudorandom number according to the list length
      var n = random.nextInt(i + 1);

      var temp = items[i];
      items[i] = items[n];
      items[n] = temp;
    }

    return items;
  }

  var jsonResult;

  Future<void> getData() async {
    try {
      String data = await DefaultAssetBundle.of(context).loadString(
          "assets/data/data" + whSentenceGroup.toString() + ".json");
      jsonResult = json.decode(data);
      // print("user API response - : $jsonResult ");
      // print("----");
      sentenceArray =
          jsonResult["questions"][randomList[hangiCumle]]["sentenceArray"];
      translateArray =
          jsonResult["questions"][randomList[hangiCumle]]["translateArray"];
      correctTranslate =
          jsonResult["questions"][randomList[hangiCumle]]["correctTranslate"];
      // print(jsonResult["questions"][randomList[hangiCumle]]["sentenceArray"]);
      // print(jsonResult["questions"][randomList[hangiCumle]]["translateArray"]);
      // print(
      //     jsonResult["questions"][randomList[hangiCumle]]["correctTranslate"]);
      //print("user API response - : $fromJson(response.data)}; ");
      setState(() {
        //apiCall = false;
      });
      //return MemberLogin.fromJson(response.data);

    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      //return MemberLogin.withError("$error");
    }
  }

  // var sentence = [
  //   "Most of all,",
  //   "she did not know",
  //   "even",
  //   "my name",
  //   "correctly"
  // ];
  // var translate = ["En önemlisi de,", "bilmiyordu", "bile", "ismimi", "doğru"];
  // var correctTranslate = [0, 3, 2, 4, 1];
  String _targetImageUrl1;
  String _targetImageUrl2;
  String _targetText3;

  bool yeniDrag = false;

  @override
  void initState() {
    super.initState();
    randomList = shuffle(ids);

    getData();
  }

  @override
  Widget build(BuildContext context) {
    print("s $sentenceArray");
    print("s $translateArray");
    print("s $correctTranslate");
    // sentenceArray =
    //     jsonResult["questions"][randomList[hangiCumle]]["sentenceArray"];
    // translateArray =
    //     jsonResult["questions"][randomList[hangiCumle]]["translateArray"];
    // correctTranslate =
    //     jsonResult["questions"][randomList[hangiCumle]]["correctTranslate"];
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
      body: Padding(
        padding: const EdgeInsets.fromLTRB(
            beyHorizontalPadding, 20, beyHorizontalPadding, 5),
        child: Center(
          child: sentenceArray != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    sentenceArray.length > 0
                        ? NewWidget(
                            index: 0,
                            sentence: sentenceArray[0],
                            translate: translateArray[0],
                            renk: Colors.blue,
                          )
                        : Container(),
                    sentenceArray.length > 1
                        ? NewWidget(
                            index: 1,
                            sentence: sentenceArray[1],
                            translate: translateArray[1],
                            renk: Colors.black,
                          )
                        : Container(),

                    sentenceArray.length > 2
                        ? NewWidget(
                            index: 2,
                            sentence: sentenceArray[2],
                            translate: translateArray[2],
                            renk: Colors.purple,
                          )
                        : Container(),

                    sentenceArray.length > 3
                        ? NewWidget(
                            index: 3,
                            sentence: sentenceArray[3],
                            translate: translateArray[3],
                            renk: Colors.red,
                          )
                        : Container(),

                    sentenceArray.length > 4
                        ? NewWidget(
                            index: 4,
                            sentence: sentenceArray[4],
                            translate: translateArray[4],
                            renk: Colors.green,
                          )
                        : Container(),

                    // _targetText3 != null ? Text("yeap") : Text("hopp"),
                    // NewWidget(
                    //   index: 4,
                    //   sentence: sentenceArray[4],
                    //   translate: translate[4],
                    //   renk: Colors.green,
                    // ),

                    SizedBox(height: 50),
                    ////////////////////////
                    /// Target
                    //_targetText3 != null ? Text("yeap") : Text("hopp"),

                    Row(
                      children: [
                        translateArray.length > 0
                            ? DragWord(
                                key: UniqueKey(),
                                translate: translateArray[0],
                                index: correctTranslate[0],
                                yeni: true,
                              )
                            : Container(),
                        translateArray.length > 1
                            ? DragWord(
                                key: UniqueKey(),
                                translate: translateArray[1],
                                index: correctTranslate[1],
                                yeni: true,
                              )
                            : Container(),
                      ],
                    ),

                    Row(
                      children: [
                        translateArray.length > 2
                            ? DragWord(
                                key: UniqueKey(),
                                translate: translateArray[2],
                                index: correctTranslate[2],
                                yeni: true,
                              )
                            : Container(),
                        translateArray.length > 3
                            ? DragWord(
                                translate: translateArray[3],
                                index: correctTranslate[3],
                                yeni: true,
                              )
                            : Container(),
                      ],
                    ),

                    Row(
                      children: [
                        translateArray.length > 4
                            ? DragWord(
                                key: UniqueKey(),
                                translate: translateArray[4],
                                index: correctTranslate[4],
                                yeni: true,
                              )
                            : Container(),
                        translateArray.length > 5
                            ? DragWord(
                                key: UniqueKey(),
                                translate: translateArray[5],
                                index: correctTranslate[5],
                                yeni: true,
                              )
                            : Container(),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: hangiCumle != 0
                                ? ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        if (hangiCumle > 0) {
                                          hangiCumle--;
                                          print(hangiCumle);

                                          if (yeniDrag == true) {
                                            yeniDrag = false;
                                          } else {
                                            yeniDrag = true;
                                          }

                                          getData();
                                        }
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        Icon(Icons.arrow_left_outlined),
                                      ],
                                    ),
                                  )
                                : Text("")),
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: hangiCumle != 9
                                ? ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        if (hangiCumle < 9) {
                                          hangiCumle++;
                                          print(hangiCumle);

                                          if (yeniDrag == true) {
                                            yeniDrag = false;
                                          } else {
                                            yeniDrag = true;
                                          }
                                          getData();
                                        }
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        Icon(Icons.arrow_right_outlined),
                                      ],
                                    ),
                                  )
                                : Text(" ")),
                      ],
                    )

                    // DragWord(
                    //   translate: translate[4],
                    //   index: correctTranslate[4],
                    // ),
                  ],
                )
              : Text("Hazırlanıyor..."),
        ),
      ),
    );
  }
}

bool yeniWidgetOlustur = false;

class DragWord extends StatefulWidget {
  const DragWord({
    Key key,
    @required this.translate,
    @required this.index,
    @required this.yeni,
  }) : super(key: key);

  final String translate;
  final int index;
  final bool yeni;

  @override
  _DragWordState createState() => _DragWordState();
}

class _DragWordState extends State<DragWord> {
  String translate = "";
  //int index;

  Color renk = Colors.amber;

  int a = 12;

  void renkAta() {
    print(">----");
    print(widget.index);
    print("----<");
    switch (widget.index) {
      case 0:
        renk = Colors.blue;
        break;
      case 1:
        renk = Colors.black;
        break;
      case 2:
        renk = Colors.purple;
        break;
      case 3:
        renk = Colors.red;
        break;
      case 4:
        renk = Colors.green;
        break;
      case 5:
        renk = Colors.yellow;
        break;
      default:
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      //translate = null;
      renkAta();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DragTarget<String>(
      onAccept: (value) {
        translate = value;
      },
      builder: (context, candidateData, rejectedData) {
        print("#####");
        print(candidateData);
        return new Container(
            width: (MediaQuery.of(context).size.width - 40) * 0.5,
            height: 60,
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(width: 1.0, color: renk),
                bottom: BorderSide(width: 5.0, color: renk),
              ),
              color: Colors.white,
            ),
            alignment: Alignment.center,
            child: translate != null
                ? Text(
                    translate,
                    style: TextStyle(
                        fontSize: 14, color: renk, fontWeight: FontWeight.w700),
                  )
                : Container());
      },
      onWillAccept: (value) {
        return true;
      },
    );
  }
}

class NewWidget extends StatelessWidget {
  const NewWidget({
    Key key,
    @required this.index,
    @required this.sentence,
    @required this.translate,
    @required this.renk,
  }) : super(key: key);

  final int index;
  final String sentence;
  final String translate;
  final Color renk;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Draggable<String>(
        data: translate,
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: defaultBackgroundColor,
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: Text(
            sentence,
            style: TextStyle(
              fontSize: 22,
              color: renk,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        // The widget to show under the pointer when a drag is under way
        feedback: Opacity(
          opacity: 1,
          child: Container(
            color: Colors.white,
            alignment: Alignment.center,
            child: Text(
              translate,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 24,
                color: renk,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class NextButton extends StatefulWidget {
  @override
  _NextButtonState createState() => _NextButtonState();
}

class _NextButtonState extends State<NextButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            yeniWidgetOlustur = true;
          });
        },
        child: Row(
          children: [
            Icon(Icons.arrow_right_outlined),
          ],
        ),
      ),
    );
  }
}
