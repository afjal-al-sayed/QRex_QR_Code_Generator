import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:qrex_qr_code_generator/utils/constants.dart';

class QRDetailsScreen extends StatefulWidget {
  const QRDetailsScreen({Key? key, required this.url, required this.textData}) : super(key: key);

  final String url;
  final String textData;

  @override
  State<QRDetailsScreen> createState() => _QRDetailsScreenState();
}

class _QRDetailsScreenState extends State<QRDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(CONSTANTS.APP_NAME),
        centerTitle: true,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              SizedBox(height: 32.0,),
              Text(
                "Bingo! Here is your QR Code:",
                // text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22.0,
                ),
              ),
              SizedBox(height: 32.0,),
              CachedNetworkImage(
                imageUrl: widget.url,
                height: MediaQuery.of(context).size.width / 1.5,
                // placeholder: (context, url) => Image.asset("assets/images/qr_loading.gif"),
                errorWidget: (context, url, error) {
                  return Image.asset("assets/images/qr_error.jpg");
                },
                progressIndicatorBuilder: (context, url, progress) {
                  return Image.asset("assets/images/qr_loading.gif");
                },
              ),
              SizedBox(height: 8.0,),
              Text(
                widget.textData,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w500
                )
              ),
              SizedBox(height: 32.0,),
              FloatingActionButton.extended(
                elevation: 4.0,
                onPressed: (){},
                label: Row(
                  children: [
                    Text(
                        "Save to phone",
                        style: TextStyle(
                            fontSize: 16.0
                        )
                    ),
                    SizedBox(width: 8.0,),
                    Icon(Icons.save)
                  ],
                ),
              ),
              SizedBox(height: 16.0,),
              FloatingActionButton.extended(
                elevation: 4.0,
                onPressed: (){
                  Navigator.pop(context);
                },
                label: Row(
                  children: [
                    Text(
                        "Generate Again",
                        style: TextStyle(
                            fontSize: 16.0
                        )
                    ),
                    SizedBox(width: 8.0,),
                    Icon(Icons.restart_alt)
                  ],
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}
