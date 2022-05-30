import 'package:flutter/material.dart';

class ChatWindowPortal extends StatelessWidget {
  final Widget? chatWidget;
  const ChatWindowPortal({Key? key, required this.chatWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget? _chatWidget = chatWidget;

    if (_chatWidget != null) {
      return SizedBox(
        width: 300,
        height: 600,
        child: Material(
          elevation: 6,
          child: SingleChildScrollView(child: chatWidget),
        ),
      );
    } else {
      return const SizedBox();
    }
  }
}
