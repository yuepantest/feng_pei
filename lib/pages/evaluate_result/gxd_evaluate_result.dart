import 'package:feng_pei/common/entity/entitys.dart';
import 'package:flutter/material.dart';

class GXDEvaluateResult extends StatefulWidget {
  final ClientDatum data;

  const GXDEvaluateResult({Key? key, required this.data}) : super(key: key);

  @override
  _GXDEvaluateResultState createState() => _GXDEvaluateResultState();
}

class _GXDEvaluateResultState extends State<GXDEvaluateResult> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("补充资料"),
    );
  }
}
