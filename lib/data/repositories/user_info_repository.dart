import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:study_platform/utility/cache.dart';
import 'package:study_platform/data/models/user/user_info.dart' as user_info;

class SaveUserInfoToFirestoreFailure implements Exception {}

class ReadUserInfoFromFirestoreFailure implements Exception {}

class UserInfoRepository {
  final FirebaseFirestore _firebaseFirestore;

  UserInfoRepository(
      {required FirebaseFirestore firebaseFirestore, CacheClient? cacheClient})
      : _firebaseFirestore = firebaseFirestore;

  @visibleForTesting
  static const userCacheKey = '__user_info_cache_key__';

  Future<user_info.UserInfo> readUserInfo({required String email}) async {
    try {
      var document = await _firebaseFirestore.collection('users').doc(email).get();
      Map<String, dynamic>? userInfoMap = document.data();
      return user_info.UserInfo.fromJson(userInfoMap!);
    } catch (e) {
      print(e);
      throw ReadUserInfoFromFirestoreFailure();
    }
  }

  Future<void> saveUserInfoToFirebase({required user_info.UserInfo userInfo}) async {
    try {
      await _firebaseFirestore
          .collection('users')
          .doc(userInfo.email)
          .set(userInfo.toJson());
    } catch (_) {
      throw SaveUserInfoToFirestoreFailure();
    }
  }

  Future<void> updateJoinedCourses(
      {required String uid, required List<String> joinedCourses}) async {
    try {
      await _firebaseFirestore
          .collection('users')
          .doc(uid)
          .update(({'joinedCourses', joinedCourses} as Map<String, dynamic>));
    } catch (_) {
      throw SaveUserInfoToFirestoreFailure();
    }
  }
}
