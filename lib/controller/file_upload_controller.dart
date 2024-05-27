import 'dart:io';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FileUploadController {
  // ----- upload picked image file to the firebase storeage bucket and return the download link

  static UploadTask? uplaodFile(File file, String folderName) {
    try {
      // ----- getting the filename from the file path

      final String fileName = basename(file.path);

      // ----- defining the file storage distination in the firebase storeage

      final String destination = '$folderName/$fileName';

      // ----- creating the firebase storage instance with destination file location

      final ref = FirebaseStorage.instance.ref(destination);

      // -----

      final task = ref.putFile(file);

      return task;
    } catch (e) {
      // ignore: avoid_print

      return null;
    }
  }
}
