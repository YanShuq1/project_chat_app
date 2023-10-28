import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bubble/bubble.dart';
import 'dart:async';

class ChatMessage {
  String message;
  String sender;

  ChatMessage({required this.message, required this.sender});
}

class ChatPage extends StatefulWidget {
  final String friendName;

  const ChatPage({super.key, required this.friendName});

  @override
  ChatPageState createState() => ChatPageState();
}

class ChatPageState extends State<ChatPage> {
  List<ChatMessage> chatMessageList = [];
  final TextEditingController _controller = TextEditingController();
  final StreamController<List<ChatMessage>> _messagesController =
  StreamController<List<ChatMessage>>();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  @override
  void dispose() {
    _messagesController.close();
    super.dispose();
  }

  void _loadMessages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? messages = prefs.getStringList(widget.friendName);
    if (messages != null) {
      setState(() {
        chatMessageList = messages
            .map((m) => ChatMessage(message: m, sender: widget.friendName))
            .toList();
      });
    }
    // Update the stream even if there are no messages
    _messagesController.add(chatMessageList);
  }

  void _saveMessages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> messages = chatMessageList.map((m) => m.message).toList();
    prefs.setStringList(widget.friendName, messages);
    _messagesController.add(chatMessageList);
  }

  void _addMessage(String text) {
    if (text.isNotEmpty) {
      setState(() {
        chatMessageList.add(ChatMessage(message: text, sender: 'Me'));
        _controller.clear();
      });
      _saveMessages();

      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.fastLinearToSlowEaseIn, // 或者使用其他适合的曲线
      );
    }
  }

  void _deleteMessage(int index) {
    setState(() {
      chatMessageList.removeAt(index);
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
            child: StreamBuilder<List<ChatMessage>>(
              stream: _messagesController.stream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  final messages = snapshot.data ?? [];
                  return ListView.builder(
                    shrinkWrap: true,
                    controller: _scrollController,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      return GestureDetector(
                        onLongPress: () => _showDeleteDialog(index),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Bubble(
                              margin: const BubbleEdges.all(10.0),
                              color: const Color(0xFFCCFFDB),
                              nip: BubbleNip.rightCenter,
                              alignment: Alignment.centerRight,
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth: MediaQuery.of(context).size.width * 0.7,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(9.0),
                                  child: Text(
                                    message.message,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.transparent,
                              radius: 23,
                              child: Image.asset('images/image_drawer.png'),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(
              minHeight: 50,
              maxHeight: 150,
            ),
            child: Container(
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
          ),
        ],
      ),
    );
  }
}
