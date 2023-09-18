import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewPage extends StatefulWidget {
  const WebviewPage({super.key});

  @override
  State<WebviewPage> createState() => _WebviewPageState();
}

class _WebviewPageState extends State<WebviewPage> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: WebView(
        initialUrl:
            'https://testprojectmanager.000webhostapp.com/web_view_test.html',
        onWebViewCreated: (controller) {
          _controller = controller;
        },
        onPageFinished: (url) {
          String message = 'Flutter Message - ZERONE';
          _controller.runJavascript('fromAppToWeb("$message")');
          print('플러터앱에서 웹으로 메시지 전송: $message');
        },
        javascriptMode: JavascriptMode.unrestricted,
        javascriptChannels: <JavascriptChannel>{
          JavascriptChannel(
              name: 'toApp',
              onMessageReceived: (JavascriptMessage message) {
                print('웹에서 플러터 앱으로 메시지 전송: ${message.message}');
                Navigator.of(context).pop();
              })
        },
      )),
    );
  }
}
