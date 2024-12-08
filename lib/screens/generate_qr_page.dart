import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GenerateQrPage extends StatefulWidget {
  const GenerateQrPage({super.key});

  @override
  State<GenerateQrPage> createState() => _GenerateQrPageState();
}

class _GenerateQrPageState extends State<GenerateQrPage> {
  final TextEditingController _textController = TextEditingController();
  String? _qrData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Generate QR Code"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_qrData != null)
              SizedBox(
                height: 200, // Set the size of the QR code
                width: 200,
                child: CustomPaint(
                  painter: QrPainter.withQr(
                    qr: QrCode.fromData(
                      data: _qrData!,
                      errorCorrectLevel: QrErrorCorrectLevel
                          .L, // Add the error correction level
                    ),
                    color: Colors.black,
                    emptyColor: Colors.white,
                  ),
                ),
              ),
            const SizedBox(height: 40),
            TextField(
              controller: _textController,
              decoration: const InputDecoration(
                labelText: "Enter text to generate QR",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _qrData = _textController.text.trim();
                });
              },
              child: const Text("Generate QR Code"),
            ),
          ],
        ),
      ),
    );
  }
}
