import 'package:qrex_qr_code_generator/utils/constants.dart';

String formatQRUrl(String text){
  return "https://api.qrserver.com/v1/create-qr-code/?size=${CONSTANTS.QR_GET_SIZE}x${CONSTANTS.QR_GET_SIZE}&data=$text";
}