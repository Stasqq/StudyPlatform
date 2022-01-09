import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:study_platform/constants/string_variables.dart';
import 'package:study_platform/data/models/user/joined_course_with_rate.dart';
import 'package:study_platform/data/models/user/user_info.dart' as user_info;
import 'package:study_platform/utility/cache.dart';

class SaveUserInfoToFirestoreFailure implements Exception {}

class ReadUserInfoFromFirestoreFailure implements Exception {}

class UserInfoRepository {
  final FirebaseFirestore _firebaseFirestore;

  UserInfoRepository({
    required FirebaseFirestore firebaseFirestore,
    CacheClient? cacheClient,
  }) : _firebaseFirestore = firebaseFirestore;

  @visibleForTesting
  static const userCacheKey = '__user_info_cache_key__';

  Future<user_info.UserInfo> readUserInfo({
    required String email,
  }) async {
    try {
      var document =
          await _firebaseFirestore.collection(kUsers).doc(email).get();
      Map<String, dynamic>? userInfoMap = document.data();
      return user_info.UserInfo.fromJson(userInfoMap!);
    } catch (e) {
      print(e);
      throw ReadUserInfoFromFirestoreFailure();
    }
  }

  Future<void> saveUserInfoToFirebase({
    required user_info.UserInfo userInfo,
  }) async {
    try {
      await _firebaseFirestore
          .collection(kUsers)
          .doc(userInfo.email)
          .set(userInfo.toJson());
    } catch (_) {
      throw SaveUserInfoToFirestoreFailure();
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
      await _firebaseFirestore.collection(kUsers).doc(userEmail).update(
            ({kJoinedCourses: joinedCoursesMapsList}),
          );
    } catch (_) {
      throw SaveUserInfoToFirestoreFailure();
    }
  }
}
