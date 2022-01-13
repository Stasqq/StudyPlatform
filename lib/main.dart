import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_platform/constants/colors.dart';
import 'package:study_platform/constants/string_variables.dart';
import 'package:study_platform/constants/variables.dart';
import 'package:study_platform/data/repositories/chat_repository.dart';
import 'package:study_platform/data/repositories/classes_repository.dart';
import 'package:study_platform/data/repositories/courses_repository.dart';
import 'package:study_platform/data/repositories/files_repository.dart';
import 'package:study_platform/data/repositories/test_repository.dart';
import 'package:study_platform/data/repositories/user_info_repository.dart';
import 'package:study_platform/logic/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:study_platform/logic/bloc/chat_bloc/chat_bloc.dart';
import 'package:study_platform/logic/bloc/courses_bloc/courses_bloc.dart';
import 'package:study_platform/logic/cubit/answer_cubit/answer_cubit.dart';
import 'package:study_platform/logic/cubit/course_cubit/course_cubit.dart';
import 'package:study_platform/logic/cubit/create_question_cubit/create_question_cubit.dart';
import 'package:study_platform/logic/cubit/create_test_cubit/create_test_cubit.dart';
import 'package:study_platform/logic/cubit/login_cubit/login_cubit.dart';
import 'package:study_platform/logic/cubit/other_user_info_cubit/other_user_info_cubit.dart';
import 'package:study_platform/logic/cubit/photo_uri_cubit/photo_uri_cubit.dart';
import 'package:study_platform/logic/cubit/rate_course_cubit/rate_course_cubit.dart';
import 'package:study_platform/logic/cubit/signup_cubit/sign_cubit.dart';
import 'package:study_platform/logic/cubit/take_test_cubit/take_test_cubit.dart';
import 'package:study_platform/logic/cubit/test_results_cubit/test_result_cubit.dart';
import 'package:study_platform/logic/cubit/tests_cubit/tests_cubit.dart';
import 'package:study_platform/logic/cubit/user_info_cubit/user_info_cubit.dart';
import 'package:study_platform/presentation/app_router/app_router.dart';
import 'package:study_platform/utility/app_bloc_observer.dart';

import 'data/repositories/authentication_repository.dart';
import 'logic/bloc/classes_bloc/classes_bloc.dart';
import 'logic/cubit/class_content_cubit/class_content_cubit.dart';

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
final testRepository = TestRepository(firebaseFirestore: firebaseFirestore);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: kIsWeb ? kWebFirebaseOptions : null,
  );

  await authenticationRepository.user.first;

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
        RepositoryProvider(
          create: (context) => testRepository,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(
            create: (context) => AuthenticationBloc(
              authenticationRepository: authenticationRepository,
            ),
          ),
          BlocProvider<CoursesBloc>(
            create: (context) => CoursesBloc(
              coursesRepository: coursesRepository,
            ),
          ),
          BlocProvider<LoginCubit>(
            create: (context) => LoginCubit(
              authenticationRepository: authenticationRepository,
            ),
          ),
          BlocProvider<SignUpCubit>(
            create: (context) => SignUpCubit(
              authenticationRepository: authenticationRepository,
            ),
          ),
          BlocProvider<UserInfoCubit>(
            create: (context) => UserInfoCubit(
              authenticationRepository: authenticationRepository,
              userInfoRepository: userInfoRepository,
            ),
          ),
          BlocProvider<CourseCubit>(
            create: (context) => CourseCubit(
              authenticationRepository: authenticationRepository,
              coursesRepository: coursesRepository,
            ),
          ),
          BlocProvider<ChatBloc>(
            create: (context) => ChatBloc(
              chatRepository: chatRepository,
            ),
          ),
          BlocProvider<ClassesBloc>(
            create: (context) => ClassesBloc(
              classesRepository: classesRepository,
              filesRepository: filesRepository,
            ),
          ),
          BlocProvider<ClassContentCubit>(
            create: (context) => ClassContentCubit(
              filesRepository: filesRepository,
            ),
          ),
          BlocProvider<OtherUserInfoCubit>(
            create: (context) => OtherUserInfoCubit(
              userInfoRepository: userInfoRepository,
            ),
          ),
          BlocProvider<PhotoUriCubit>(
            create: (context) => PhotoUriCubit(
              userInfoRepository: userInfoRepository,
              filesRepository: filesRepository,
            ),
          ),
          BlocProvider<CreateTestCubit>(
            create: (context) => CreateTestCubit(
              testRepository: testRepository,
            ),
          ),
          BlocProvider<CreateQuestionCubit>(
            create: (context) => CreateQuestionCubit(),
          ),
          BlocProvider<AnswerCubit>(
            create: (context) => AnswerCubit(),
          ),
          BlocProvider<TestsCubit>(
            create: (context) => TestsCubit(
              testRepository: testRepository,
            ),
          ),
          BlocProvider<TakeTestCubit>(
            create: (context) => TakeTestCubit(
              testRepository: testRepository,
            ),
          ),
          BlocProvider<TestResultCubit>(
            create: (context) => TestResultCubit(
              testRepository: testRepository,
            ),
          ),
          BlocProvider<RateCourseCubit>(
            create: (context) => RateCourseCubit(
              coursesBloc: context.read<CoursesBloc>(),
              userInfoCubit: context.read<UserInfoCubit>(),
            ),
          ),
        ],
        child: const _App(),
      ),
    );
  }
}

class _App extends StatelessWidget {
  const _App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: kAppTitle,
      theme: ThemeData(
        primaryColor: darkPrimaryColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
