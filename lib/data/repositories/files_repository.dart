import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:universal_html/html.dart' as html;

class ReadFileFromFirebaseStorageFailure implements Exception {}

class SaveFileToFirebaseStorageFailure implements Exception {}

class NoFilePickedException implements Exception {}

class PlatformNotSupportedException implements Exception {}

class FilesRepository {
  final FirebaseStorage _firebaseStorage;

  FilesRepository({required FirebaseStorage firebaseStorage})
      : _firebaseStorage = firebaseStorage;

  Future<String> getDownloadUriFromPath({required String filePath}) async {
    var fileReference = _firebaseStorage.ref(filePath);
    return await fileReference.getDownloadURL();
  }

  Future<void> createNewClassFiles(
      {required String courseId, required String className}) async {
    try {
      Uint8List? data = Uint8List(0);
      await _firebaseStorage
          .ref('courses/$courseId/$className/$className.html')
          .putData(data);
    } catch (e) {
      print(e);
    }
  }

  Future<String> getFileDataAsString(
      {required String path, required String fileName}) async {
    try {
      Uint8List? data = await _firebaseStorage.ref(path).getData();

      if (data != null) {
        return String.fromCharCodes(data);
      }
      return '';
    } on Exception catch (e) {
      print(e.toString());
      throw ReadFileFromFirebaseStorageFailure();
    }
  }

  Future<void> downloadFile(String filePath) async {
    if (kIsWeb) {
      _webDownload(filePath);
    } else if (Platform.isAndroid) {
      _androidDownload(filePath);
    } else if (Platform.isIOS) {
      _iosDownload(filePath);
    } else {
      throw PlatformNotSupportedException();
    }
  }

  Future<void> _webDownload(String filePath) async {
    var fileReference = _firebaseStorage.ref(filePath);
    var downloadUrl = await fileReference.getDownloadURL();
    html.AnchorElement anchorElement =
        new html.AnchorElement(href: downloadUrl);
    anchorElement.download = downloadUrl;
    anchorElement.click();
  }

  Future<void> _androidDownload(String filePath) async {
    List<Directory>? directoriesList =
        await getExternalStorageDirectories(type: StorageDirectory.downloads);
    if (directoriesList != null) {
      if (directoriesList.isNotEmpty) {
        File downloadedFile =
            File(directoriesList.first.path + '/' + basename(filePath));
        await _firebaseStorage.ref(filePath).writeToFile(downloadedFile);
      }
    }
  }

  Future<void> _iosDownload(String filePath) async {}

  Future<void> saveTextFile(
      {required String path, required String text}) async {
    try {
      List<int> list = text.codeUnits;
      await _firebaseStorage.ref(path).putData(Uint8List.fromList(list));
    } catch (e) {
      print(e);
    }
  }

  Future<String> pickAndSentFile({required String pathToSent}) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        withData: true,
      );

      if (result != null) {
        Uint8List? fileBytes = result.files.first.bytes;
        String fileName = result.files.first.name;

        await _firebaseStorage.ref(pathToSent + fileName).putData(fileBytes!);

        return fileName;
      } else {
        throw (NoFilePickedException());
      }
    } catch (e) {
      print(e);
    }
    throw (SaveFileToFirebaseStorageFailure());
  }

  Future<String> pickAndSentUserPhoto({required String userId}) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['png'],
        withData: true,
        allowMultiple: false,
      );

      if (result != null) {
        Uint8List? fileBytes = result.files.first.bytes;

        await _firebaseStorage
            .ref('users/' + userId + '/photo.png')
            .putData(fileBytes!);

        return 'users/' + userId + '/photo.png';
      } else {
        throw (NoFilePickedException());
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

  Future<void> deleteClassDirectory(
      {required String directoryPath, required String className}) async {
    try {
      await _firebaseStorage
          .ref(directoryPath + '/' + className + '.html')
          .delete();
      ListResult referenceList =
          await _firebaseStorage.ref(directoryPath + '/materials').listAll();
      for (Reference fileReference in referenceList.items) {
        await fileReference.delete();
      }
    } catch (e) {
      print(e);
    }
  }
}
