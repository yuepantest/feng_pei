import 'package:feng_pei/common/entity/entitys.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPageValue extends StatefulWidget {
  final ClientDatum data;

  final String route;

  const WebViewPageValue({Key? key, required this.data, required this.route})
      : super(key: key);

  @override
  _WebViewPageValueState createState() => _WebViewPageValueState();
}

class _WebViewPageValueState extends State<WebViewPageValue> {
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
    String _detailUrl = widget.route;
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
        ),
      )
      ..addJavaScriptChannel('Logging', onMessageReceived: (javaScriptMessage) {
        print(javaScriptMessage.message);
      })
      ..loadRequest(Uri.parse(_detailUrl));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        var canBack = await _controller.canGoBack();
        if (canBack) {
          // 当网页还有历史记录时，返回webview上一页
          await _controller.goBack();
          return false;
        } else {
          // 返回原生页面上一页
          return true;
        }
      },
      child: WebViewWidget(controller: _controller),
    );
  }

  void _sendMessageToWeb(String message) {
    _controller.runJavaScript("window.flutter_injected_code('$message');");
  }
}
