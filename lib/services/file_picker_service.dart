import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';

class FilePickerService extends ChangeNotifier {
  bool isLoading = false;

  FilePickerService();

  void updateLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  Future<String?> getSingleFile() async {
    updateLoading();
    // pick files
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowedExtensions: ['csv'],
      type: FileType.custom,
      onFileLoading: (FilePickerStatus pickerStatus) {
        print('picking');
        print(describeEnum(pickerStatus));
      },
      withReadStream: true,
    );
    updateLoading();
    //
    if (result != null) {
      final path = result.files.single.path;
      if (path == null || path == '') return null;
      File file = File(path);
      final contents = await file.readAsString();
      return contents;
    }
    return null;
  }

  Future<String?> pickDirectory() async {
    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
    print(selectedDirectory);
    // I wanna read all the file in the current directory
    if (selectedDirectory == null) return null;
  }
}
