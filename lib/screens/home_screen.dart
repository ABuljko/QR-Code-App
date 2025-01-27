import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_code/screens/qr_generator_screen.dart';
import 'package:qr_code/screens/qr_scanner_screen.dart';

/// The HomeScreen widget serves as the main entry point of the QR Code app.
/// It provides options to either generate a QR code or scan one.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo, // Set background color of the screen
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20), // Add spacing at the top
            Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                "QR Code App",
                style: GoogleFonts.poppins(
                  fontSize: 32, // Large font size for the title
                  fontWeight: FontWeight.bold, // Bold text style
                  color: Colors.white, // White text color
                ),
              ),
            ),
            const SizedBox(height: 50), // Add spacing between title and buttons
            Center(
              child: Container(
                padding: const EdgeInsets.all(50), // Padding inside the container
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface, // Theme-based background color
                  borderRadius: BorderRadius.circular(24), // Rounded corners for the container
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1), // Light shadow effect
                      blurRadius: 10,
                      spreadRadius: 5,
                    )
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center, // Center items vertically
                  crossAxisAlignment: CrossAxisAlignment.center, // Center items horizontally
                  children: [
                    // Button to navigate to QR Generator screen
                    _buildFeatureButton(
                      context,
                      "Generate QR Code",
                      Icons.qr_code,
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const QRGeneratorScreen(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20), // Space between buttons

                    // Button to navigate to QR Scanner screen
                    _buildFeatureButton(
                      context,
                      "Scan QR Code",
                      Icons.qr_code_scanner,
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const QRScannerScreen(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds a feature button with an icon and text.
  /// 
  /// Parameters:
  /// - [context]: Build context for navigation.
  /// - [title]: Text displayed on the button.
  /// - [icon]: Icon to be shown on the button.
  /// - [onPressed]: Function to execute when the button is tapped.
  Widget _buildFeatureButton(BuildContext context, String title, IconData icon,
      VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed, // Execute the provided function on tap
      child: Container(
        padding: const EdgeInsets.all(15), // Padding inside the button
        height: 200, // Button height
        width: 250, // Button width
        decoration: BoxDecoration(
          color: Colors.indigo, // Button background color
          borderRadius: BorderRadius.circular(15), // Rounded corners
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Evenly distribute content
          children: [
            Icon(icon, size: 90, color: Colors.white), // Display the icon
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 20, // Font size of the title
                fontWeight: FontWeight.bold, // Bold text
                color: Colors.white, // White text color
              ),
            ),
          ],
        ),
      ),
    );
  }
}
