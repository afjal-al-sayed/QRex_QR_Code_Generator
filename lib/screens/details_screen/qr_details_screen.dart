import 'package:flutter/material.dart';
import 'package:qrex_qr_code_generator/utils/constants.dart';

class QRDetailsScreen extends StatelessWidget {
  const QRDetailsScreen({Key? key, required this.url}) : super(key: key);

  final String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(CONSTANTS.APP_NAME),
        centerTitle: true,
      ),
      body: Image.network(url),
    );
  }
}
