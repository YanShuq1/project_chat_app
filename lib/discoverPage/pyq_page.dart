import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PYQPage extends StatefulWidget {
  const PYQPage({super.key});

  @override
  State<PYQPage> createState() => _PYQPageState();
}

class _PYQPageState extends State<PYQPage> {
  bool isLoading = true; // 添加一个加载状态变量

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QQ空间'), // 添加一个标题
      ),
      body: Stack(
        children: [
          WebView(
            initialUrl: "https://qzone.qq.com/",
            javascriptMode: JavascriptMode.unrestricted,
            onPageStarted: (String url) {
              // print("onPageStarted $url");
              setState(() {
                isLoading = true; // 页面开始加载时设置isLoading为true
              });
            },
            onPageFinished: (String url) {
              // print("onPageFinished $url");
              setState(() {
                isLoading = false; // 页面加载完成后设置isLoading为false
              });
            },
            // onWebResourceError: (error) {
            //   print("${error.description}");
            // },
          ),
        ],
      ),
    );
  }
}
