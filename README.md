# QR Code App

A Flutter application for generating and scanning QR codes. This app allows users to create QR codes for text, URLs, and contact details, as well as scan QR codes to retrieve and share the encoded information. The app is designed with a user-friendly interface and provides seamless functionality for both generating and scanning QR codes.

## Features

- **Generate QR Codes**: Create QR codes for plain text, URLs, and contact details (vCard). The app supports various types of QR codes to cater to different needs.
- **Scan QR Codes**: Scan QR codes using the device camera to retrieve and process the encoded information. The app can detect and handle different types of QR codes, providing relevant actions based on the content.
- **Share and Download**: Share or download the generated QR codes as images. This feature allows users to easily distribute their QR codes via different platforms or save them for future use.

## Screenshots

![Image](https://github.com/user-attachments/assets/9542192d-4061-473b-84cc-f423599d2a07)
![Image](https://github.com/user-attachments/assets/78a31f85-8db4-40e9-9187-9472d2278140)
![Image](https://github.com/user-attachments/assets/6491167c-0098-480d-a006-caf2853e51b5)

## Getting Started

### Prerequisites

- [Flutter](https://flutter.dev/docs/get-started/install) (version 2.0 or higher)
- [Dart](https://dart.dev/get-dart)

## Usage

### Home Screen

The home screen provides options to either generate a QR code or scan one. It serves as the main entry point of the app, offering a user-friendly interface to navigate to the desired functionality.

### QR Generator Screen

- **Text**: Enter plain text to generate a QR code. This can be used for simple messages or notes.
- **URL**: Enter a URL to generate a QR code. This is useful for sharing links to websites, social media profiles, or any online resource.
- **Details**: Enter contact details (name, phone, email) to generate a vCard QR code. This is ideal for sharing contact information quickly and efficiently.
- **Share**: Share the generated QR code via various platforms such as email, messaging apps, or social media.
- **Download**: Download the generated QR code as an image file to your device for offline use or printing.

### QR Scanner Screen

- **Scan**: Use the device camera to scan QR codes. The app will automatically detect and process the QR code data.
- **Flashlight**: Toggle the flashlight on/off to improve scanning in low-light conditions.
- **Results**: View the scanned QR code data and perform actions like opening URLs, copying text, or sharing the data. The app intelligently identifies the type of data (e.g., URL, contact, Wi-Fi) and provides relevant actions.

## Dependencies

- [flutter](https://flutter.dev/): The framework used to build the app.
- [google_fonts](https://pub.dev/packages/google_fonts): For custom fonts.
- [mobile_scanner](https://pub.dev/packages/mobile_scanner): For scanning QR codes.
- [permission_handler](https://pub.dev/packages/permission_handler): For handling permissions.
- [screenshot](https://pub.dev/packages/screenshot): For capturing screenshots of the generated QR codes.
- [share_plus](https://pub.dev/packages/share_plus): For sharing QR codes.
- [path_provider](https://pub.dev/packages/path_provider): For accessing device storage.
- [qr_flutter](https://pub.dev/packages/qr_flutter): For generating QR codes.
- [url_launcher](https://pub.dev/packages/url_launcher): For opening URLs.

