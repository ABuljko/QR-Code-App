import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code/scanner_widgets/scanned_results.dart'; 

/// A screen that allows users to scan QR codes using their device camera.
class QRScannerScreen extends StatefulWidget {
  const QRScannerScreen({super.key});

  @override
  State<QRScannerScreen> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  // Variable to check if the camera permission is granted
  bool hasPermission = false;

  // Variable to track whether the flashlight is turned on or off
  bool isFlashOn = false;

  // Controller to handle QR code scanning
  late MobileScannerController scannerController;

  @override
  void initState() {
    super.initState();
    scannerController = MobileScannerController(); // Initialize scanner controller
    _checkPermission(); // Request camera permission when the screen loads
  }

  @override
  void dispose() {
    scannerController.dispose(); // Dispose of scanner resources when the screen is closed
    super.dispose();
  }

  /// Checks for camera permission and updates state accordingly.
  Future<void> _checkPermission() async {
    final status = await Permission.camera.request(); // Request camera permission
    setState(() {
      hasPermission = status.isGranted; // Update permission status
    });
  }

  /// Processes the scanned QR code data and determines its type.
  Future<void> _processScannedData(String? data) async {
    if (data == null) return; // Exit if the scanned data is null

    scannerController.stop(); // Stop scanning when data is detected

    String type = "text"; // Default type as plain text
    String password = ""; // Variable to store Wi-Fi password if detected

    // Determine the type of QR code content based on its prefix
    if (data.startsWith('BEGIN:VCARD')) {
      type = 'contact'; // QR code contains contact information (vCard)
    } else if (data.startsWith('http://') || data.startsWith('https://')) {
      type = 'url'; // QR code contains a URL link
    } else if (data.startsWith('WIFI:')) {
      type = 'wifi'; // QR code contains Wi-Fi details
      final passwordMatch = RegExp(r'P:(.*?);').firstMatch(data); // Extract Wi-Fi password
      password = passwordMatch?.group(1) ?? ''; // Assign the extracted password if found
    }

    // Show the scanned results in a bottom sheet dialog
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allows the bottom sheet to be fully expanded
      backgroundColor: Colors.transparent, // Transparent background
      builder: (context) => ScannedResults(
        data: data, // Scanned QR code data
        type: type, // Type of QR code (text, URL, Wi-Fi, contact)
        password: password.isNotEmpty ? password : null, // Pass Wi-Fi password if available
        onRescan: () {
          Navigator.pop(context); // Close the bottom sheet
          scannerController.start(); // Restart the scanner
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo, // Set background color for the screen
      appBar: AppBar(
        title: Text(
          "Scan QR Code",
          style: GoogleFonts.poppins(), // Apply custom font style
        ),
        backgroundColor: Colors.indigo, // App bar background color
        foregroundColor: Colors.white, // Text color for the app bar
        actions: [
          // Flashlight toggle button in the app bar
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: IconButton(
              icon: Icon(isFlashOn ? Icons.flash_on : Icons.flash_off), // Flash on/off icon
              onPressed: () {
                setState(() {
                  isFlashOn = !isFlashOn; // Toggle flashlight state
                });
                scannerController.toggleTorch(); // Toggle device flashlight
              },
            ),
          ),
        ],
      ),
      body: hasPermission
          ? MobileScanner(
              controller: scannerController, // Pass the scanner controller
              onDetect: (capture) {
                final barcode = capture.barcodes.first; // Get the first detected barcode
                if (barcode.rawValue != null) {
                  _processScannedData(barcode.rawValue); // Process the scanned QR code data
                }
              },
            )
          : const Center(
              child: Text("Camera Permission Required"), // Show message if permission is denied
            ),
    );
  }
}
