import 'package:flutter/services.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ua_app_secu/controllers/repo.dart';

class QRCode extends StatefulWidget {
  const QRCode({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  State<QRCode> createState() => _QRCodeState();
}

class _QRCodeState extends State<QRCode> with TickerProviderStateMixin {
  Uint8List? code;
  Color _borderColor = Colors.white;
  RepoController controller = Get.find();

  void sendError(String error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(error),
      ),
    );

    setState(() {
      _borderColor = Colors.red;
    });

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _borderColor = Colors.white;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      MobileScanner(
        allowDuplicates: false,
        controller: MobileScannerController(facing: CameraFacing.back),
        onDetect: (qrcode, args) {
          if (qrcode.rawBytes == null) {
            sendError('Erreur lors de la lecture du QRCode');
          } else {
            code = qrcode.rawBytes;
            debugPrint('Barcode detected: ${String.fromCharCodes(code!)}');
            controller.setPlayerCode(code!);
          }
        },
      ),
      Container(
        color: Colors.black.withOpacity(0.5),
      ),
      Center(
        child: Stack(children: [
          AnimatedContainer(
            width: 250,
            height: 250,
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
              border: Border.all(
                color: _borderColor,
                width: 3,
              ),
              borderRadius: BorderRadius.circular(40),
            ),
          ),
          AnimatedContainer(
            width: 250,
            height: 250,
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
              color: Colors.white,
              backgroundBlendMode: BlendMode.overlay,
              borderRadius: BorderRadius.circular(40),
            ),
          ),
        ]),
      ),
      Positioned(
        bottom: 50,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 2 / 3,
            height: 200,
            child: Center(
              child: Column(children: [
                Text(
                  'SCANNEZ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.blue.shade300,
                    fontWeight: FontWeight.bold,
                    fontSize: 44,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  widget.text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    ]);
  }
}
