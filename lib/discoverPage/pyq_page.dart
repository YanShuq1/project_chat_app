import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PYQPage extends StatefulWidget {
  const PYQPage();

  @override
  State<PYQPage> createState() => _PYQPageState();
}

class _PYQPageState extends State<PYQPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  WebView(
        initialUrl: "https://wx.qq.com/",
        javascriptMode: JavascriptMode.unrestricted,
        onPageStarted: (String url){
          print("onPageStarted $url");
        },
        onPageFinished: (String url){
          print("onPageFinished $url");
        },
        onWebResourceError: (error){
          print("${error.description}");
        },
      ),
    );
  }
}
