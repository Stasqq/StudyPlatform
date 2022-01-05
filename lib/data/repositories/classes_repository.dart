import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/course/class.dart';

class SaveNewClassToFirestoreFailure implements Exception {}

class ClassesRepository {
  final FirebaseFirestore _firebaseFirestore;

  ClassesRepository({required FirebaseFirestore firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore;

  Future<void> sentNewClass(
      {required String courseId, required Class newClass}) async {
    try {
      await _firebaseFirestore
          .collection('courses/' + courseId + '/classes')
          .doc(newClass.name)
          .set(newClass.toJson());
    } catch (e) {
      print(e);
      throw SaveNewClassToFirestoreFailure();
    }
  }

  Stream<QuerySnapshot> getClasses({required String courseId}) {
    return _firebaseFirestore
        .collection('courses/' + courseId + '/classes')
        .orderBy('orderIndex')
        .limit(40)
        .snapshots();
  }

  Stream<QuerySnapshot> getClassesPage(
      {required String courseId, required DocumentSnapshot lastDoc}) {
    return _firebaseFirestore
        .collection('courses/' + courseId + '/classes')
        .startAfterDocument(lastDoc)
        .orderBy('orderIndex')
        .limit(15)
        .snapshots();
  }

  Future<void> deleteClass(
      {required String courseId, required String className}) async {
    try {
      await _firebaseFirestore
          .collection('courses/' + courseId + '/classes')
          .doc(className)
          .delete();
    } catch (e) {
      print(e);
    }
  }

  Future<void> addClassMaterials(
      {required String fileName,
      required String courseId,
      required String className}) async {
    try {
      await _firebaseFirestore
          .collection('courses/' + courseId + '/classes')
          .doc(className)
          .update({
        'materials': FieldValue.arrayUnion([fileName])
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteClassMaterials(
      {required String fileName,
      required String courseId,
      required String className}) async {
    try {
      await _firebaseFirestore
          .collection('courses/' + courseId + '/classes')
          .doc(className)
          .update({
        'materials': FieldValue.arrayRemove([fileName])
      });
    } catch (e) {
      print(e);
    }
  }
}
