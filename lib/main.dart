import 'package:feng_pei/common/router/routers.dart';
import 'package:feng_pei/pages/index/index.dart';
import 'package:flutter/material.dart';
import 'global.dart';

void main() => Global.init().then((e) => runApp(const MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: '丰沛金融',
        routes: staticRouters,
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const IndexPage());
  }
}
