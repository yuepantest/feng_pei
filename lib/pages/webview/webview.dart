import 'package:feng_pei/common/entity/entitys.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  final ClientDatum data;

  const WebViewPage({Key? key, required this.data}) : super(key: key);

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
    var id = widget.data.id;
    var clientName = widget.data.clientName;
    var assessMoney = widget.data.assessMoney;
    String _detailUrl =
        'http://47.109.33.172:8082/#/FormThree?id=${id}&clientName=${clientName}&num=${assessMoney}';
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
