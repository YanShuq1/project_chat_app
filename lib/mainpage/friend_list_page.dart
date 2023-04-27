import 'package:flutter/material.dart';
import 'chat_page.dart';

class Friend {
  String name;
  String avatar;

  Friend({required this.name, required this.avatar});
}

List<Friend> friendListPageList = [
  Friend(name: '却之', avatar: 'images/avatar_1.bmp'),
  Friend(name: '啊哈', avatar: 'images/avatar_2.bmp'),
  Friend(name: '逃跑的Viiiiic', avatar: 'images/avatar_3.bmp'),
  Friend(name: '我彻底失败', avatar: 'images/avatar_4.bmp'),
  Friend(name: '願ねが', avatar: 'images/avatar_5.bmp'),
  Friend(name: '拾壹點半呼呼大睡', avatar: 'images/avatar_6.bmp'),
  Friend(name: '顏書齊', avatar: 'images/avatar_mine.jpg'),
];

class FriendListPage extends StatefulWidget {

  @override
  _FriendListPageState createState() => _FriendListPageState();
}

class _FriendListPageState extends State<FriendListPage> {


  void addFriend() async {
    TextEditingController nameController = TextEditingController();
    TextEditingController avatarController = TextEditingController();

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
                    friendListPageList.add(Friend(
                        name: nameController.text,
                        avatar: avatarController.text));
                    Navigator.pop(context);
                    setState(() {});
                  },
                  child: const Text('添加')),
            ],
          );
        });
  }

  void editFriend(int index) async {
    TextEditingController nameController =
    TextEditingController(text: friendListPageList[index].name);
    TextEditingController avatarController =
    TextEditingController(text: friendListPageList[index].avatar);

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
                    friendListPageList[index].name = nameController.text;
                    friendListPageList[index].avatar = avatarController.text;
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
    friendListPageList.removeAt(index);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: friendListPageList.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(friendListPageList[index].avatar
              ),
            ),
            title: Text(friendListPageList[index].name),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ChatPage(friendName: friendListPageList[index].name,),
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
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => deleteFriend(index),
                ),
              ],
            ),
          );
        },
    );
  }
}
