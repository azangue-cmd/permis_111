import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DirectionScrennWeb extends StatelessWidget {
  final String url;
  const DirectionScrennWeb({super.key, required this.url,});

  @override
  Widget build(BuildContext context) {
    var controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
  ..setBackgroundColor(Colors.white)
      ..loadRequest(Uri.parse(url))
      ..setNavigationDelegate(NavigationDelegate());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test page web'),
      ) ,
      body: WebViewWidget(controller: controller),
    );
  }
}