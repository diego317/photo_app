import 'package:flutter/material.dart';
import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:path_provider/path_provider.dart';
import 'package:better_open_file/better_open_file.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:photo_app/providers/upload_provider.dart';

class CameraScreen extends ConsumerWidget {
  const CameraScreen({super.key});

  Future<String> _getFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    final path =
        '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';
    print('File path generated: $path'); // Debug print
    return path;
  }

  Future<void> _uploadImage(WidgetRef ref, String filePath) async {
    try {
      final file = File(filePath);
      await Future.delayed(Duration(seconds: 2));

      if (!await file.exists()) {
        print('File does not exist at path: $filePath');
        return; // Exit the method if the file does not exist
      }

      final storageRef = FirebaseStorage.instance
          .ref()
          .child('uploads/${DateTime.now().millisecondsSinceEpoch}.jpg');

      print('Firebase Storage Reference: ${storageRef.fullPath}');

      final uploadTask = storageRef.putFile(file);
      await uploadTask.whenComplete(() => print('Upload complete'));

      final imageUrl = await storageRef.getDownloadURL();
      print('Upload successful, image URL: $imageUrl');

      // // Add document to Firestore
      // var docRef = await FirebaseFirestore.instance.collection('uploads').add({
      //   'url': imageUrl,
      //   'timestamp': FieldValue.serverTimestamp(),
      // });

      // Update the upload list
      ref.read(uploadListProvider.notifier).addUpload({
        'url': imageUrl,
        'timestamp': DateTime.now(),
      });

      print('Upload added to list');
    } catch (e, stackTrace) {
      print('Failed to upload image: $e');
      print('Stack trace: $stackTrace');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera Awesome'),
      ),
      body: CameraAwesomeBuilder.awesome(
        saveConfig: SaveConfig.photo(pathBuilder: () async {
          final filePath = await _getFilePath();
          _uploadImage(ref, filePath);
          return filePath;
        }),
        enablePhysicalButton: true,
        filter: AwesomeFilter.AddictiveRed,
        flashMode: FlashMode.auto,
        aspectRatio: CameraAspectRatios.ratio_16_9,
        previewFit: CameraPreviewFit.fitWidth,
        onMediaTap: (mediaCapture) async {
          print('Media captured: ${mediaCapture.filePath}'); // Debug print
          await _uploadImage(
              ref, mediaCapture.filePath); // Call upload after saving
          OpenFile.open(mediaCapture.filePath);
        },
      ),
    );
  }
}
