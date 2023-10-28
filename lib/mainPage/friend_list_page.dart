import 'dart:convert';
import 'dart:io';

import 'package:ChatApp/contacts/contacts_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lpinyin/lpinyin.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'chat_page.dart';


class Friend {
  String name;
  String avatar;

  Friend({required this.name, required this.avatar});
}

// //通讯录页面好友列表
//List<Map<String, String>> contactListPageList = [];
//   //联系人索引
//   {"name": "却之", "avatar": "images/avatar_1.bmp", "initial": "Q"},
//   {"name": "啊哈", "avatar": "images/avatar_2.bmp", "initial": "A"},
//   {"name": "逃跑的Viiiiic", "avatar": "images/avatar_3.bmp", "initial": "T"},
//   {"name": "我彻底失败", "avatar": "images/avatar_4.bmp", "initial": "W"},
//   {"name": "願ねが", "avatar": "images/avatar_5.bmp", "initial": "Y"},
//   {"name": "拾壹點半呼呼大睡", "avatar": "images/avatar_6.bmp", "initial": "S"},
//   {"name": "顏書齊", "avatar": "images/avatar_mine.jpg", "initial": "Y"},
// ];

//将List<Map<String,String>>类型通过json转成List<String>类型
List<String> constListToJsonList(List<Map<String, String>> originalList) {
  List<String> resultList = [];
  for (var map in originalList) {
    String jsonString = json.encode(map);
    resultList.add(jsonString);
  }
  return resultList;
}

//将转换后的List<String>类型转回原本的List<Map<String,String>>类型
List<Map<String, String>> toOriginalList(List<String> jsonList) {
  List<Map<String, String>> resultList = [];
  for (var jsonString in jsonList) {
    Map<String, dynamic> map = json.decode(jsonString);
    Map<String, String> originalMap = map.cast<String, String>();
    resultList.add(originalMap);
  }
  return resultList;
}

void saveContactList() async {
  SharedPreferences prefs = await SharedPreferences.getInstance(); //获取实例
  List<String> saveList = constListToJsonList(contactListPageList);
  await prefs.setStringList("contactsList", saveList);
}

void loadContactList() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> loadList = prefs.getStringList("contactsList") ?? [];
  contactListPageList = toOriginalList(loadList);
}

class FriendListPage extends StatefulWidget {
  const FriendListPage({super.key});



  @override
  _FriendListPageState createState() => _FriendListPageState();
}

class _FriendListPageState extends State<FriendListPage> {

  @override
  void initState() {
    super.initState();
    loadContactList();
  }

  File? image;

  Future pickImage(ImageSource source) async {
    try {
      setState(() {
        image = null;
      });
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage == null) return;

      final imagePermanent = await saveImagePermanently(pickedImage.path);
      // print("选择的图像路径: ${pickedImage.path}");
      // print(imagePermanent);
      // print("在 setState 之前");
      setState(() {
        image = imagePermanent;
      });
    } on PlatformException catch (e) {
      print("Failed to pick the image: $e");
    }
  }

  Future<File> saveImagePermanently(String path) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(path);
    final image = File('${directory.path}/$name');

    return File(path).copy(image.path);
  }

  void deleteFriend(int index) {
    contactListPageList.removeAt(index);

    setState(() {
      saveContactList();
      loadContactList();
    });
  }

  @override
  Widget build(BuildContext context) {
    void addFriend([String? tempName]) async {
      TextEditingController nameController = TextEditingController();

      if (tempName != null) nameController.text = tempName;

      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('添加好友'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                image != null
                    ? ClipOval(
                        child: Image.file(
                          image!,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      )
                    : const FlutterLogo(size: 80),
                ElevatedButton.icon(
                  // style: ButtonStyle(
                  //   backgroundColor: ,
                  // ),
                  onPressed: () async {
                    await showModalBottomSheet(
                      context: context,
                      builder: (context) => Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            leading: const Icon(Icons.image_outlined),
                            title: const Text("相册"),
                            onTap: () async {
                              await pickImage(ImageSource.gallery);
                              Navigator.pop(context, image);
                              setState(() {
                                var storeName = nameController.text;
                                Navigator.pop(context);
                                addFriend(storeName);
                              });
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.photo_camera_outlined),
                            title: const Text("拍照"),
                            onTap: () async {
                              await pickImage(ImageSource.camera);
                              Navigator.pop(context, image);
                              setState(() {
                                var storeName = nameController.text;
                                Navigator.pop(context);
                                addFriend(storeName);
                              });
                            },
                          ),
                        ],
                      ),
                    );
                  },
                  icon: const Icon(Icons.image_search_outlined,color: Colors.blue,),
                  label: const Text("选择图片",style: TextStyle(color: Colors.blue),),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                ),
                TextField(
                  controller: nameController,
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(RegExp(r' ')), // 不允许输入空格
                  ],
                  decoration: const InputDecoration(
                    hintText: '输入好友ID',
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    setState(() {
                      image = null;
                    });
                  },
                  child: const Text('取消')),
              TextButton(
                  onPressed: () {
                    bool mode = true;
                    for (var element in contactListPageList) {
                      if (nameController.text == element["name"] &&
                          image != null &&
                          image!.path == element["avatar"]) {
                        mode = false;
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
                    if (mode == true) {
                      String finalInitial;
                      if (RegExp(r"[\u4e00-\u9fa5]").hasMatch(nameController.text[0])) {
                        // 如果是中文，则提取该字符的拼音首字母
                        finalInitial = PinyinHelper.getFirstWordPinyin(nameController.text[0])[0].toUpperCase();
                      } else if (RegExp(r"[a-zA-Z]").hasMatch(nameController.text[0])) {
                        // 如果是英文字母，则为它的大写字母
                        finalInitial = nameController.text[0].toUpperCase();
                      } else {
                        // 如果是字符，则为它本身
                        finalInitial = nameController.text[0];
                      }
                      // 插入新好友到列表的顶部
                      contactListPageList.insert(0, {
                        "name": nameController.text,
                        "avatar": image != null ? image!.path : "",
                        "initial": finalInitial,
                        "latestMessage": "",
                      });
                      Navigator.pop(context);
                      setState(() {
                        saveContactList();
                        loadContactList();
                      });
                    }
                    setState(() {
                      image = null;
                    });
                  },
                  child: const Text('确定')),
            ],
          );
        },
      );
    }

    void editFriend(int index) async {

        TextEditingController nameController =
        TextEditingController(text: contactListPageList[index]["name"]);

      await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('编辑好友信息'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  contactListPageList[index]["avatar"] != ''
                      ? ClipOval(
                    child: Image.file(
                      File(contactListPageList[index]["avatar"]!),
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  )
                      : const FlutterLogo(size: 80),
                  ElevatedButton.icon(
                    onPressed: () async {
                      await showModalBottomSheet(
                        context: context,
                        builder: (context) => Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              leading: const Icon(Icons.image_outlined),
                              title: const Text("相册"),
                              onTap: () async {
                                await pickImage(ImageSource.gallery);
                                Navigator.pop(context, image);
                                setState(() {
                                  String storeName = nameController.text;
                                  Navigator.pop(context);
                                  addFriend(storeName);
                                });
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.photo_camera_outlined),
                              title: const Text("拍照"),
                              onTap: () async {
                                await pickImage(ImageSource.camera);
                                Navigator.pop(context, image);
                                setState(() {
                                  var storeName = nameController.text;
                                  Navigator.pop(context);
                                  addFriend(storeName);
                                });
                              },
                            ),
                          ],
                        ),
                      );
                    },
                    icon: const Icon(Icons.image_search_outlined,color: Colors.blue,),
                    label: const Text("选择图片",style: TextStyle(color: Colors.blue),),
                    style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.white),
                    ),
                  ),
                  TextField(
                    controller: nameController,
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(RegExp(r' ')), // 不允许输入空格
                    ],
                    decoration: const InputDecoration(
                      hintText: '输入好友ID',
                    ),
                  ),
            ],),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      setState(() {
                        image = null;
                      });
                    },
                    child: const Text('取消')),
                TextButton(
                    onPressed: () {
                      bool mode = true;
                      for (var element in contactListPageList) {
                        if (nameController.text == element["name"] &&
                            image != null &&
                            image!.path == element["avatar"]) {
                          mode = false;
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
                      if (mode == true) {
                        String finalInitial;
                        if (RegExp(r"[\u4e00-\u9fa5]").hasMatch(nameController.text[0])) {
                          // 如果是中文，则提取该字符的拼音首字母
                          finalInitial = PinyinHelper.getFirstWordPinyin(nameController.text[0])[0].toUpperCase();
                        } else if (RegExp(r"[a-zA-Z]").hasMatch(nameController.text[0])) {
                          // 如果是英文字母，则为它的大写字母
                          finalInitial = nameController.text[0].toUpperCase();
                        } else {
                          // 如果是字符，则为它本身
                          finalInitial = nameController.text[0];
                        }
                        contactListPageList[index]["name"]=nameController.text;
                        contactListPageList[index]["avatar"]=image != null ? image!.path : contactListPageList[index]["avatar"].toString();
                        contactListPageList[index]["initial"]=finalInitial;
                        Navigator.pop(context);
                        setState(() {
                          saveContactList();
                          loadContactList();
                        });
                      }
                      setState(() {
                        image = null;
                      });
                    },
                    child: const Text('确定')),
              ],
            );
          });
    }






    return Scaffold(
      body:ListView.separated(
        itemCount: contactListPageList.length,
        itemBuilder: (BuildContext context, int index) {
          String friendName = contactListPageList[index]["name"].toString();
          // String latestMessage =;
          //
          // // 截断消息并添加省略号
          // if (latestMessage.length > 30) {
          //   latestMessage = latestMessage.substring(0, 30) + '...';
          // }

          return ListTile(
            leading: CircleAvatar(
              backgroundImage: contactListPageList[index]["avatar"] != null
          ? Image.file(File(contactListPageList[index]["avatar"]!)).image
              : null,
              child: contactListPageList[index]["avatar"] != null
              ? null // 如果avatar存在，不显示child
                  : const FlutterLogo(), // 使用FileImage设置背景，如果avatar不存在则为空
            ),
            title: Text(friendName),
            // subtitle: Text(latestMessage), // 显示最近消息
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatPage(
                    friendName: contactListPageList[index]["name"].toString(),
                  ),
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
