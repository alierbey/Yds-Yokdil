import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'constant.dart';

class SatilAlPage extends StatefulWidget {
  const SatilAlPage({Key key}) : super(key: key);

  @override
  _SatilAlPageState createState() => _SatilAlPageState();
}

class _SatilAlPageState extends State<SatilAlPage> {
  PurchaserInfo purchaserInfo;

  Future<void> initPlatformState() async {
    await Purchases.setDebugLogsEnabled(true);
    await Purchases.setup("appl_HKMOsgBnRRykUfiWIMhBDMcqsHY");
    purchaserInfo = await Purchases.getPurchaserInfo();
    print("purchaserInfo $purchaserInfo");
    userIsPremium();
    showPaywall();
  }

  Future<bool> userIsPremium() async {
    purchaserInfo = await Purchases.getPurchaserInfo();
    return purchaserInfo.entitlements.all["premium"] != null &&
        purchaserInfo.entitlements.all["premium"].isActive;
  }

  String title = "";
  String fiyat = "";
  Package teklif;

  Future<void> showPaywall() async {
    print("satın alma işlemi başlatıldı>>");
    Offerings offerings = await Purchases.getOfferings();
    print(offerings);
    if (offerings.current != null) {
      print("icerdeyim");

      // final currentMonthlyProduct = offerings.current.monthly.product;
      final currentLifeTimeProduct = offerings.current.annual.product;

      setState(() {
        title = currentLifeTimeProduct.description;
        fiyat = currentLifeTimeProduct.priceString;
        teklif = offerings.current.annual;
      });

      //   showDialog(
      //       context: context,
      //       builder: (_) => AlertDialog(
      //             title: Text(currentLifeTimeProduct.description),
      //             content: Row(
      //               children: [Text(currentLifeTimeProduct.priceString)],
      //             ),
      //             actions: [
      //               RaisedButton(
      //                   onPressed: () async {
      //                     await makePurchases(offerings.current.lifetime);
      //                   },
      //                   child: Text('Buy'))
      //             ],
      //           ));
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

  Future<void> restorePurchases(Package package) async {
    try {
      PurchaserInfo restoredInfo = await Purchases.restoreTransactions();
      premiumUye = true;
      // ... check restored purchaserInfo to see if entitlement is now active
      print("restoredInfo $restoredInfo");
    } on PlatformException catch (e) {
      // Error restoring purchases
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    initPlatformState();
    super.initState();
  }

  bool deneme = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: defaultBackgroundColor,
          elevation: 0,
        ),
        body: Center(
          child: Container(
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Column(
              children: [
                deneme ? Text("yeap") : Text(title),

                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Image(
                    width: 100,
                    image: AssetImage("assets/images/premium.png"),
                  ),
                ),
                Text("1 Yıllık premium paketi"),

                Text(fiyat,
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

                TextButton(
                  onPressed: () async {
                    await makePurchases(teklif);
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
                        "Satın Al",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ),

                TextButton(
                  onPressed: () async {
                    await restorePurchases(teklif);
                  },
                  child: Text(
                    "Daha önce satın almayı geri yükle..",
                    style: TextStyle(color: Colors.lightBlue, fontSize: 12),
                  ),
                ),

                SizedBox(
                  height: 100,
                ),

                TextButton(
                  onPressed: () async {
                    Navigator.of(context).pushNamed("/eula");
                  },
                  child: Text(
                    "Kullanıcı Sözleşmesi(EULA)",
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    Navigator.of(context).pushNamed("/privacy");
                  },
                  child: Text(
                    "Gizlilik Politikası",
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),

                // Scaffold.of(context).showSnackBar(
                //     SnackBar(content: Text("You aren't premium user")));
              ],
            ),
          ),
        ));
  }
}
