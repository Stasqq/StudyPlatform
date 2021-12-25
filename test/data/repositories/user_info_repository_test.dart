import 'package:cloud_firestore/cloud_firestore.dart' as firebase_firestore;
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:study_platform/data/models/user/user_info.dart';
import 'package:study_platform/data/repositories/user_info_repository.dart';
import 'package:study_platform/utility/cache.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';

mixin LegacyEquality {
  @override
  bool operator ==(dynamic other) => false;

  @override
  int get hashCode => 0;
}

class MockCacheClient extends Mock implements CacheClient {}

class MockFirebaseAuth extends Mock implements firebase_auth.FirebaseAuth {}

class MockFirebaseFirestore extends Mock implements firebase_firestore.FirebaseFirestore {
}

class FakeAuthCredential extends Fake implements firebase_auth.AuthCredential {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  MethodChannelFirebase.channel.setMockMethodCallHandler((call) async {
    if (call.method == 'Firebase#initializeCore') {
      return [
        {
          'name': defaultFirebaseAppName,
          'options': {
            'apiKey': '123',
            'appId': '123',
            'messagingSenderId': '123',
            'projectId': '123',
          },
          'pluginConstants': const <String, String>{},
        }
      ];
    }

    if (call.method == 'Firebase#initializeApp') {
      final arguments = call.arguments as Map<String, dynamic>;
      return <String, dynamic>{
        'name': arguments['appName'],
        'options': arguments['options'],
        'pluginConstants': const <String, String>{},
      };
    }

    return null;
  });

  TestWidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();

  const UserInfo userInfo = UserInfo(
      email: 'test@email.com',
      firstName: 'testFirstName',
      surname: 'testSurname',
      photoURL: 'testURL');

  group('UserInfoRepository', () {
    late firebase_firestore.FirebaseFirestore fireStore;
    late UserInfoRepository userInfoRepository;

    setUp(() {
      fireStore = MockFirebaseFirestore();
      userInfoRepository = UserInfoRepository(firebaseFirestore: fireStore);
    });

    group('saveUserInfoIntoFirestore', () {
      test('calls firestore collection doc set', () async {
        await userInfoRepository.saveUserInfoToFirebase(userInfo: userInfo);
        verify(
          () => fireStore.collection('users').doc(userInfo.email).set(userInfo.toJson()),
        ).called(1);
      });
    });
  });
}
