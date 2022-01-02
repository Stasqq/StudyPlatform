import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:study_platform/data/models/course/class.dart';
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
      Course course = Course(
          documentReference.id, ownerUid, courseName, description, <Class>[], public);
      await _firebaseFirestore
          .collection('courses')
          .doc(documentReference.id)
          .set(course.toJson());
    } catch (_) {
      throw SaveNewCourseToFirestoreFailure();
    }
  }

  Stream<QuerySnapshot> getCourses() {
    print('getCourses');
    return _firebaseFirestore.collection('courses').limit(15).snapshots();
  }

  Stream<QuerySnapshot> getCoursesPage(DocumentSnapshot lastDoc) {
    print('getCoursesPage');
    return _firebaseFirestore
        .collection('courses')
        .startAfterDocument(lastDoc)
        .limit(15)
        .snapshots();
  }
}
