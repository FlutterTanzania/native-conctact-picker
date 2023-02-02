import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _contact = 'Unknown';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              color: Colors.blue,
              textColor: Colors.white,
              child: const Text('Pick a contact'),
              onPressed: () => _getAContact(),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(_contact)
          ],
        ),
      ),
    );
  }

  _getAContact() async {
    String contact;
    try {
      contact = await FlutterIsAwesome.getAContact();
    } on PlatformException {
      contact = 'Failed to get contact.';
    }
    if (!mounted) return;
    setState(() {
      _contact = contact;
    });
  }
}

class FlutterIsAwesome {
  static const MethodChannel _channel = MethodChannel('com.prosper.specific');
  static Future<String> getAContact() async {
    final String contact = await _channel.invokeMethod('getAContact');
    return contact;
  }
}
