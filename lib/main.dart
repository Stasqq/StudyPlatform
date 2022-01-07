import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_platform/constants/colors.dart';
import 'package:study_platform/constants/string_variables.dart';
import 'package:study_platform/data/repositories/chat_repository.dart';
import 'package:study_platform/data/repositories/classes_repository.dart';
import 'package:study_platform/data/repositories/courses_repository.dart';
import 'package:study_platform/data/repositories/files_repository.dart';
import 'package:study_platform/data/repositories/user_info_repository.dart';
import 'package:study_platform/logic/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:study_platform/logic/bloc/chat_bloc/chat_bloc.dart';
import 'package:study_platform/logic/bloc/courses_bloc/courses_bloc.dart';
import 'package:study_platform/logic/cubit/course_cuibt/course_cubit.dart';
import 'package:study_platform/logic/cubit/login_cubit/login_cubit.dart';
import 'package:study_platform/logic/cubit/other_user_info_cubit/other_user_info_cubit.dart';
import 'package:study_platform/logic/cubit/photo_uri_cubit/photo_uri_cubit.dart';
import 'package:study_platform/logic/cubit/signup_cubit/sign_cubit.dart';
import 'package:study_platform/logic/cubit/user_info_cubit/user_info_cubit.dart';
import 'package:study_platform/presentation/app_router/app_router.dart';
import 'package:study_platform/utility/app_bloc_observer.dart';

import 'data/repositories/authentication_repository.dart';
import 'logic/bloc/classes_bloc/classes_bloc.dart';
import 'logic/cubit/class_content_edit_cubit/class_content_cubit.dart';

final firebaseAuth = FirebaseAuth.instance;
final firebaseFirestore = FirebaseFirestore.instance;
final firebaseStorage = FirebaseStorage.instance;
final authenticationRepository =
    AuthenticationRepository(firebaseAuth: firebaseAuth);
final userInfoRepository =
    UserInfoRepository(firebaseFirestore: firebaseFirestore);
final coursesRepository =
    CoursesRepository(firebaseFirestore: firebaseFirestore);
final chatRepository = ChatRepository(firebaseFirestore: firebaseFirestore);
final classesRepository =
    ClassesRepository(firebaseFirestore: firebaseFirestore);
final filesRepository = FilesRepository(firebaseStorage: firebaseStorage);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: kIsWeb
        ? const FirebaseOptions(
            apiKey: "AIzaSyB0fZ_iUIr7qzyI9Ygek3TntbIX9Upf2YQ",
            authDomain: "study-platform-7be51.firebaseapp.com",
            projectId: "study-platform-7be51",
            storageBucket: "study-platform-7be51.appspot.com",
            messagingSenderId: "39464472146",
            appId: "1:39464472146:web:3f1c2deacd5a6d1da0598b",
            measurementId: "G-YT1FRMQYZ0",
          )
        : null,
  );

  await authenticationRepository.user.first;

  BlocOverrides.runZoned(
    () => {runApp(const StudyPlatform())},
    blocObserver: AppBlocObserver(),
  );
}

void setUp() {}

class StudyPlatform extends StatelessWidget {
  const StudyPlatform({Key? key}) : super(key: key);

  // ! This widget is the root of application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => authenticationRepository,
        ),
        RepositoryProvider(
          create: (context) => userInfoRepository,
        ),
        RepositoryProvider(
          create: (context) => coursesRepository,
        ),
        RepositoryProvider(
          create: (context) => chatRepository,
        ),
        RepositoryProvider(
          create: (context) => classesRepository,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(
            create: (authenticationBlocContext) => AuthenticationBloc(
              authenticationRepository: authenticationRepository,
            ),
          ),
          BlocProvider<CoursesBloc>(
            create: (coursesContext) => CoursesBloc(
              coursesRepository: coursesRepository,
            ),
          ),
          BlocProvider<LoginCubit>(
            create: (loginCubitContext) => LoginCubit(
              authenticationRepository: authenticationRepository,
            ),
          ),
          BlocProvider<SignUpCubit>(
            create: (signUpCubitContext) => SignUpCubit(
              authenticationRepository: authenticationRepository,
            ),
          ),
          BlocProvider<UserInfoCubit>(
            create: (userInfoCubitContext) => UserInfoCubit(
              authenticationRepository: authenticationRepository,
              userInfoRepository: userInfoRepository,
            ),
          ),
          BlocProvider<CourseCubit>(
            create: (courseCubitContext) => CourseCubit(
              authenticationRepository: authenticationRepository,
              coursesRepository: coursesRepository,
            ),
          ),
          BlocProvider<ChatBloc>(
            create: (chatBlocContext) => ChatBloc(
              chatRepository: chatRepository,
            ),
          ),
          BlocProvider<ClassesBloc>(
            create: (classesBlocContext) => ClassesBloc(
              classesRepository: classesRepository,
              filesRepository: filesRepository,
            ),
          ),
          BlocProvider<ClassContentCubit>(
            create: (classContentEditCubitContext) => ClassContentCubit(
              filesRepository: filesRepository,
            ),
          ),
          BlocProvider<OtherUserInfoCubit>(
            create: (otherUserInfoCubitContext) => OtherUserInfoCubit(
              userInfoRepository: userInfoRepository,
            ),
          ),
          BlocProvider<PhotoUriCubit>(
            create: (photoUriCubitContext) => PhotoUriCubit(
              userInfoRepository: userInfoRepository,
              filesRepository: filesRepository,
            ),
          ),
        ],
        child: const _App(),
      ),
    );
  }
}

class _App extends StatelessWidget {
  const _App({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: kAppTitle,
      theme: ThemeData(
        primaryColor: primaryColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
