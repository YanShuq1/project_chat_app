import 'package:flutter/material.dart';

class DiscoverPage extends StatelessWidget {

  DiscoverPage();

  final List<Map<String,Icon>> _iconOfDiscoverPage =[
    {"Icon":Icon(Icons.video_call)},
    {"Icon":Icon(Icons.video_call)},
    {"Icon":Icon(Icons.video_call)},
    {"Icon":Icon(Icons.video_call)},
    {"Icon":Icon(Icons.video_call)},
    {"Icon":Icon(Icons.video_call)},
    {"Icon":Icon(Icons.video_call)},
    {"Icon":Icon(Icons.video_call)},
    {"Icon":Icon(Icons.video_call)},
    {"Icon":Icon(Icons.video_call)},
  ];

  final List<Map<String , String>> _titleOfDiscoverPage =[
    {"Title":"视频号"},
    {"Title":"直播"},
    {"Title":"扫一扫"},
    {"Title":"摇一摇"},
    {"Title":"看一看"},
    {"Title":"搜一搜"},
    {"Title":"附近的人"},
    {"Title":"购物"},
    {"Title":"游戏"},
    {"Title":"小程序"},
  ];


  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 11,
      separatorBuilder: (BuildContext context, int index) {
        if (index == 1||index == 3||index == 5||index == 7||index == 8||index == 10) {
          return const Divider(
            thickness: 3,
            height: 15,
          );
        }
          else{
          return const Divider(
            thickness: 1,
            height: 15,
          );
        }
      },
      itemBuilder: (BuildContext context, int index) {
        if(index == 0) {
          return const ListTile(
              leading: CircleAvatar(
                child: Icon(Icons.camera_outlined),
              ),
              title: Text("朋友圈"),
          );
        }
        else{
          return ListTile(
          );
        }
      },

    );
  }
}
