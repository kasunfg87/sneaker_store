// ignore_for_file: depend_on_referenced_packages

import 'dart:io';
import 'package:logger/logger.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FileUploadController {
  // Uploads a picked image file to Firebase Storage and returns the upload task
  static UploadTask? uploadFile(File file, String folderName) {
    try {
      // Get the filename from the file path
      final String fileName = basename(file.path);

      // Define the file storage destination in Firebase Storage
      final String destination = '$folderName/$fileName';

      // Create a Firebase Storage reference with the destination file location
      final ref = FirebaseStorage.instance.ref(destination);

      // Upload the file to the specified location
      final task = ref.putFile(file);

      return task;
    } catch (e) {
      // Log the error and return null if upload fails
      Logger().e(e);
      return null;
    }
  }
}
