import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:messaging_zen/messaging_zen.dart';
import 'package:messaging_zen_flutter_client_spike/src/common/constants.dart';

class ZendeskScreen extends StatefulWidget {
  const ZendeskScreen({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  State<ZendeskScreen> createState() => _ZendeskScreenState();
}

class _ZendeskScreenState extends State<ZendeskScreen> {
  final MessagingZen _messagingZen = MessagingZen(
    webScriptId: messagingZenWebScriptId,
    webScriptSrc: messagingZenWebScriptSrc,
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Zendesk Spike"),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.chat),
        onPressed: () async {
          // Initialize Zendesk Messaging
          await _messagingZen.initialize();

          // Show the Zendesk Messaging interface
          await _messagingZen.show();
        },
      ),
      body: Center(
        child: Column(
          children: const [
            Text("Zendesk implementation."),
            SizedBox(height: 10.0),
            Text("This screen should allow a zendesk_messaging chat to be opened."),
          ],
        ),
      ),
    );
  }
}
