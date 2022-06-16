import 'package:flutter/material.dart';
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
  final MessagingZenIos _messagingZeniOS = MessagingZenIos();

  @override
  void initState() {
    super.initState();

    // Get channel key from env variable
    const iosChannelKey = String.fromEnvironment('IOS_CHANNEL_KEY');

    // Initialize MessagingZen
    _messagingZeniOS.initialize(iosChannelKey: iosChannelKey);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Messaging Zen iOS'),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.chat),
          onPressed: () async {
            // // Invalidate MessagingZen instance
            // _messagingZeniOS.invalidate();
            //
            // await Future.delayed(const Duration(seconds: 3));
            //
            // // Get channel key from env variable
            // const iosChannelKey2 = String.fromEnvironment('IOS_CHANNEL_KEY');
            //
            // // Initialize MessagingZen
            // await _messagingZeniOS.initialize(iosChannelKey: iosChannelKey2);

            // Show the native Zendesk Messaging SDK view
            await _messagingZeniOS.show();
          },
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text("Launch with"),
                SizedBox(height: 10),
                Text(
                  '--dart-define=IOS_CHANNEL_KEY=[your_key]',
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Text("to use this demo."),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
