import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:study_platform/data/models/course/class.dart';
import 'package:study_platform/data/models/course/course.dart';
import 'package:study_platform/logic/bloc/courses_bloc/courses_bloc.dart';

class SaveNewCourseToFirestoreFailure implements Exception {}

class CoursesRepository {
  final FirebaseFirestore _firebaseFirestore;

  CoursesRepository({required FirebaseFirestore firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore;

  Future<void> createCourse(
      {required String courseName,
      required String description,
      required String ownerUid,
      required String ownerName,
      required bool public}) async {
    try {
      var document = _firebaseFirestore.collection('courses').doc();
      var documentReference = await document.get();
      Course course = Course(documentReference.id, ownerUid, ownerName, courseName,
          description, <Class>[], public);
      await _firebaseFirestore
          .collection('courses')
          .doc(documentReference.id)
          .set(course.toJson());
    } catch (_) {
      throw SaveNewCourseToFirestoreFailure();
    }
  }

  Stream<QuerySnapshot> getCourses(
      {required CoursesFilter coursesFilter,
      String? ownerUid,
      List<String>? joinedCourses}) {
    switch (coursesFilter) {
      case CoursesFilter.All:
        return _firebaseFirestore
            .collection('courses')
            .where('public', isEqualTo: true)
            .limit(15)
            .snapshots();
      case CoursesFilter.Owner:
        return _firebaseFirestore
            .collection('courses')
            .where('ownerUid', isEqualTo: ownerUid)
            .limit(15)
            .snapshots();
      case CoursesFilter.Joined:
        return _firebaseFirestore
            .collection('courses')
            .where('id', whereIn: joinedCourses)
            .limit(15)
            .snapshots();
    }
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
