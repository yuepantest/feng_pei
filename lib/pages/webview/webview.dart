import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../common/entity/entitys.dart';

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
    //requestMultiplePermissions();
    var id = widget.data.id;
    var clientName = widget.data.clientName;
    var assessMoney = widget.data.assessMoney;
    var identityCard = widget.data.identityCard;
    String _detailUrl =
        'http://47.109.33.172:8082/#/FormThree?clientId=${id}&clientName=${clientName}&assessMoney=${assessMoney}&identityCard=${identityCard}';
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {

          },
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
        ),
      )
      ..addJavaScriptChannel('Logging', onMessageReceived: (JavaScriptMessage message) {
        print('来自网页的消息: ${message.message}');
      })
      ..loadRequest(Uri.parse(_detailUrl));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        var canBack = await _controller.canGoBack();
        if (canBack) {
          // 当网页还有历史记录时，返回到上一页
          await _controller.goBack();
          return false;
        } else {
          // 如果没有历史记录，返回到原生页面
          return true;
        }
      },
      child: WebViewWidget(controller: _controller),
    );
  }

  Future<void> requestMultiplePermissions() async {
    // 请求多个权限
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.storage,
    ].request();
    // 检查相机权限
    if (statuses[Permission.camera]!.isGranted) {
      print("Camera permission granted");
    } else {
      openAppSettings(); // 跳转到应用设置页面
    }
    // 检查存储权限
    if (statuses[Permission.storage]!.isGranted) {
      print("Storage permission granted");
    } else {
      openAppSettings(); // 跳转到应用设置页面
    }
  }
}
