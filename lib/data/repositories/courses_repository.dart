import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:study_platform/data/models/course/course.dart';

class SaveNewCourseToFirestoreFailure implements Exception {}

class CoursesRepository {
  final FirebaseFirestore _firebaseFirestore;

  CoursesRepository({required FirebaseFirestore firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore;

  Future<void> createCourse(
      {required String courseName,
      required String description,
      required String ownerUid,
      required bool public}) async {
    try {
      var document = _firebaseFirestore.collection('courses').doc();
      var documentReference = await document.get();
      Course course = Course.withoutClasses(
          documentReference.id, ownerUid, courseName, description, public);
      await _firebaseFirestore
          .collection('courses')
          .doc(documentReference.id)
          .set(course.toJson());
    } catch (_) {
      throw SaveNewCourseToFirestoreFailure();
    }
  }
}
