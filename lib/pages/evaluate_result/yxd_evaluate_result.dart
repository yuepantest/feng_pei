import 'package:feng_pei/common/entity/entitys.dart';
import 'package:flutter/material.dart';

class YXDEvaluateResult extends StatefulWidget {
  final ClientDatum data;

  const YXDEvaluateResult({Key? key, required this.data})
      : super(key: key);

  @override
  _YXDEvaluateResultState createState() =>
      _YXDEvaluateResultState();
}

class _YXDEvaluateResultState extends State<YXDEvaluateResult> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("补充资料"),
    );
  }
}
