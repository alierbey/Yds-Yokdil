import 'package:flutter/material.dart';
import 'words.dart';
import 'constant.dart';
import 'dart:convert';
import 'wordmain.dart';

class WordMainSecond extends StatefulWidget {
  int kelimeGrubu;
  int whSection;
  WordMainSecond({
    Key key,
    @required this.kelimeGrubu,
    @required this.whSection,
  }) : super(key: key);
  @override
  _WordMainSecondState createState() => _WordMainSecondState();
}

class _WordMainSecondState extends State<WordMainSecond> {
  var jsonResult;

  List sentence;

  List<int> text = [1, 2, 3, 4];

  // List<String> onlyword = [];
  List<String> kelimeler = [];

  Future<void> getData() async {
    try {
      var onlyword = "";
      String data = await DefaultAssetBundle.of(context).loadString(
          "assets/data/data" + widget.whSection.toString() + ".json");
      jsonResult = json.decode(data);
      // print("----");
      sentence = jsonResult["questions"];
      // print(sentence[0]["question"]);

      for (var i = widget.kelimeGrubu * 15;
          i < widget.kelimeGrubu * 15 + 15;
          i++) {
        kelimeler.add(sentence[i]["question"]);
      }
      // kelimeler.add(onlyword);

      //print("user API response - : $fromJson(response.data)}; ");
      setState(() {
        //apiCall = false;
      });
      //return MemberLogin.fromJson(response.data);
      return Text("yeapppppp");
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      //return MemberLogin.withError("$error");
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
        title: Text(
          "",
          style: TextStyle(color: Colors.grey),
        ),
        backgroundColor: defaultBackgroundColor,
        elevation: 0,
        leading: new IconButton(
          icon: new Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () => Navigator.pop(context),
          // onPressed: () => Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //       builder: (context) => WordMain(
          //             whSection: 0,
          //           )),
          // ),
          color: Colors.black,
        ),
      ),
      backgroundColor: defaultBackgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(beyHorizontalPadding),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: beyHorizontalPadding),
                child: Image(
                  image: AssetImage("assets/images/logo.png"),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  "Aşağıdaki kelime gruplarından birini seçebilirsiniz.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: Colors.black54,
                      fontSize: 14,
                      fontFamily: "Fjalla One"),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 30),
                padding: EdgeInsets.fromLTRB(5, 20, 5, 20),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    TextButton(
                      onPressed: () {
                        // whSentenceGroup = widget.kelimeGrubu;
                        // Navigator.pushNamed(context, "/words");

                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => Word(
                                kelimeGrubu: whSentenceGroup,
                                whSection: widget.whSection)));
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width / 1.2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [Color(0xff7D77FB), Color(0xffAC39EC)],
                          ),
                        ),
                        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                        child: Center(
                          child: Text(
                            "Başla",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Bu grupta olan kelimeler"),
                    for (var i in kelimeler)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.black12,
                                borderRadius: BorderRadius.circular(5)),
                            width: MediaQuery.of(context).size.width / 1.5,
                            margin: EdgeInsets.all(3),
                            child: Text(
                              i,
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
