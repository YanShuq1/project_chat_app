import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:project_chat_app/mainpage/friend_list_page.dart';
import '../mainpage/chat_page.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  _ContactPageState createState() => _ContactPageState();
}


//通讯录页面好友列表
final List<Map<String, String>> contactListPageList = [
  //联系人索引
  {"name": "却之", "avatar": "images/avatar_1.bmp", "initial": "Q"},
  {"name": "啊哈", "avatar": "images/avatar_2.bmp", "initial": "A"},
  {"name": "逃跑的Viiiiic", "avatar": "images/avatar_3.bmp", "initial": "T"},
  {"name": "我彻底失败", "avatar": "images/avatar_4.bmp", "initial": "W"},
  {"name": "願ねが", "avatar": "images/avatar_5.bmp", "initial": "Y"},
  {"name": "拾壹點半呼呼大睡", "avatar": "images/avatar_6.bmp", "initial": "S"},
  {"name": "顏書齊", "avatar": "images/avatar_mine.jpg", "initial": "Y"},
];


class _ContactPageState extends State<ContactPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GroupedListView<Map<String, String>, String>(
            //引用第三方插件来实现通讯录中的排序，功能仍不如微信的完整
            elements: contactListPageList,
            groupBy: (contact) => contact['initial']!,
            groupComparator: (initial1, initial2) => initial1.compareTo(initial2),
            itemComparator: (item1, item2) =>
                item1['name']!.compareTo(item2['name']!),
            order: GroupedListOrder.ASC,  //按字母表升序排序
            useStickyGroupSeparators: true, //分割符能粘在顶部
            floatingHeader: true,
            groupSeparatorBuilder: (initial) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              color: Colors.grey[300],
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      initial,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            itemBuilder: (context, contact) => InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatPage(
                    friendName: contact['name']!,
                  ),
                ),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage(contact['avatar']!),
                ),
                title: Text(contact['name']!),
              ),
            ),
          ),
    );
  }
}