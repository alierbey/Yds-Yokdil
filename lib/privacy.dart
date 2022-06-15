import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Privacy - Gizlilik"),
      ),
      body: WebView(
        initialUrl: 'https://alierbey.com/gizlilik-kosullari/',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
