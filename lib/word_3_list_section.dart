import 'package:flutter/material.dart';
import 'package:yds_yokdil/word_4_internet.dart';
import 'words.dart';
import 'constant.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class WordListSection extends StatefulWidget {
  int kelimeGrubu;
  int whSection;
  WordListSection({
    Key key,
    @required this.kelimeGrubu,
    @required this.whSection,
  }) : super(key: key);
  @override
  _WordListSectionState createState() => _WordListSectionState();
}

class _WordListSectionState extends State<WordListSection> {
  var jsonResult;

  List sentence;
  List wordList;

  List<int> text = [1, 2, 3, 4];

  // List<String> onlyword = [];
  List<String> kelimeler = [];

  int uzunluk = 0;
  bool isLoading = true;
  List<dynamic> data;

  Future<String> getInternetData() async {
    print("get data");

    String url = "http://localhost:8080/api/v1/words/category/" +
        widget.whSection.toString();

    var response = await http.get(Uri.parse(url));
    data = json.decode(response.body);
    if (data != null) {
      uzunluk = data.length;
      print("Main.dart VeriSayısı : ${data.length}");

      //wordList = data[2];
      print(data[0]["word"]);

      for (var i = widget.kelimeGrubu * 15;
          i < widget.kelimeGrubu * 15 + 15;
          i++) {
        kelimeler.add(data[i]["word"]);
      }
    }
    setState(() {
      isLoading = false; //setting state to false after data loaded
    });
  }

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

    // getData();
    getInternetData();
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
                  "Kelimeleri öğrenmek için başlaya basınız.",
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
                            builder: (context) => WordInternet(
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
