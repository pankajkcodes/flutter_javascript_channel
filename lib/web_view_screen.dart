import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({super.key});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  WebViewController? _webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebView(
        initialUrl: 'about:blank',
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) async {
          _webViewController = webViewController;
          String fileContent = await rootBundle.loadString('assets/index.html');
          _webViewController?.loadUrl(Uri.dataFromString(fileContent,
                  mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
              .toString());
        },
        javascriptChannels: <JavascriptChannel>{
          JavascriptChannel(
            name: 'messageHandler',
            onMessageReceived: (JavascriptMessage message) {
              print("message from the web view=\"${message.message}\"");
              final script =
                  "document.getElementById('value').innerText=\"${message.message}\"";
              _webViewController?.evaluateJavascript(script);
              if (message.message == "Toggle Switch is on") {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("${message.message}")));
              } else {
                Navigator.pop(context);
              }
            },
          )
        },
      ),
    );
  }
}
