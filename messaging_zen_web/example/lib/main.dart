import 'package:flutter/material.dart';
import 'package:messaging_zen_web/messaging_zen_web.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final MessagingZenPlugin _messagingZen = MessagingZenPlugin();

  @override
  void initState() {
    super.initState();

    // Get web script info from --dart-define variables
    const String webScriptId = String.fromEnvironment('WEB_SCRIPT_ID');
    const String webScriptSrc = String.fromEnvironment('WEB_SCRIPT_SRC');

    // Initialize MessagingZen
    _messagingZen.initialize(
      webScriptId: webScriptId,
      webScriptSrc: webScriptSrc,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Messaging Zen Web'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Launch with"),
                const SizedBox(height: 10),
                const Text(
                  '--dart-define=WEB_SCRIPT_ID=[id]',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                const Text(
                  '--dart-define=WEB_SCRIPT_SRC=[src]',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                const Text("to use this demo."),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    _messagingZen.webWidgetSetZIndex(zIndex: -1000);
                  },
                  child: const Text("Hide Web Widget"),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    _messagingZen.webWidgetSetZIndex(zIndex: 999999);
                  },
                  child: const Text("Show Web Widget"),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    _messagingZen.show();
                  },
                  child: const Text("Show Message Box"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
