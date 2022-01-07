import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:study_platform/constants/string_variables.dart';
import 'package:study_platform/data/models/course/course.dart';
import 'package:study_platform/logic/bloc/courses_bloc/courses_bloc.dart';

class SaveNewCourseToFirestoreFailure implements Exception {}

class CoursesRepository {
  final FirebaseFirestore _firebaseFirestore;

  CoursesRepository({required FirebaseFirestore firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore;

  Future<void> createCourse({
    required String courseName,
    required String description,
    required String ownerEmail,
    required String ownerName,
    required bool public,
  }) async {
    try {
      var document = _firebaseFirestore.collection(kCourses).doc();
      var documentReference = await document.get();
      Course course = Course(documentReference.id, ownerEmail, ownerName,
          courseName, description, public);
      await _firebaseFirestore
          .collection(kCourses)
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
      case CoursesFilter.Public:
        return _firebaseFirestore
            .collection(kCourses)
            .where(kPublic, isEqualTo: true)
            .limit(15)
            .snapshots();
      case CoursesFilter.Owner:
        return _firebaseFirestore
            .collection(kCourses)
            .where(kOwnerUid, isEqualTo: ownerUid)
            .limit(15)
            .snapshots();
      case CoursesFilter.Joined:
        return _firebaseFirestore
            .collection(kCourses)
            .where(kId, whereIn: joinedCourses)
            .limit(15)
            .snapshots();
    }
  }

  Stream<QuerySnapshot> getCoursesPage(DocumentSnapshot lastDoc) {
    return _firebaseFirestore
        .collection(kCourses)
        .startAfterDocument(lastDoc)
        .limit(15)
        .snapshots();
  }

  Future<void> deleteCourse({
    required String courseId,
  }) async {
    try {
      await _firebaseFirestore.collection(kCourses).doc(courseId).delete();
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateJoinedCourses({
    required String userEmail,
    required List<String> coursesIds,
  }) async {
    try {
      await _firebaseFirestore
          .collection(kCourses)
          .doc(userEmail)
          .update({kJoinedCourses: coursesIds});
    } catch (e) {
      print(e);
    }
  }
}
