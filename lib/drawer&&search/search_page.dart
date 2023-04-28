import 'package:flutter/material.dart';
import 'package:project_chat_app/common/touch_callback.dart';

class SearchPage extends StatefulWidget {
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  FocusNode focusNode = FocusNode();

  //焦点
  _requestFocus() {
    FocusScope.of(context).requestFocus(focusNode);
    return focusNode;
  }

  //获取文本
  _getText(String text) {
    return TouchCallBack(
      isfeed: false,
      onPressed: () {},
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 15.0,
          color: Colors.green,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Stack(children: <Widget>[
              TouchCallBack(
                isfeed: false,
                onPressed: () {
                  Navigator.popAndPushNamed(context, "mainPage");
                },
                child: Container(
                  height: 45.0,
                  margin: const EdgeInsets.only(left: 12.0, right: 10.0),
                  child: const Icon(
                    Icons.chevron_left,
                    color: Colors.black,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                height: 45.0,
                margin: const EdgeInsets.only(left: 50.0, right: 10.0),
                decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(width: 1.0, color: Colors.green)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      flex: 8,
                      child: TextField(
                        focusNode: _requestFocus(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                        ),
                        onChanged: (String text) {},
                        decoration: const InputDecoration(
                          hintText: '搜索',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const Expanded(
                      flex: 1,
                      child: Icon(
                          Icons.mic,
                      ),
                    ),
                  ],
                ),
              ),
            ]
            ),
            Container(
              margin: const EdgeInsets.only(top: 50.0),
              child: const Text(
                '搜素指定文章',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Color(0xffb5b5b5),
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  _getText('朋友圈'),
                  _getText('文章'),
                  _getText('公众号'),
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(left: 30.0,right: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  _getText('小程序'),
                  _getText('视频号'),
                  _getText('附近的人'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
