import 'package:flutter/material.dart';
import 'package:yds_yokdil/word_3_list_section.dart';
import 'package:flutter/services.dart';
import 'words.dart';
import 'constant.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'dart:io' show Platform;
import 'satinal.dart';
import 'package:http/http.dart' as http;

class WordListGrup extends StatefulWidget {
  int whSection = 0;
  WordListGrup({
    Key key,
    @required this.whSection,
  }) : super(key: key);

  @override
  _WordListGrupState createState() => _WordListGrupState();
}

class _WordListGrupState extends State<WordListGrup> {
  PurchaserInfo purchaserInfo;

  Future<void> initPlatformState() async {
    await Purchases.setDebugLogsEnabled(true);
    await Purchases.setup("appl_HKMOsgBnRRykUfiWIMhBDMcqsHY");
    purchaserInfo = await Purchases.getPurchaserInfo();
  }

  Future<bool> userIsPremium() async {
    purchaserInfo = await Purchases.getPurchaserInfo();
    return purchaserInfo.entitlements.all["premium"] != null &&
        purchaserInfo.entitlements.all["premium"].isActive;
  }

  Future<void> makePurchases(Package package) async {
    try {
      purchaserInfo = await Purchases.purchasePackage(package);
      print(purchaserInfo);
    } on PlatformException catch (e) {
      var errorCode = PurchasesErrorHelper.getErrorCode(e);
      if (errorCode != PurchasesErrorCode.purchaseCancelledError) {
        print("########");
        print(e.message);
        // Scaffold.of(context).showSnackBar(SnackBar(content: Text(e.message)));
      }
    }
  }

  String tamamlandi = "";
  List tamamlananListem = [];

  _veriOku() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    tamamlandi = pref.getString("tamamlandi");
    print(" Tamamlananlar :  $tamamlandi");

    if (tamamlandi != null) {
      tamamlananListem = tamamlandi.split(",");
      print(tamamlananListem);
    }

    setState(() {
      // print("fontRenk");
    });
  }

  _veriKaydet() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    // await pref.setString("tamamlandi", tamamlandi + ",2");
    // print("Tamamlanan Kaydedildi");
  }

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
    }

    setState(() {
      isLoading = false; //setting state to false after data loaded

      MenuSayisi = (uzunluk / 15).toInt();
    });
  }

  bool kontrol(i) {
    if (tamamlandi == null) {
      return false;
    } else {
      return tamamlandi.contains(i.toString());
    }
  }

  bool premiumKontrol(i) {
    print("premium kontrole");
    if (premiumUye == true) {
      return false;
    } else {
      if (i > 2) {
        return true;
      } else {
        return false;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    print(widget.whSection);
    print("WordListGrupde");
    _veriOku();
    _veriKaydet();
    // getData();
    getInternetData();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "",
          ),
        ),
        backgroundColor: defaultBackgroundColor,
        elevation: 0,
        leading: new IconButton(
          icon: new Icon(
            Icons.arrow_back_ios,
          ),
          // onPressed: () => Navigator.pushNamed(context, "/word_bilgi"),
          onPressed: () => Navigator.pop(context),
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
                padding: const EdgeInsets.all(10),
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
                            whSection: widget.whSection,
                            tamammi: kontrol(i),
                            acikmi: premiumKontrol(i),
                          ),
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
  MenuWidget({
    Key key,
    @required this.text,
    @required this.tamammi,
    @required this.whSection,
    @required this.acikmi,
  }) : super(key: key);

  final String text;
  final int whSection;
  final bool tamammi;
  final bool acikmi;

  PurchaserInfo purchaserInfo;

  @override
  Widget build(BuildContext context) {
    Future<void> showPaywall() async {
      print("satın alma işlemi başlatıldı.bbb.");
      Offerings offerings = await Purchases.getOfferings();
      if (offerings.current != null && offerings.current.monthly != null) {
        print("icerdeyim");
        final currentMonthlyProduct = offerings.current.monthly.product;
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  title: Text(currentMonthlyProduct.description),
                  content: Row(
                    children: [Text(currentMonthlyProduct.priceString)],
                  ),
                  actions: [
                    TextButton(
                        onPressed: () async {
                          // await makePurchases(offerings.current.monthly);
                        },
                        child: Text('Buy'))
                  ],
                ));
      }
    }

    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Container(
          //margin: EdgeInsets.all(5),
          child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        side: BorderSide(color: Colors.white)))),
            onPressed: () {
              if (!acikmi) {
                whSentenceGroup = int.parse(text) - 1;
                // Navigator.pushNamed(context, "/wordsmainsecond");

                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => WordListSection(
                            kelimeGrubu: whSentenceGroup,
                            whSection: whSection)));
                // Navigator.of(context).pushReplacement(MaterialPageRoute(
                //     builder: (context) => WordMainSecond(
                //         kelimeGrubu: whSentenceGroup, whSection: whSection)));

              } else {
                print("premium degil");

                showAlertDialog(BuildContext context) {
                  // set up the button
                  // set up the buttons
                  Widget cancelButton = TextButton(
                    child: Text("Vazgeç"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  );
                  Widget continueButton = TextButton(
                    child: Text("Premium Ol"),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => SatilAlPage(),
                        ),
                      );

                      // ustSinif.ustSinif.showPaywall();
                    },
                  );

                  // set up the AlertDialog
                  AlertDialog alert = AlertDialog(
                    title: Text("Premium Üye Özelliği"),
                    content: Text(
                        "Kilitli bölümleri açmak için premium üye olmalısınız."),
                    actions: [
                      cancelButton,
                      continueButton,
                    ],
                  );

                  // show the dialog
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return alert;
                    },
                  );
                }

                showAlertDialog(context);
              }
            },
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(padding: EdgeInsets.only(top: 20)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      Visibility(
                        visible: tamammi,
                        child: Container(
                          child: Padding(
                              padding: const EdgeInsets.fromLTRB(20, 5, 10, 5),
                              child: Icon(Icons.check)),
                        ),
                      ),
                      Visibility(
                        visible: acikmi,
                        child: Container(
                          child: Padding(
                              padding: const EdgeInsets.fromLTRB(20, 5, 10, 5),
                              child: Icon(
                                Icons.lock,
                                color: Colors.amber,
                              )),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Text("."),
        Text("."),
        Text("."),
      ],
    );
  }
}
