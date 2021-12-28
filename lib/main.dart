import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_platform/constants/colors.dart';
import 'package:study_platform/constants/string_variables.dart';
import 'package:study_platform/data/repositories/courses_repository.dart';
import 'package:study_platform/data/repositories/user_info_repository.dart';
import 'package:study_platform/logic/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:study_platform/logic/cubit/course_cuibt/course_cubit.dart';
import 'package:study_platform/logic/cubit/login_cubit/login_cubit.dart';
import 'package:study_platform/logic/cubit/signup_cubit/sign_cubit.dart';
import 'package:study_platform/logic/cubit/user_info_cubit/user_info_cubit.dart';
import 'package:study_platform/presentation/app_router/app_router.dart';
import 'package:study_platform/utility/app_bloc_observer.dart';

import 'data/repositories/authentication_repository.dart';

late final AuthenticationRepository _authenticationRepository;
late final UserInfoRepository _userInfoRepository;
late final CoursesRepository _coursesRepository;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: kIsWeb
        ? const FirebaseOptions(
            apiKey: "AIzaSyBL3RW0nwZqZOKulUmPRvCY3Rc9YNycvqg", // Your apiKey
            appId: "1:39464472146:web:3f1c2deacd5a6d1da0598b", // Your appId
            messagingSenderId: "39464472146", // Your messagingSenderId
            projectId: "study-platform-7be51", // Your projectId
          )
        : null,
  );
  BlocOverrides.runZoned(
    () => {runApp(const StudyPlatform())},
    blocObserver: AppBlocObserver(),
  );
}

class StudyPlatform extends StatelessWidget {
  const StudyPlatform({Key? key}) : super(key: key);

  // ! This widget is the root of application.
  @override
  Widget build(BuildContext context) {
    final firebaseFirestore = FirebaseFirestore.instance;

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) =>
              AuthenticationRepository(firebaseAuth: FirebaseAuth.instance),
        ),
        RepositoryProvider(
          create: (context) =>
              UserInfoRepository(firebaseFirestore: firebaseFirestore),
        ),
        RepositoryProvider(
          create: (context) =>
              UserInfoRepository(firebaseFirestore: firebaseFirestore),
        ),
        RepositoryProvider(
          create: (context) =>
              CoursesRepository(firebaseFirestore: firebaseFirestore),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(
            create: (authenticationBlocContext) => AuthenticationBloc(
              authenticationRepository: _authenticationRepository,
            ),
          ),
          BlocProvider<LoginCubit>(
            create: (loginCubitContext) => LoginCubit(
              authenticationRepository: _authenticationRepository,
            ),
          ),
          BlocProvider<SignUpCubit>(
            create: (signUpCubitContext) => SignUpCubit(
              authenticationRepository: _authenticationRepository,
            ),
          ),
          BlocProvider<UserInfoCubit>(
            create: (userInfoCubitContext) => UserInfoCubit(
              authenticationRepository: _authenticationRepository,
              userInfoRepository: _userInfoRepository,
            ),
          ),
          BlocProvider<CourseCubit>(
            create: (userInfoCubitContext) => CourseCubit(
              authenticationRepository: _authenticationRepository,
              coursesRepository: _coursesRepository,
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
