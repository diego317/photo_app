import 'package:flutter_riverpod/flutter_riverpod.dart';

// This provider holds the state of the upload list
final uploadListProvider =
    StateNotifierProvider<UploadListNotifier, List<Map<String, dynamic>>>(
        (ref) {
  return UploadListNotifier();
});

// A simple state notifier for managing the list of uploaded images
class UploadListNotifier extends StateNotifier<List<Map<String, dynamic>>> {
  UploadListNotifier() : super([]);

  void addUpload(Map<String, dynamic> upload) {
    state = [...state, upload];
  }
}
