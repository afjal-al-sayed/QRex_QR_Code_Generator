import 'package:flutter/material.dart';
import 'package:qrex_qr_code_generator/screens/home_screen/home_screen.dart';
import 'package:qrex_qr_code_generator/utils/constants.dart';

void main() {
  runApp(const BaseApp());
}

class BaseApp extends StatelessWidget {
  const BaseApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: CONSTANTS.APP_NAME,
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      theme: ThemeData(
        colorScheme: Theme.of(context).colorScheme.copyWith(
          primary: CONSTANTS.PRIMARY_COLOR,
          secondary: CONSTANTS.PRIMARY_COLOR
        ),
        fontFamily: 'Poppins'
      ),
    );
  }
}

