import 'package:flutter/material.dart';
import 'package:messaging_zen_android/messaging_zen_android.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final MessagingZenAndroid _messagingZen = MessagingZenAndroid();

  @override
  void initState() {
    super.initState();

    // Get channel key from env variable
    const androidChannelKey = String.fromEnvironment('ANDROID_CHANNEL_KEY');

    // Initialize MessagingZen
    _messagingZen.initialize(androidChannelKey: androidChannelKey);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Messaging Zen Android'),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.chat),
          onPressed: () async {
            // Show the native Zendesk Messaging SDK view
            await _messagingZen.show();
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
                  '--dart-define=ANDROID_CHANNEL_KEY=[your_key]',
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
