import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:qr_flutter/qr_flutter.dart';

/// A widget to display a QR code with sharing and downloading options.
class QRCodeDisplay extends StatelessWidget {
  // The data to be encoded in the QR code.
  final String qrData;
  
  // Controller for capturing a screenshot of the QR code.
  final ScreenshotController screenshotController;
  
  // Function to handle sharing the QR code.
  final Future<void> Function() shareQRCode;
  
  // Function to handle downloading the QR code.
  final Future<void> Function() downloadQRCode;

  // Constructor with required parameters.
  const QRCodeDisplay({
    Key? key,
    required this.qrData,
    required this.screenshotController,
    required this.shareQRCode,
    required this.downloadQRCode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Card to display the QR code with rounded corners and padding.
        Card(
          color: Colors.white,  // White background for the card.
          elevation: 0,  // No shadow effect.
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            
            // Screenshot widget to capture the QR code image.
            child: Screenshot(
              controller: screenshotController,
              child: Container(
                color: Colors.white,  // QR code background color.
                padding: const EdgeInsets.all(16),
                
                // QR code generation using qr_flutter package.
                child: QrImageView(
                  data: qrData,  // The data to encode in QR code.
                  version: QrVersions.auto,  // Automatically choose QR version.
                  size: 200,  // Size of the QR code.
                  errorCorrectionLevel: QrErrorCorrectLevel.H,  // High error correction level.
                ),
              ),
            ),
          ),
        ),
        
        const SizedBox(height: 16),

        // Button to share the QR code.
        ElevatedButton.icon(
          onPressed: shareQRCode,  // Triggers the share function.
          icon: const Icon(Icons.share),
          label: const Text("Share QR Code"),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,  // White button background.
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),

        const SizedBox(height: 8),

        // Button to download the QR code.
        ElevatedButton.icon(
          onPressed: downloadQRCode,  // Triggers the download function.
          icon: const Icon(Icons.download),
          label: const Text("Download QR Code"),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,  // White button background.
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ],
    );
  }
}
