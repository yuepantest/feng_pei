import 'package:feng_pei/common/entity/entitys.dart';
import 'package:flutter/material.dart';

class ClientAddInformationPage extends StatefulWidget {
  final ClientDatum data;

  const ClientAddInformationPage({Key? key, required this.data})
      : super(key: key);

  @override
  _ClientAddInformationPageState createState() =>
      _ClientAddInformationPageState();
}

class _ClientAddInformationPageState extends State<ClientAddInformationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("补充资料"),
    );
  }
}
