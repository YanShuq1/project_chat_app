import 'package:flutter/material.dart';
import 'search_page.dart';

class MyDrawer extends StatelessWidget {


  final String version = "1.0.0";

  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        elevation: 16.0,
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                UserAccountsDrawerHeader(
                  accountName: const Text('CS2201 叶俊江',style: TextStyle(color: Colors.white),),
                  accountEmail: const Text('1993783308@qq.com',style: TextStyle(color: Colors.white),),
                  currentAccountPicture: const CircleAvatar(
                    backgroundImage: AssetImage('images/image_drawer.png'),),
                  otherAccountsPictures: const <Widget>[
                    CircleAvatar(backgroundImage: AssetImage('images/image_drawer_other_1.png')),
                    CircleAvatar(backgroundImage: AssetImage('images/image_drawer_other_2.png')),
                    CircleAvatar(backgroundImage: AssetImage('images/image_drawer_other_3.png'))
                  ],
                  arrowColor: Colors.red,
                  onDetailsPressed: () {
                    // print(1);
                  },
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('images/drawer_background_image.png'),
                        fit: BoxFit.cover
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    children: <Widget>[
                      ListTile(
                          leading: const Icon(Icons.location_on_outlined),
                          title: const Text('附近的人'),
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SearchPage()),
                            );
                          }
                      ),
                      Divider(
                        thickness: 2,
                        color: Colors.grey[300],
                      ),
                      ListTile(
                        leading: const Icon(Icons.wallet_outlined),
                        title: const Text('卡包'),
                        onTap: (){},
                      ),
                      Divider(
                        thickness: 2,
                        color: Colors.grey[300],
                      ),
                      ListTile(
                        leading: const Icon(Icons.settings_outlined),
                        title: const Text('设置'),
                        onTap: (){},
                      ),
                    ],
                  ),
                ),

              ],
            ),
            Positioned(
                bottom: 10,
                left: 10,
                child: InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "版本号：$version",
                        style: TextStyle(
                          color: Colors.grey[700]
                        ),
                      ),
                    ],
                  ),
                )
            ),
            Positioned(
                bottom: 10,
                right: 10,
                child: InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      TextButton.icon(
                        icon: const Icon(Icons.power_settings_new), onPressed: () { Navigator.pop(context); },
                        label: const Text('关闭抽屉'),
                      ),
                    ],
                  ),
                )
            )
          ],
        )
    );
  }
}