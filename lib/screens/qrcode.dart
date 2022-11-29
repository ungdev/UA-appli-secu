import 'package:flutter/services.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ua_app_secu/controllers/repo.dart';
import 'package:ua_app_secu/controllers/scanner.dart';

class QRCode<T extends ScannerController> extends StatefulWidget {
  const QRCode(
      {Key? key,
      required this.text,
      this.isEntrance = false,
      this.enableButton = false})
      : super(key: key);
  final String text;
  final bool isEntrance;
  final bool enableButton;

  @override
  State<QRCode<T>> createState() => _QRCodeState<T>();
}

class _QRCodeState<T extends ScannerController> extends State<QRCode<T>>
    with TickerProviderStateMixin {
  Uint8List? code;
  Color _borderColor = Colors.white;
  bool buttonHolded = false;

  T controller = Get.find();
  MobileScannerController scannerController = MobileScannerController(
    facing: CameraFacing.back,
    detectionSpeed: DetectionSpeed.noDuplicates,
    formats: [BarcodeFormat.qrCode],
    returnImage: false,
  );

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
  void initState() {
    super.initState();

    // In case of page change, wait a bit before starting the camera
    Future.delayed(const Duration(milliseconds: 500), () {
      scannerController.start();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      MobileScanner(
        controller: scannerController,
        onDetect: (capture) async {
          if (!widget.enableButton || buttonHolded) {
            final List<Barcode> barcodes = capture.barcodes;

            for (final qrcode in barcodes) {
              if (qrcode.rawBytes == null) {
                sendError('Erreur lors de la lecture du QRCode');
              } else {
                code = qrcode.rawBytes;
                debugPrint('Barcode detected: ${String.fromCharCodes(code!)}');
                controller.onScan(code!);
              }
            }
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
                    color: Theme.of(context).primaryColor,
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
      widget.enableButton
          ? Positioned(
              bottom: 10,
              width: MediaQuery.of(context).size.width,
              child: const Center(
                  // TODO : Button on hold to scan
                  ),
            )
          : const SizedBox(),
    ]);
  }
}
