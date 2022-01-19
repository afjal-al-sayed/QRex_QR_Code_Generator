import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrex_qr_code_generator/utils/constants.dart';

class QRDetailsScreen extends StatefulWidget {
  const QRDetailsScreen({Key? key, required this.url, required this.textData}) : super(key: key);

  final String url;
  final String textData;
  final double textQrGap = 24.0;

  @override
  State<QRDetailsScreen> createState() => _QRDetailsScreenState();
}

class _QRDetailsScreenState extends State<QRDetailsScreen> {

  _saveImageToGallery() async {
    var status = await Permission.storage.request();
    if(status.isGranted){
      var response = await Dio().get(
          widget.url,
          options: Options(responseType: ResponseType.bytes)
      );
      final result = await ImageGallerySaver.saveImage(
          Uint8List.fromList(response.data),
          quality: 80,
          name: "QRex_${widget.textData}"
      );
      print(result);
      Fluttertoast.showToast(msg: "QR Code saved successfully.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(CONSTANTS.APP_NAME),
        centerTitle: true,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              SizedBox(height: 32.0,),
              CachedNetworkImage(
                width: MediaQuery.of(context).size.width / 1.5,
                imageUrl: widget.url,
                placeholder: (context, url){
                  return Column(
                    children: [
                      Text(
                        "Generating QR Code... Please wait...",
                        // text,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22.0,
                        ),
                      ),
                      SizedBox(height: widget.textQrGap,),
                      Image.asset("assets/images/qr_loading.gif"),
                    ],
                  );
                },
                errorWidget: (context, url, error) {
                  return Column(
                    children: [
                      Text(
                        "Unable to generate QR Code. Please check your internet connection.",
                        // text,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22.0,
                        ),
                      ),
                      SizedBox(height: widget.textQrGap,),
                      Image.asset("assets/images/qr_error.jpg"),
                      SizedBox(height: 32.0,),
                      FloatingActionButton.extended(
                        elevation: 4.0,
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        label: Row(
                          children: [
                            Icon(Icons.arrow_back),
                            SizedBox(width: 8.0,),
                            Text(
                                "Go Back",
                                style: TextStyle(
                                    fontSize: 16.0
                                )
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
                imageBuilder: (context, imageProvider) {
                  return Column(
                    children: [
                      Text(
                        "Bingo! Your QR Code is here:",
                        // text,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22.0,
                        ),
                      ),
                      SizedBox(height: widget.textQrGap,),
                      Image(image: imageProvider,),
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
                        onPressed: (){
                          _saveImageToGallery();
                        },
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
                  );
                }
                /*progressIndicatorBuilder: (context, url, progress) {
                  return Image.asset("assets/images/qr_loading.gif");
                },*/
              ),
            ],
          ),
        ),
      )
    );
  }
}
