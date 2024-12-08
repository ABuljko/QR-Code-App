import 'package:flutter/material.dart';
import 'generate_qr_page.dart'; // Import the Generate QR Code page

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("QR Code App"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.qr_code, size: 100, color: Colors.blue),
            const SizedBox(height: 20),
            const Text(
              "QR Code App",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: () {
                // Add scanning logic here
              },
              icon: const Icon(Icons.camera_alt),
              label: const Text("Scan QR Code"),
            ),
            const SizedBox(height: 20),
            OutlinedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GenerateQrPage()),
                );
              },
              icon: const Icon(Icons.qr_code_2),
              label: const Text("Generate QR Code"),
            ),
          ],
        ),
      ),
    );
  }
}
