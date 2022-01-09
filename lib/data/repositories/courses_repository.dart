import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:study_platform/constants/string_variables.dart';
import 'package:study_platform/data/models/course/course.dart';
import 'package:study_platform/data/models/user/joined_course_with_rate.dart';
import 'package:study_platform/logic/bloc/courses_bloc/courses_bloc.dart';

class SaveNewCourseToFirestoreFailure implements Exception {}

class UpdateCourseInFirestoreFailure implements Exception {}

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
          courseName, description, public, 0, 0);
      await _firebaseFirestore
          .collection(kCourses)
          .doc(documentReference.id)
          .set(course.toJson());
    } catch (_) {
      throw SaveNewCourseToFirestoreFailure();
    }
  }

  Stream<QuerySnapshot> getCourses({
    required CoursesFilter coursesFilter,
    String? ownerEmail,
    List<String>? joinedCoursesIds,
  }) {
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
            .where(kOwnerEmail, isEqualTo: ownerEmail)
            .limit(15)
            .snapshots();
      case CoursesFilter.Joined:
        return _firebaseFirestore
            .collection(kCourses)
            .where(kId, whereIn: joinedCoursesIds)
            .limit(15)
            .snapshots();
    }
  }

  Stream<QuerySnapshot> getCoursesPage({
    required CoursesFilter coursesFilter,
    String? ownerEmail,
    List<String>? joinedCoursesIds,
    required DocumentSnapshot lastDoc,
  }) {
    switch (coursesFilter) {
      case CoursesFilter.Public:
        return _firebaseFirestore
            .collection(kCourses)
            .where(kPublic, isEqualTo: true)
            .startAfterDocument(lastDoc)
            .limit(15)
            .snapshots();
      case CoursesFilter.Owner:
        return _firebaseFirestore
            .collection(kCourses)
            .where(kOwnerEmail, isEqualTo: ownerEmail)
            .startAfterDocument(lastDoc)
            .limit(15)
            .snapshots();
      case CoursesFilter.Joined:
        return _firebaseFirestore
            .collection(kCourses)
            .where(kId, whereIn: joinedCoursesIds)
            .startAfterDocument(lastDoc)
            .limit(15)
            .snapshots();
    }
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
    required List<JoinedCourseWithRate> joinedCourses,
  }) async {
    try {
      List<Map<String, dynamic>> joinedCoursesMapsList = [];

      joinedCourses.forEach((element) {
        joinedCoursesMapsList.add(element.toJson());
      });

      await _firebaseFirestore
          .collection(kUsers)
          .doc(userEmail)
          .update({kJoinedCourses: joinedCoursesMapsList});
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateCourse({
    required Course course,
  }) async {
    try {
      await _firebaseFirestore
          .collection('$kCourses')
          .doc(course.id)
          .set(course.toJson());
    } catch (_) {
      throw UpdateCourseInFirestoreFailure();
    }
  }
}
