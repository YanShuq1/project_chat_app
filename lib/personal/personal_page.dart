import 'package:flutter/material.dart';

import 'account_card_of_personal_page.dart';


class PersonalPage extends StatelessWidget {
  PersonalPage({super.key});

  final List<Map<String , Icon>> _iconOfPersonalPage = const[
    {"Icon":Icon(Icons.payment_outlined)},
    {"Icon":Icon(Icons.star_border_outlined)},
    {"Icon":Icon(Icons.camera_outlined)},
    {"Icon":Icon(Icons.wallet_outlined)},
    {"Icon":Icon(Icons.sentiment_very_satisfied_outlined)},
    {"Icon":Icon(Icons.settings_outlined)},
  ];

  final List<Map<String , String>> _titleOfPersonalPage = [
    {"Title":"服务"},
    {"Title":"收藏"},
    {"Title":"朋友圈"},
    {"Title":"卡包"},
    {"Title":"表情"},
    {"Title":"设置"},
  ];

  final List<Map< String ,void Function(BuildContext context)>> _callbackOfPersonalPage = [
    {"CallBack":(BuildContext context){Navigator.of(context).pushReplacementNamed("search");}},
    {"CallBack":(BuildContext context){Navigator.of(context).pushReplacementNamed("search");}},
    {"CallBack":(BuildContext context){Navigator.of(context).pushReplacementNamed("pyq");}},
    {"CallBack":(BuildContext context){Scaffold.of(context).openDrawer();}},
    {"CallBack":(BuildContext context){Navigator.of(context).pushReplacementNamed("search");}},
    {"CallBack":(BuildContext context){Scaffold.of(context).openDrawer();}},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder:(BuildContext context , int index){
        if(index == 0||index == 1||index == 5){
          return Divider(
            thickness: 3,
            color: Colors.grey[400],
          );
        }
        else{
          return Divider(
            thickness: 2,
            color: Colors.grey[300],
          );
        }
        },
      itemCount: 7,
      itemBuilder: (BuildContext context , int index){
        if(index == 0){
          return const AccountCard();
        }
        else{
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: _iconOfPersonalPage[index-1]["Icon"],
            ),
            title: Text(_titleOfPersonalPage[index-1]["Title"].toString()),
            onTap: () => _callbackOfPersonalPage[index-1]["CallBack"]?.call(context),
          );
        }
      },
    );
  }
}
