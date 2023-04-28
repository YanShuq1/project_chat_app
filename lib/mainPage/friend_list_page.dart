import 'package:flutter/material.dart';
import 'package:project_chat_app/contacts/contacts_list_page.dart';
import 'chat_page.dart';

class Friend {
  String name;
  String avatar;

  Friend({required this.name, required this.avatar});
}

// List<Friend> friendListPageList = [
//   Friend(name: '却之', avatar: 'images/avatar_1.bmp'),
//   Friend(name: '啊哈', avatar: 'images/avatar_2.bmp'),
//   Friend(name: '逃跑的Viiiiic', avatar: 'images/avatar_3.bmp'),
//   Friend(name: '我彻底失败', avatar: 'images/avatar_4.bmp'),
//   Friend(name: '願ねが', avatar: 'images/avatar_5.bmp'),
//   Friend(name: '拾壹點半呼呼大睡', avatar: 'images/avatar_6.bmp'),
//   Friend(name: '顏書齊', avatar: 'images/avatar_mine.jpg'),
// ];

class FriendListPage extends StatefulWidget {

  @override
  _FriendListPageState createState() => _FriendListPageState();
}

class _FriendListPageState extends State<FriendListPage> {


  void addFriend() async {
    TextEditingController nameController = TextEditingController();
    TextEditingController avatarController = TextEditingController();
    TextEditingController initialController = TextEditingController();


    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('添加好友'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    hintText: '输入名字',
                  ),
                ),
                TextField(
                  controller: initialController,
                  maxLength: 1,
                  decoration: const InputDecoration(
                    hintText: '输入名字拼音首字母',
                  ),
                ),
                TextField(
                  controller: avatarController,
                  decoration: const InputDecoration(
                    hintText: '输入图片路径',
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('取消')),
              TextButton(
                  onPressed: () {
                    var mode = 0;
                    for(var element in contactListPageList){
                      if(nameController.text == element["name"] &&
                          avatarController.text == element["avatar"]) {
                        mode = 1;
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('提示'),
                              content: const Text('联系人已存在，请勿重复添加'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('确定'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    }
                    if(mode == 0) {
                      contactListPageList.add(
                          {"name": nameController.text,
                            "avatar": avatarController.text,
                            "initial": initialController.text});
                      Navigator.pop(context);
                      setState(() {});
                    }
                  },
                  child: const Text('添加')),
            ],
          );
        });
  }

  void editFriend(int index) async {
    TextEditingController nameController =
    TextEditingController(text: contactListPageList[index]["name"]);
    TextEditingController avatarController =
    TextEditingController(text: contactListPageList[index]["avatar"]);
    TextEditingController initialController =
    TextEditingController(text: contactListPageList[index]["initial"]);

    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('编辑好友信息'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    hintText: '输入好友名字',
                  ),
                ),
                TextField(
                  controller: initialController,
                  maxLength: 1,
                  decoration: const InputDecoration(
                    hintText: '输入好友名字拼音首字母',
                  ),
                ),
                TextField(
                  controller: avatarController,
                  decoration: const InputDecoration(
                    hintText: '输入好友头像图片地址',
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('取消')),
              TextButton(
                  onPressed: () {
                    contactListPageList[index]["name"] = nameController.text;
                    contactListPageList[index]["avatar"] = avatarController.text;
                    contactListPageList[index]["initial"] = initialController.text;
                    Navigator.pop(context);
                    setState(() {});
                  },
                  child: const Text('保存'),
              ),
            ],
          );
        });
  }

  void deleteFriend(int index) {
    contactListPageList.removeAt(index);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
          itemCount: contactListPageList.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(contactListPageList[index]["avatar"].toString()
                ),
              ),
              title: Text(contactListPageList[index]["name"].toString()),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ChatPage(friendName: contactListPageList[index]["name"].toString(),),
                  ),
                );
              },
              onLongPress: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('删除好友'),
                        content: const Text('你确认要删除好友吗'),
                        actions: [
                          TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('取消')),
                          TextButton(
                              onPressed: () {
                                deleteFriend(index);
                                Navigator.pop(context);
                              },
                              child: const Text('确认')),
                        ],
                      );
                    });
              },
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () => editFriend(index),
                  ),
                  // IconButton(
                  //   icon: const Icon(Icons.delete),
                  //   onPressed: () => deleteFriend(index),
                  // ),
                ],
              ),
            );
          },
        separatorBuilder: (BuildContext context, int index) {
            return const Divider(
              thickness: 1,
              height: 15,
            );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addFriend,
        child: const Icon(Icons.add),
      ),
    );
  }
}
