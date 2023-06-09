import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bubble/bubble.dart';

class ChatMessage {
  String message;
  String sender;

  ChatMessage({required this.message, required this.sender});
}

class ChatPage extends StatefulWidget {
  final String friendName;

  //将用户头像图片地址传入（待实现！！！）
  //final String avatarURL;
  //imagepicker  让我挺过考试月先orz

  ChatPage({required this.friendName});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<ChatMessage> _messages = [];
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  void _loadMessages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? messages = prefs.getStringList(widget.friendName);  //括号内是存储时的key
    if (messages != null) {
      setState(() {
        _messages = messages
            .map((m) => ChatMessage(message: m, sender: widget.friendName))
            .toList();
      });
    }
  }

  void _saveMessages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance(); //获取实例
    List<String> messages =
        _messages.map((m) => m.message).toList(); //将消息转化为字符列表
    prefs.setStringList(widget.friendName, messages); //保存字符列表
  }

  void _addMessage(String text) {
    if (text.isNotEmpty) {
      setState(() {
        _messages.add(ChatMessage(message: text, sender: 'Me'));
        _controller.clear();
      });
      _saveMessages();
    }
  }

  void _deleteMessage(int index) {
    setState(() {
      _messages.removeAt(index);
    });
    _saveMessages();
  }

  void _showDeleteDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('删除消息'),
          content: const Text('你确认要删除这条消息吗?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('取消'),
            ),
            TextButton(
              onPressed: () {
                _deleteMessage(index);
                Navigator.pop(context);
              },
              child: const Text('确认'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.friendName),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (BuildContext context, int index) {
                ChatMessage message = _messages[index];
                return GestureDetector(
                  onLongPress: () => _showDeleteDialog(index),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Bubble(
                        margin: const BubbleEdges.all(10.0),
                        color: Colors.grey[400],
                        // nip: message.isMine ? BubbleNip.rightBottom : BubbleNip.leftBottom,
                        // alignment: message.isMine ? Alignment.centerRight : Alignment.centerLeft,
                        nip: BubbleNip.rightCenter,
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.all(9.0),
                          child: Text(
                            message.message,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 23,
                        child: Image.asset("images/avatar_mine.jpg"),
                      ),
                      const SizedBox(width: 12,),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            height: 100,
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Colors.grey.shade300,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                      decoration: const InputDecoration(
                        hintText: '输入消息...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      _addMessage(_controller.text);
                    },
                    label: const Text(
                      "发送",
                      style: TextStyle(
                        color: Color(0xff393a3f),
                      ),
                    ),
                    icon: const Icon(
                      Icons.send,
                      color: Color(0xff393a3f),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
