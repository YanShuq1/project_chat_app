import 'package:ChatApp/mainPage/friend_list_page.dart';
import 'package:flutter/material.dart';
import 'dart:async';



class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {

  @override
  void initState() {
    super.initState();
    loadContactList();
    Future.delayed(const Duration(seconds: 2),(){
      // print("chatAPP启动...");
      Navigator.of(context).pushReplacementNamed("mainPage");
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Image.asset("images/loading_image.png");
  }
}
