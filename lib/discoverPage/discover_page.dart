import 'package:flutter/material.dart';
import 'pyq_page.dart';
// import 'package:project_chat_app/mainPage/main.dart';
// import 'package:webview_flutter/webview_flutter.dart';

class DiscoverPage extends StatelessWidget {

  DiscoverPage({super.key});

  final List<Map<String,Icon>> _iconOfDiscoverPage =const[
    {"Icon":Icon(Icons.ondemand_video_outlined, color:Color(0xECB3E7E4))},
    {"Icon":Icon(Icons.video_call_outlined, color:Color(0xECB3E7E4))},
    {"Icon":Icon(Icons.filter_center_focus_outlined, color:Color(0xECB3E7E4))},
    {"Icon":Icon(Icons.style_outlined, color:Color(0xECB3E7E4))},
    {"Icon":Icon(Icons.stay_current_landscape_outlined, color:Color(0xECB3E7E4))},
    {"Icon":Icon(Icons.search_outlined, color:Color(0xECB3E7E4))},
    {"Icon":Icon(Icons.accessibility_new_outlined, color:Color(0xECB3E7E4))},
    {"Icon":Icon(Icons.shopping_cart_outlined, color:Color(0xECB3E7E4))},
    {"Icon":Icon(Icons.games_outlined, color:Color(0xECB3E7E4))},
    {"Icon":Icon(Icons.apps_outlined, color:Color(0xECB3E7E4))},
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
          return ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Icon(Icons.camera_outlined,color: Color(0xECB3E7E4),),
              ),
              title: const Text("QQ空间"),
            onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const PYQPage(),
            ));

            },
          );
        }
        else{
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: _iconOfDiscoverPage[index-1]["Icon"],
            ),
            title: Text(_titleOfDiscoverPage[index-1]["Title"]!),
          );
        }
      },

    );
  }
}
