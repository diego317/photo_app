import 'package:flutter/material.dart';
import 'package:photo_app/screens/camera_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Camera App',
      home: CameraScreen(),
    );
  }
}
