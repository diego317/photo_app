import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:photo_app/providers/upload_provider.dart';
import 'camera_screen.dart';

class UploadListScreen extends ConsumerWidget {
  const UploadListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uploads = ref.watch(uploadListProvider);
    print("uploads: $uploads");

    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.camera),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CameraScreen()),
              );
            },
          ),
        ],
      ),
      body: uploads.isEmpty
          ? const Center(child: Text('No uploads yet.'))
          : ListView.builder(
              itemCount: uploads.length,
              itemBuilder: (context, index) {
                final upload = uploads[index];
                return ListTile(
                  leading: Image.network(upload['url']),
                  title: Text('Uploaded on ${upload['timestamp']}'),
                  subtitle: Text('Timestamp: ${upload['timestamp']}'),
                );
              },
            ),
    );
  }
}
