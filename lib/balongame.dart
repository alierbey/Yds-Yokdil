import 'dart:math';
import 'dart:async';

import 'package:flutter/material.dart';

class BalonGame extends StatefulWidget {
  const BalonGame({Key key}) : super(key: key);

  @override
  _BalonGameState createState() => _BalonGameState();
}

class _BalonGameState extends State<BalonGame> {
  Map a = {
    "kelime1": "anlam",
    "kelime2": "anlam2",
    "kelime3": "anlam2",
    "kelime4": "anlam2",
    "kelime5": "anlam2",
    "kelime6": "anlam2",
    "kelime7": "anlam2",
    "kelime8": "anlam2",
    "kelime9": "anlam2",
    "kelime10": "anlam2",
  };
  List kelimeler = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(a["kelime"]);

    for (var item in a.keys) {
      print(item);
      kelimeler.add(item);
    }

    print(kelimeler);
    yeniBalonUret();
  }

  List gorunurluk = [
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
  ];

  var i = 0;
  var b = 800;
  List ust = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
  List sol = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

  Timer timer1;
  Timer timer2;
  void yeniBalonUret() {
    for (var i = 0; i < 10; i++) {
      ust[i] = Random().nextInt(100) + 700;
      sol[i] = Random().nextInt(300);
    }

    var k = 0;

    timer2 = Timer.periodic(const Duration(milliseconds: 1), (timer) {
      // print("balonUret");
      setState(() {
        if (k < 10) {
          if (k < 4) {
            if (ust[k] > 50) {
              ust[k] = ust[k] - 1;
            } else {
              k++;
            }
          } else if (k < 8) {
            if (ust[k] > 150) {
              ust[k] = ust[k] - 1;
            } else {
              k++;
            }
          }
        }
      });
      // print(ust[0]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: kelimeler
            .asMap()
            .entries
            .map(
              (c) => new Positioned(
                left: sol[c.key].toDouble(),
                top: ust[c.key].toDouble(),
                width: 100,
                child: Visibility(
                  visible: gorunurluk[c.key],
                  child: TextButton(
                    onPressed: () {
                      // setState(() {
                      print(c.key.toString());
                      gorunurluk[c.key] = false;
                      print(gorunurluk);
                      // });
                    },
                    child: Stack(
                      children: [
                        Positioned(
                          child: Image.asset("assets/images/balon1.png"),
                        ),
                        Positioned(
                          top: 30,
                          left: 21,
                          child: Text(
                            // randomCevaplar[0].toString(),
                            c.value.toString(),

                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 12),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
