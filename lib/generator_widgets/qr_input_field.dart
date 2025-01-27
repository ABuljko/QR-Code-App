import 'package:flutter/material.dart';

/// A stateless widget that provides an input field for naming a QR code.
class QRInputField extends StatelessWidget {
  // Controller to manage the text input for the QR code name.
  final TextEditingController qrNameController;

  // Constructor with required controller parameter.
  const QRInputField({Key? key, required this.qrNameController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      // Add spacing below the text field for layout purposes.
      padding: const EdgeInsets.only(bottom: 16),
      
      child: TextField(
        // Assign the provided controller to the text field.
        controller: qrNameController,
        
        decoration: InputDecoration(
          // Label displayed inside the text field when empty.
          labelText: 'QR Code Name',
          
          // Styling for the input field border with rounded corners.
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
