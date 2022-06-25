import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yds_yokdil/blockmain.dart';
import 'package:yds_yokdil/similarwords.dart';
import 'package:yds_yokdil/word_1_page_info.dart';
import 'package:yds_yokdil/yokdilmain.dart';
import 'constant.dart';
import 'questionmain.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'dart:io' show Platform;
import 'satinal.dart';
import 'package:shared_preferences/shared_preferences.dart';

final String testID = "yds_premium";

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PurchaserInfo purchaserInfo;

  IconData iconum = Icons.volume_up;

  void sesDurumuDegistir() {
    print("icon değişmesi lazım");
    setState(() {
      if (sesAcikMi) {
        iconum = Icons.volume_up;
      } else {
        iconum = Icons.volume_off;
      }
    });
  }

  SharedPreferences prefs;
  void sesSharedDurumu() async {
    prefs = await SharedPreferences.getInstance();
    sesAcikMi = (prefs.getBool('sesAcikMi') ?? true);
    sesDurumuDegistir();
  }

  Future<void> initPlatformState() async {
    await Purchases.setDebugLogsEnabled(true);
    await Purchases.setup("appl_HKMOsgBnRRykUfiWIMhBDMcqsHY");
    purchaserInfo = await Purchases.getPurchaserInfo();
    print("purchaserInfo $purchaserInfo");
    userIsPremium();
    premiumKontrol();
  }

  Future<bool> userIsPremium() async {
    purchaserInfo = await Purchases.getPurchaserInfo();
    return purchaserInfo.entitlements.all["premium"] != null &&
        purchaserInfo.entitlements.all["premium"].isActive;
  }

  Future<void> showPaywall() async {
    print("satın alma işlemi başlatıldı>>");
    Offerings offerings = await Purchases.getOfferings();
    if (offerings.current != null) {
      print("icerdeyim");
      // final currentMonthlyProduct = offerings.current.monthly.product;
      final currentLifeTimeProduct = offerings.current.lifetime.product;

      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                title: Text(currentLifeTimeProduct.description),
                content: Row(
                  children: [Text(currentLifeTimeProduct.priceString)],
                ),
                actions: [
                  ElevatedButton(
                      onPressed: () async {
                        await makePurchases(offerings.current.lifetime);
                      },
                      child: Text('Buy'))
                ],
              ));
    }
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

  void premiumKontrol() async {
    print("init state ici");
    print(await userIsPremium());
    premiumUye = await userIsPremium();
    // premiumUye = true;
    print("init state ici");
  }

  bool userIsPremiumMu = true;
  @override
  void initState() {
    // TODO: implement initState
    initPlatformState();
    print("HomePage");
    sesSharedDurumu();
    super.initState();
    // premiumKontrol();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
          backgroundColor: defaultBackgroundColor,
          elevation: 0,
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    var alert = AlertDialog(
                      title: Text("Ses Durumu"),
                      content: (sesAcikMi)
                          ? Text("Sesi kapatmak istediğinize emin misiniz?")
                          : Text("Sesi açmak istediğinize emin misiniz?"),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("Vazgeç")),
                        TextButton(
                            onPressed: () {
                              print("icon değiştirildi");
                              Navigator.of(context).pop();
                              setState(() {
                                if (sesAcikMi) {
                                  prefs.setBool("sesAcikMi", false);
                                  sesAcikMi = false;
                                } else {
                                  prefs.setBool("sesAcikMi", true);
                                  sesAcikMi = true;
                                }

                                sesDurumuDegistir();
                              });
                            },
                            child: Text("Onayla")),
                      ],
                    );

                    showDialog(
                        context: context,
                        builder: (BuildContext context) => alert);
                  },
                  child: Icon(
                    iconum,
                    size: 26.0,
                  ),
                )),
          ]),
      backgroundColor: defaultBackgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: beyHorizontalPadding),
          child: Column(
            children: [
              Image(
                image: AssetImage("assets/images/logo.png"),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  "Öğrenme şeklini kendin belirle",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: Colors.black54,
                      fontSize: 18,
                      fontFamily: "Fjalla One"),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: HomeMenuWidget(
                      menuIcon: Icons.ac_unit_sharp,
                      text: "YDS Kelimeler",
                      subText:
                          "Kelimeleri gözden geçirerek bilmediklerini not alabilirsin.",
                      menuSection: 0,
                    ),
                  ),
                  Expanded(
                    child: HomeMenuWidget(
                      menuIcon: Icons.quiz,
                      text: "Yds Quiz",
                      subText:
                          "Seçenekler arasından doğru olanı bulmaya çalışırken öğrenebilirsin.",
                      menuSection: 1,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: HomeMenuWidgetYokdil(
                      menuIcon: Icons.dashboard_customize,
                      text: "Yökdil",
                      subText: "Fen Bilimleri ",
                      whSection: 1,
                    ),
                  ),
                  Expanded(
                    child: HomeMenuWidgetYokdil(
                      menuIcon: Icons.dashboard_customize,
                      text: "Yökdil",
                      subText: "Sosyal Bilimler",
                      whSection: 2,
                    ),
                  ),
                  Expanded(
                    child: HomeMenuWidgetYokdil(
                      menuIcon: Icons.dashboard_customize,
                      text: "Yökdil",
                      subText: "Sağlık Bilimleri",
                      whSection: 3,
                    ),
                  ),
                ],
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Expanded(
              //       child: HomeMenuWidget(
              //         menuIcon: Icons.web_rounded,
              //         text: "Blok Çeviri",
              //         subText:
              //             "Blok çeviri sayesinde kelimelerin cümleler içinde kullanımıyla kalıcı öğrenme sağlayabilirsin.",
              //       ),
              //     ),
              //   ],
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: HomeMenuWidget(
                      menuIcon: Icons.web_rounded,
                      text: "Blok Çeviri",
                      subText:
                          "Blok çeviri sayesinde kelimelerin cümleler içinde kullanımıyla kalıcı öğrenme sağlayabilirsin.",
                      menuSection: 2,
                    ),
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: HomeMenuWidget(
                      menuIcon: Icons.web_rounded,
                      text: "Benzer Kelimeler",
                      subText:
                          "Benzer kelimeler sayesinde kelimeleri daha kolay akılda tutabileceksiniz.",
                      menuSection: 3,
                    ),
                  ),
                ],
              ),
              // Row(
              //   children: [
              //     TextButton(
              //       onPressed: () async {
              //         if (await userIsPremium()) {
              //           // if (userIsPremiumMu) {
              //           print("premium kullanıcı");
              //           Navigator.of(context).push(MaterialPageRoute(
              //               builder: (context) => WordMain(
              //                     whSection: 0,
              //                   )));
              //         } else {
              //           print("premium kullanıcı değil");
              //           // Scaffold.of(context).showSnackBar(
              //           //     SnackBar(content: Text("You aren't premium user")));
              //         }
              //       },
              //       child: Text("kontrol"),
              //     ),
              //     TextButton(
              //       onPressed: () {
              //         showPaywall();
              //       },
              //       child: Text("satın al"),
              //     ),
              //     TextButton(
              //       onPressed: () {
              //         Navigator.of(context).push(MaterialPageRoute(
              //             builder: (context) => SatilAlPage()));
              //       },
              //       child: Text("satın al sayfasi"),
              //     )
              //   ],
              // )
            ],
          ),
        ),
      ),
    );
  }
}

class HomeMenuWidget extends StatelessWidget {
  const HomeMenuWidget({
    Key key,
    @required this.text,
    @required this.subText,
    @required this.menuIcon,
    @required this.menuSection,
  }) : super(key: key);

  final String text;
  final String subText;
  final IconData menuIcon;
  final int menuSection;

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: screenHeight * 0.30,
      margin: EdgeInsets.all(5),
      child: TextButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    side: BorderSide(color: Colors.white)))),
        onPressed: () {
          if (menuSection == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(
                // builder: (context) => WordMain(
                //   whSection: 0,
                // ),
                builder: (context) => WordPageInfo(
                  whSection: 1,
                ),
              ),
            );
          } else if (menuSection == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => OuestionMain(
                        whSection: 0,
                      )),
            );
          } else if (menuSection == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BlockMain()),
            );
          } else if (menuSection == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SimilarWordsPage()),
            );
          }
        },
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(padding: EdgeInsets.only(top: 0)),
            Icon(menuIcon, size: 48, color: Colors.blueAccent),
            // Image(
            //   image: AssetImage("assets/images/menu1.png"),
            // ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 15, 10, 5),
              child: Text(
                text,
                style: TextStyle(
                    fontFamily: "Anton",
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
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
                    fontSize: 12,
                    color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeMenuWidgetYokdil extends StatelessWidget {
  const HomeMenuWidgetYokdil({
    Key key,
    @required this.text,
    @required this.subText,
    @required this.menuIcon,
    @required this.whSection,
  }) : super(key: key);

  final String text;
  final String subText;
  final IconData menuIcon;
  final int whSection;

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.all(3),
      height: screenHeight * 0.22,
      margin: EdgeInsets.all(3),
      child: TextButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    side: BorderSide(color: Colors.white)))),
        onPressed: () {
          if (text == "Yökdil") {
            // Navigator.pushNamed(context, "/questionmain");
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => YokdilMainPage(whSection: whSection)),
            );
          }
        },
        child: Container(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(padding: EdgeInsets.only(top: 0)),
              Icon(menuIcon, size: 40, color: Colors.blueAccent),
              // Image(
              //   image: AssetImage("assets/images/menu1.png"),
              // ),
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 15, 10, 5),
                child: Text(
                  text,
                  style: TextStyle(
                      fontFamily: "Anton",
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                      color: Colors.black),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 1, 10, 5),
                child: Text(
                  subText,
                  style: TextStyle(
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.normal,
                      fontSize: 12,
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
