import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_platform/constants/colors.dart';
import 'package:study_platform/constants/string_variables.dart';
import 'package:study_platform/data/repositories/chat_repository.dart';
import 'package:study_platform/data/repositories/courses_repository.dart';
import 'package:study_platform/data/repositories/user_info_repository.dart';
import 'package:study_platform/logic/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:study_platform/logic/bloc/chat_bloc/chat_bloc.dart';
import 'package:study_platform/logic/bloc/courses_bloc/courses_bloc.dart';
import 'package:study_platform/logic/cubit/course_cuibt/course_cubit.dart';
import 'package:study_platform/logic/cubit/login_cubit/login_cubit.dart';
import 'package:study_platform/logic/cubit/signup_cubit/sign_cubit.dart';
import 'package:study_platform/logic/cubit/user_info_cubit/user_info_cubit.dart';
import 'package:study_platform/presentation/app_router/app_router.dart';
import 'package:study_platform/utility/app_bloc_observer.dart';

import 'data/repositories/authentication_repository.dart';

final firebaseAuth = FirebaseAuth.instance;
final firebaseFirestore = FirebaseFirestore.instance;
final authenticationRepository = AuthenticationRepository(firebaseAuth: firebaseAuth);
final userInfoRepository = UserInfoRepository(firebaseFirestore: firebaseFirestore);
final coursesRepository = CoursesRepository(firebaseFirestore: firebaseFirestore);
final chatRepository = ChatRepository(firebaseFirestore: firebaseFirestore);

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
            create: (courseCubitContext) => ChatBloc(
              chatRepository: chatRepository,
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
