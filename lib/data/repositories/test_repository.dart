import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:study_platform/constants/string_variables.dart';
import 'package:study_platform/data/models/course/test/test.dart';
import 'package:study_platform/data/models/course/test/user_test_result.dart';

class TestSaveToFirestoreException implements Exception {}

class TestReadFromFirestoreException implements Exception {}

class TestRepository {
  final FirebaseFirestore _firebaseFirestore;

  TestRepository({
    required FirebaseFirestore firebaseFirestore,
  }) : _firebaseFirestore = firebaseFirestore;

  Future<void> saveTest({
    required Test test,
    required String courseId,
  }) async {
    try {
      await _firebaseFirestore
          .collection('$kCourses/$courseId/$kTests')
          .doc(test.name)
          .set(test.toJson());
    } catch (e) {
      print(e);
      throw TestSaveToFirestoreException();
    }
  }

  Future<void> updateTestOpen({
    required Test test,
    required String courseId,
  }) async {
    try {
      await _firebaseFirestore
          .collection('$kCourses/$courseId/$kTests')
          .doc(test.name)
          .update({'open': test.open});
    } catch (e) {
      print(e);
      throw TestSaveToFirestoreException();
    }
  }

  Future<List<Test>> getCourseTests({required String courseId}) async {
    try {
      var snapshot = await _firebaseFirestore
          .collection('$kCourses/$courseId/$kTests')
          .get();

      List<Test> tests = [];

      for (QueryDocumentSnapshot doc in snapshot.docs) {
        tests.add(Test.fromJson(doc.data() as Map<String, dynamic>));
      }

      return tests;
    } catch (e) {
      print(e);
      throw Exception();
    }
  }

  Future<void> saveUserResult({
    required UserTestResult userTestResult,
    required String courseId,
    required testName,
  }) async {
    try {
      await _firebaseFirestore
          .collection('$kCourses/$courseId/$kTests/$testName/$kResults')
          .doc(userTestResult.userId)
          .set(userTestResult.toJson());
    } catch (e) {
      print(e);
      throw TestSaveToFirestoreException();
    }
  }

  Future<UserTestResult> getUserResult({
    required String userId,
    required String courseId,
    required String testName,
  }) async {
    try {
      var doc = await _firebaseFirestore
          .collection('$kCourses/$courseId/$kTests/$testName/$kResults')
          .doc(userId)
          .get();

      if (doc.exists) {
        return UserTestResult.fromJson(doc.data()!);
      } else {
        return UserTestResult(userId, '', 0);
      }
    } catch (e) {
      print(e);
      throw TestReadFromFirestoreException();
    }
  }

  Future<List<UserTestResult>> getResults(
      {required String courseId, required Test test}) async {
    try {
      var snapshot = await _firebaseFirestore
          .collection('$kCourses/$courseId/$kTests/${test.name}/$kResults')
          .get();

      List<UserTestResult> results = [];

      for (QueryDocumentSnapshot doc in snapshot.docs) {
        results
            .add(UserTestResult.fromJson(doc.data() as Map<String, dynamic>));
      }

      return results;
    } catch (e) {
      print(e);
      throw TestReadFromFirestoreException();
    }
  }
}
