import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const WebViewContainer(),
    );
  }
}

class WebViewContainer extends StatefulWidget {
  const WebViewContainer({super.key});

  @override
  _WebViewContainerState createState() => _WebViewContainerState();
}

class _WebViewContainerState extends State<WebViewContainer> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _requestPermissions();

    _controller =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..loadRequest(
            Uri.parse("https://roaddamagedetection.streamlit.app/"),
          ); // Change to your Streamlit URL
  }

  Future<void> _requestPermissions() async {
    await Permission.camera.request();
    await Permission.microphone.request();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Road Damage Detection")),
      body: WebViewWidget(controller: _controller),
    );
  }
}
