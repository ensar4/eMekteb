import 'dart:convert';
import 'dart:typed_data'; // For Uint8List
import 'package:flutter/material.dart'; // Import Flutter's ImageProvider widget

ImageProvider<Object> imageFromBase64String(String base64Image) {
  Uint8List imageBytes = base64Decode(base64Image);  // Decode the base64 string into bytes
  return MemoryImage(imageBytes);  // Return an ImageProvider from the bytes
}
