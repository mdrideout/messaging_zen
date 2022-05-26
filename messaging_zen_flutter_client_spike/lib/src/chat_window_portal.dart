import 'package:flutter/material.dart';

class ChatWindowPortal extends StatelessWidget {
  final Widget? chatWidget;
  const ChatWindowPortal({Key? key, required this.chatWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget? _chatWidget = chatWidget;

    if (_chatWidget != null) {
      return SizedBox(
        width: 250,
        height: 350,
        child: Material(
          elevation: 6,
          child: chatWidget,
        ),
      );
    } else {
      return const SizedBox();
    }
  }
}
