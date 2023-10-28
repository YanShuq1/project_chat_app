import 'package:flutter/material.dart';

class TouchCallBack extends StatefulWidget {
  final Widget child;
  final VoidCallback onPressed;
  final bool isFeed;
  final Color background;
  const TouchCallBack({Key? key,
    required this.child,
    required this.onPressed,
    this.isFeed = true,
    this.background = const Color(0xffd8d8d8),
}):super(key:key);
  @override
  State<TouchCallBack> createState() => _TouchCallBackState();
}

class _TouchCallBackState extends State<TouchCallBack> {

  Color color = Colors.transparent;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      onPanDown: (d){
        if(widget.isFeed == false) return;
        setState(() {
          color = widget.background;
        });
      },
      onPanCancel: (){
        setState(() {
          color = Colors.transparent;
        });
      },
      child: Container(
        color: color,
        child: widget.child,
      ),
    );
  }
}
