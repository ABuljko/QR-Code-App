import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_code/generator_widgets/qr_input_field.dart';
import 'package:qr_code/generator_widgets/qr_code_display.dart';

/// Stateful widget for generating QR codes.
class QRGeneratorScreen extends StatefulWidget {
  const QRGeneratorScreen({super.key});

  @override
  State<QRGeneratorScreen> createState() => _QRGeneratorScreenState();
}

class _QRGeneratorScreenState extends State<QRGeneratorScreen> {
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _qrNameController = TextEditingController();
  final ScreenshotController _screenshotController = ScreenshotController();

  final Map<String, TextEditingController> _controllers = {
    'name': TextEditingController(),
    'phone': TextEditingController(),
    'email': TextEditingController(),
    'url': TextEditingController(),
  };

  String qrData = '';
  String selectedType = 'text';

  String _generateQRData() {
    switch (selectedType) {
      case 'detail':
        return '''BEGIN:VCARD
VERSION 3.0
FN:${_controllers['name']?.text}
TEL:${_controllers['phone']?.text}
EMAIL:${_controllers['email']?.text}
END:VCARD''';

      case 'url':
        String url = _controllers['url']?.text ?? '';
        if (!url.startsWith('http://') && !url.startsWith('https://')) {
          url = 'https://$url';
        }
        return url;

      default:
        return _textController.text;
    }
  }

  Future<void> _shareQRCode() async {
    final directory = await getApplicationDocumentsDirectory();
    final imagePath = '${directory.path}/qr_code.png';

    final capture = await _screenshotController.capture();
    if (capture == null) return;

    File imageFile = File(imagePath);
    await imageFile.writeAsBytes(capture);

    await Share.shareXFiles([XFile(imagePath)], text: 'Share QR Code');
  }

  Future<void> _downloadQRCode() async {
    if (_qrNameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please enter a name for the QR code before downloading.',
            style: GoogleFonts.poppins(),
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final qrName = _qrNameController.text;
    final directory = Directory('/storage/emulated/0/Download');
    final imagePath = '${directory.path}/$qrName.png';

    final capture = await _screenshotController.capture();
    if (capture == null) return;

    File imageFile = File(imagePath);
    await imageFile.writeAsBytes(capture);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'QR Code downloaded as $qrName.png',
          style: GoogleFonts.poppins(),
        ),
      ),
    );
  }

  Widget _buildInputFields() {
    switch (selectedType) {
      case 'detail':
        return Column(
          children: [
            _buildTextField(_controllers['name']!, "Name", TextInputType.text),
            _buildTextField(_controllers['phone']!, "Phone", TextInputType.phone),
            _buildTextField(_controllers['email']!, "Email", TextInputType.emailAddress),
          ],
        );

      case 'url':
        return _buildTextField(_controllers['url']!, "URL", TextInputType.url);

      default:
        return _buildTextField(_textController, "Enter Text", TextInputType.text);
    }
  }

  Widget _buildTextField(TextEditingController controller, String label,
      TextInputType keyboardType) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: GoogleFonts.poppins(),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        style: GoogleFonts.poppins(),
        onChanged: (_) {
          setState(() {
            qrData = _generateQRData();
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text("Generate QR Code", style: GoogleFonts.poppins()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Card(
                color: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      QRInputField(qrNameController: _qrNameController),

                      SizedBox(
                        width: double.infinity,
                        child: SegmentedButton<String>(
                          selected: {selectedType},
                          onSelectionChanged: (Set<String> selection) {
                            setState(() {
                              selectedType = selection.first;
                              qrData = '';
                            });
                          },
                          segments: [
                            ButtonSegment(
                                value: 'text',
                                label: Text("Text", style: GoogleFonts.poppins())),
                            ButtonSegment(
                                value: 'url',
                                label: Text("URL", style: GoogleFonts.poppins())),
                            ButtonSegment(
                                value: 'detail',
                                label: Text("Details", style: GoogleFonts.poppins())),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      _buildInputFields(),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              if (qrData.isNotEmpty)
                QRCodeDisplay(
                  qrData: qrData,
                  screenshotController: _screenshotController,
                  shareQRCode: _shareQRCode,
                  downloadQRCode: _downloadQRCode,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
