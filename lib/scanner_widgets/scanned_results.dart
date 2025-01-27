import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

/// A widget that displays the results of a scanned QR code.
class ScannedResults extends StatelessWidget {
  // The scanned QR code data
  final String data;

  // The detected type of the QR code (e.g., URL, contact, Wi-Fi)
  final String type;

  // Extracted Wi-Fi password if available
  final String? password;

  // Callback to trigger rescanning
  final VoidCallback onRescan;

  const ScannedResults({
    super.key,
    required this.data,
    required this.type,
    this.password,
    required this.onRescan,
  });

  /// Opens the scanned URL in the default web browser.
  Future<void> _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      // Initial height of the bottom sheet (60% of screen height)
      initialChildSize: 0.6, 
      
      // Minimum height (40% of screen height)
      minChildSize: 0.4, 
      
      // Maximum height (90% of screen height)
      maxChildSize: 0.9, 
      
      builder: (context, controller) => Container(
        decoration: BoxDecoration(
          // Set the background color based on the theme
          color: Theme.of(context).colorScheme.surface,
          
          // Rounded corners at the top
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Draggable indicator bar at the top of the bottom sheet
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 24),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),

            // Title for the scanned result section
            Text(
              "Scanned Result:",
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            // Display the type of scanned data (e.g., URL, text, Wi-Fi)
            Text(
              "Type: ${type.toUpperCase()}",
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),

            const SizedBox(height: 16),

            // Display scanned QR code content in a scrollable area
            Expanded(
              child: SingleChildScrollView(
                controller: controller,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Allow user to select and copy the scanned data
                    SelectableText(
                      data,
                      style: GoogleFonts.poppins(fontSize: 14),
                    ),

                    const SizedBox(height: 24),

                    // If the scanned data is a URL, show action buttons
                    if (type == 'url')
                      Column(
                        children: [
                          // Button to open the URL in the browser
                          ElevatedButton.icon(
                            onPressed: () => _launchURL(data),
                            icon: const Icon(Icons.open_in_new),
                            label: const Text("Open URL"),
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size.fromHeight(50),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Button to copy the URL to clipboard
                          ElevatedButton.icon(
                            onPressed: () {
                              Clipboard.setData(ClipboardData(text: data));
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("URL copied to clipboard!")),
                              );
                            },
                            icon: const Icon(Icons.copy),
                            label: const Text("Copy URL"),
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size.fromHeight(50),
                            ),
                          ),
                        ],
                      ),

                    // If the scanned data is a Wi-Fi QR code, show a copy password button
                    if (type == 'wifi' && password != null && password!.isNotEmpty)
                      ElevatedButton.icon(
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: password!));
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Password copied to clipboard!")),
                          );
                        },
                        icon: const Icon(Icons.copy),
                        label: const Text("Copy Password"),
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50),
                        ),
                      ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Action buttons: Share and Rescan
            Row(
              children: [
                Expanded(
                  // Button to share the scanned QR code data
                  child: OutlinedButton.icon(
                    onPressed: () => Share.share(data),
                    icon: const Icon(Icons.share),
                    label: const Text("Share"),
                  ),
                ),
                const SizedBox(width: 16),

                Expanded(
                  // Button to trigger QR code rescanning
                  child: OutlinedButton.icon(
                    onPressed: onRescan,
                    icon: const Icon(Icons.qr_code_scanner),
                    label: const Text("Rescan"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
