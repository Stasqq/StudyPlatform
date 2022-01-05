import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class SaveFileToFirebaseStorageFailure implements Exception {}

class FilesRepository {
  final FirebaseStorage _firebaseStorage;

  FilesRepository({required FirebaseStorage firebaseStorage})
      : _firebaseStorage = firebaseStorage;

  Future<void> createNewClassFiles(
      {required String courseId, required String className}) async {
    try {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      File newHtmlFile =
          await File(appDocDir.absolute.path + '/class_content.html').create();
      await _firebaseStorage
          .ref('courses/$courseId/$className/$className.html')
          .putFile(newHtmlFile);
      newHtmlFile.delete();
    } catch (e) {
      print(e);
    }
  }

  Future<File?> getFile(
      {required String path, required String fileName}) async {
    try {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      File downloadedFile =
          await File(appDocDir.absolute.path + '/' + fileName).create();
      await _firebaseStorage.ref(path).writeToFile(downloadedFile);
      return downloadedFile;
    } catch (e) {
      print(e);
    }
  }

  Future<String> pickAndSentFile({required String pathToSent}) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        File file = File(result.files.single.path!);

        await _firebaseStorage
            .ref(pathToSent + basename(file.path))
            .putFile(file);

        return basename(file.path);
      }
    } catch (e) {
      print(e);
    }
    throw (SaveFileToFirebaseStorageFailure());
  }

  Future<void> deleteFile({required String filePath}) async {
    try {
      await _firebaseStorage.ref(filePath).delete();
    } catch (e) {
      print(e);
    }
  }
}
