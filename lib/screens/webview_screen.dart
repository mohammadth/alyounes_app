import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../config.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({super.key});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late final WebViewController _controller;
  String _title = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(AppConfig.backgroundColor)
      ..setNavigationDelegate(NavigationDelegate(
        onPageFinished: (_) => setState(() => _isLoading = false),
      ))
      ..addJavaScriptChannel('AndroidBridge', onMessageReceived: (msg) {
        if (msg.message == 'goBack') Navigator.pop(context);
      })
      ..addJavaScriptChannel('Android', onMessageReceived: (msg) {
        if (msg.message == 'goBack') Navigator.pop(context);
      });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    _title = args['title'] ?? '';
    final url = args['url'] ?? '';
    final htmlFile = args['htmlFile'] ?? '';

    if (url.isNotEmpty) {
      _controller.loadRequest(Uri.parse(url));
    } else if (htmlFile.isNotEmpty) {
      _controller.loadFlutterAsset('assets/html/$htmlFile');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_title, maxLines: 1, overflow: TextOverflow.ellipsis)),
      body: Stack(children: [
        WebViewWidget(controller: _controller),
        if (_isLoading) const Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(AppConfig.primaryColor))),
      ]),
    );
  }
}