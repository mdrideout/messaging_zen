import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:messaging_zen_ios/messaging_zen_ios.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget? chatWidget;
  final MessagingZenIos _messagingZeniOS = MessagingZenIos();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    try {
      Widget? _messagingZenWidget = await _messagingZeniOS.show();

      setState(() {
        chatWidget = _messagingZenWidget;
      });

      print("Try something");
    } on PlatformException {
      throw ("Error initializing platform state.");
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Below is a Flutter hosted native iOS view.'),
              const SizedBox(height: 10),
              SizedBox(
                height: 200,
                width: 200,
                child: chatWidget,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
