import 'package:flutter/material.dart';
import 'package:flutter_web_view/cart_screen.dart';
import 'package:webview_flutter/webview_flutter.dart'; // ADD

import 'navigation_controls.dart';
import 'web_view_stack.dart';

void main() {
  runApp(
    const MaterialApp(
      home: WebViewApp(),
    ),
  );
}

class WebViewApp extends StatefulWidget {
  const WebViewApp({super.key});

  @override
  State<WebViewApp> createState() => _WebViewAppState();
}

class _WebViewAppState extends State<WebViewApp> {
  // Add from here...
  late final WebViewController controller;
  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..loadRequest(
        Uri.parse('https://flutter.dev'),
      );
  }
  // ...to here.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter WebView'),
        // Add from here...
        actions: [
          NavigationControls(controller: controller),
        ],
        // ...to here.
      ),
      body: WebViewStack(controller: controller), // MODIFY
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final current = await controller.currentUrl();

          // ignore: use_build_context_synchronously
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CartOrder(
                current: current,
              ),
            ),
          );
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
