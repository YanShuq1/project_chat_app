import 'package:flutter/material.dart';
import 'package:project_chat_app/discoverPage/discover_page.dart';
import 'package:project_chat_app/drawer&&search/search_page.dart';
import 'package:project_chat_app/mainpage/friend_list_page.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../contacts/contacts_list_page.dart';
import '../loadingPage/loading_page.dart';
import 'package:project_chat_app/mainpage/friend_list_page.dart';
import 'package:project_chat_app/drawer&&search/my_drawer.dart';
import 'package:project_chat_app/discoverPage/discover_page.dart';

import '../personal/personal_page.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'chatAPP',
    theme: myDefaultTheme,
    routes: <String,WidgetBuilder>{
      "mainPage":(BuildContext context) => MainPage(),
      "/search":(BuildContext context) => SearchPage(),
      "friendListPage":(BuildContext context) => FriendListPage(),
      "contactListPage":(BuildContext context) => ContactPage(),
      "/pyq":(BuildContext context) => WebView(
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
    },
    home: LoadingPage(),
  ));
}
//默认主题
final ThemeData myDefaultTheme = ThemeData(
  primaryColor: const Color(0xffeae7e6),
  scaffoldBackgroundColor: const Color(0xffebebeb),
  cardColor: const Color(0xff393a3f),
  appBarTheme: const AppBarTheme(
    color:Color(0xB3E7E4EC),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Color(0xB3E7E4EC),
  ),
);

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  //底部导航页面路由
  final List<Widget> _pages = [
    FriendListPage(),
    ContactPage(),
    DiscoverPage(),
    PersonalPage(),
  ];
  //顶部显示标题
  final List<String> _pageTitle = [
    "ChatApp",
    "通讯录",
    "发现",
    "我的",
  ];
  //底部导航按钮样式
  final List<BottomNavigationBarItem> _BNBItem = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.chat_outlined),
      label: "首页",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.group_outlined),
      label: "通讯录",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.widgets_outlined),
      label: "发现",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.person_outlined),
      label: "我的",
    ),
  ];
  //页面路由下标
  late int _currentIndex;



  //右上角菜单配置
  _popupMenuItem(String title , {String? imagePath, IconData? icon , VoidCallback? onTap}){
    return PopupMenuItem(
      child: Row(
        children: <Widget>[
          imagePath != null   //三目运算符  xx ? xx:xx
          ? Image.asset(
            imagePath,
          width: 32.0,
          height: 32.0,
          ):SizedBox(
            width: 32.0,
            height: 32.0,
              child: Icon(
                icon,
                color: Colors.white,
              ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 20.0),
            child: TextButton(
              onPressed: onTap,
              child: Text(
                title,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //初始化状态
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentIndex = 0;
  }

  //构建页面
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: myDefaultTheme,
        debugShowCheckedModeBanner: false,
        home:Scaffold(
          appBar: AppBar(
              leading: Builder(
                builder: (context) {
                  return IconButton(//抽屉按钮
                  onPressed: (){
                    Scaffold.of(context).openDrawer();
                  },
                  icon: const Icon(Icons.menu),
            );
                }
              ),
            title: Text(_pageTitle[_currentIndex]),
            centerTitle: true,
            actions: [
              IconButton(
                  //跳转搜索页面
                  onPressed: (){
                    Navigator.of(context).pushReplacementNamed("/search");
                  },
                  icon: const Icon(Icons.search)),
              IconButton(
                  //显示右上角菜单
                  onPressed: (){
                      showMenu(
                          context: context, 
                          position: const RelativeRect.fromLTRB(500.0, 76.0, 10.0, 0.0),
                          items: <PopupMenuEntry>[
                            _popupMenuItem('发起群聊',imagePath: 'images/menu_group_image.png'),
                            _popupMenuItem('添加好友',imagePath: 'images/menu_addfriend_image.png'),
                            _popupMenuItem('扫一扫',imagePath: 'images/menu_qrcore_image.png'),
                            _popupMenuItem('收付款',icon: Icons.crop_free),
                          ],
                      );
                  },
                icon: const Icon(Icons.add))],
          ),
          body: _pages[_currentIndex],
          drawer: MyDrawer(),
          bottomNavigationBar: BottomNavigationBar(
            items: _BNBItem,
            currentIndex: _currentIndex,
            type: BottomNavigationBarType.fixed,
            onTap: (index){
              _changePage(index);
            },
          ),
        ),
    );
  }
  void _changePage(int index){
    //若点击非当前页面则切换
    if (index != _currentIndex){
      setState(() {
        _currentIndex = index;
      });
    }
  }
}

//切换页面




