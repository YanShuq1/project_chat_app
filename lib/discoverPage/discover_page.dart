import 'package:flutter/material.dart';

class DiscoverPage extends StatelessWidget {

  DiscoverPage();

  final List<Map<String,Icon>> _iconOfDiscoverPage =[
    {"Icon":Icon(Icons.ondemand_video_outlined)},
    {"Icon":Icon(Icons.video_call_outlined)},
    {"Icon":Icon(Icons.filter_center_focus_outlined)},
    {"Icon":Icon(Icons.style_outlined)},
    {"Icon":Icon(Icons.stay_current_landscape_outlined)},
    {"Icon":Icon(Icons.search_outlined)},
    {"Icon":Icon(Icons.accessibility_new_outlined)},
    {"Icon":Icon(Icons.shopping_cart_outlined)},
    {"Icon":Icon(Icons.games_outlined)},
    {"Icon":Icon(Icons.apps_outlined)},
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
        if (index == 0||index == 2||index == 4||index == 6||index == 7||index == 9) {
          return const Divider(
            thickness: 4,
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
                backgroundColor: Colors.transparent,
                child: Icon(Icons.camera_outlined),
              ),
              title: Text("朋友圈"),
          );
        }
        else{
          return ListTile(
            leading: CircleAvatar(
              child: _iconOfDiscoverPage[index-1]["Icon"],
              backgroundColor: Colors.transparent,
            ),
            title: Text(_titleOfDiscoverPage[index-1]["Title"]!),
          );
        }
      },

    );
  }
}
