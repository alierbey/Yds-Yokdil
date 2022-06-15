import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class EulaPage extends StatelessWidget {
  const EulaPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Eula - Sözleşme"),
      ),
      body: WebView(
        initialUrl: 'https://alierbey.com/yds-yokdil-icin-eula/',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
