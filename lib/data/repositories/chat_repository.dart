import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:study_platform/constants/string_variables.dart';
import 'package:study_platform/data/models/course/message.dart';

class SaveNewMessageToFirestoreFailure implements Exception {}

class ChatRepository {
  final FirebaseFirestore _firebaseFirestore;

  ChatRepository({
    required FirebaseFirestore firebaseFirestore,
  }) : _firebaseFirestore = firebaseFirestore;

  Future<void> sentNewMessage({
    required String courseId,
    required Message message,
  }) async {
    try {
      await _firebaseFirestore
          .collection('$kCourses/$courseId/$kChat')
          .add(message.toJson());
    } catch (e) {
      print(e);
      throw SaveNewMessageToFirestoreFailure();
    }
  }

  Stream<QuerySnapshot> getChatMessages({
    required String courseId,
  }) {
    return _firebaseFirestore
        .collection('$kCourses/$courseId/$kChat')
        .orderBy(kTimestamp)
        .limit(40)
        .snapshots();
  }

  Stream<QuerySnapshot> getMessagesPage({
    required String courseId,
    required DocumentSnapshot lastDoc,
  }) {
    return _firebaseFirestore
        .collection('$kCourses/$courseId/$kChat')
        .startAfterDocument(lastDoc)
        .orderBy(kTimestamp)
        .limit(40)
        .snapshots();
  }
}
