import 'package:flutter/material.dart';
import 'package:yds_yokdil/wordmainsecond.dart';
import 'words.dart';
import 'constant.dart';
import 'dart:convert';

class WordMain extends StatefulWidget {
  int whSection = 0;
  WordMain({
    Key key,
    @required this.whSection,
  }) : super(key: key);

  @override
  _WordMainState createState() => _WordMainState();
}

class _WordMainState extends State<WordMain> {
  var jsonResult;

  List sentence;
  int MenuSayisi = 0;

  List<int> text = [1, 2, 3, 4];

  // List<String> onlyword = [];
  List<String> kelimeler = [];

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
      //return MemberLogin.withError("$error");
    }
  }

  @override
  void initState() {
    super.initState();
    print(widget.whSection);
    print("wordmainde");
    getData();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Kelimeler",
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
              Column(
                children: [
                  // for (var i in kelimeler)
                  for (var i = 0; i < MenuSayisi; i++)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: MenuWidget(
                              text: (i + 1).toString(),
                              whSection: widget.whSection),
                        ),
                      ],
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

class MenuWidget extends StatelessWidget {
  const MenuWidget({
    Key key,
    @required this.text,
    @required this.whSection,
  }) : super(key: key);

  final String text;
  final int whSection;

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5),
        //margin: EdgeInsets.all(5),
        child: FlatButton(
          color: Colors.white,
          padding: EdgeInsets.all(1),
          onPressed: () {
            whSentenceGroup = int.parse(text) - 1;
            // Navigator.pushNamed(context, "/wordsmainsecond");
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => WordMainSecond(
                    kelimeGrubu: whSentenceGroup, whSection: whSection)));
          },
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(padding: EdgeInsets.only(top: 2)),
              Row(
                children: [
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 10, 5),
                      child: Text(
                        text,
                        style: TextStyle(
                            fontFamily: "Anton",
                            fontWeight: FontWeight.w800,
                            fontSize: 20,
                            color: Colors.grey),
                      ),
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
