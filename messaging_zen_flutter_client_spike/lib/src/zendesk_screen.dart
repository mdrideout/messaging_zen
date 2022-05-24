import 'package:flutter/material.dart';
import 'package:messaging_zen/messaging_zen.dart';

class ZendeskScreen extends StatefulWidget {
  const ZendeskScreen({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  State<ZendeskScreen> createState() => _ZendeskScreenState();
}

class _ZendeskScreenState extends State<ZendeskScreen> {
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
        onPressed: () {
          // Run Zendesk Function
          MessagingZen.show();
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
