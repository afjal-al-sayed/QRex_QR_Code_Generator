import 'package:flutter/material.dart';
import 'package:qrex_qr_code_generator/screens/details_screen/qr_details_screen.dart';
import 'package:qrex_qr_code_generator/utils/constants.dart';
import 'package:qrex_qr_code_generator/utils/functions.dart';

class HomeScreen extends StatelessWidget {

  final TextEditingController _urlInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(CONSTANTS.APP_NAME),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 32.0,
            ),
            Container(
              width: MediaQuery.of(context).size.width / 2.2,
              child: Image.asset("assets/images/logo.png"),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
              ),
              clipBehavior: Clip.antiAlias,
            ),
            SizedBox(height: 32.0,),
            Text(
              "Enter your text or URL",
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w500
              )
            ),
            SizedBox(height: 16.0,),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0)
                ),
                hintText: "Text or URL",
                fillColor: Color(0xFFEDEDED),
                filled: true,
              ),
              controller: _urlInputController,
            ),
            SizedBox(height: 32.0,),
            FloatingActionButton.extended(
              elevation: 4.0,
              onPressed: (){
                var textData = _urlInputController.text;
                if(textData.isEmpty){
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Your input can't be empty.")));
                }else{
                  var formattedUrl = formatQRUrl(textData);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => QRDetailsScreen(url: formattedUrl, textData: textData,),));
                }
              },
              label: Row(
                children: [
                  Text(
                    "Generate",
                    style: TextStyle(
                      fontSize: 16.0
                    )
                  ),
                  SizedBox(width: 8.0,),
                  Icon(Icons.arrow_forward)
                ],
              ),
            ),
            SizedBox(height: 32.0,)
          ],
        ),
      ),
    );
  }
}
