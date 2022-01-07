part of 'class_content_cubit.dart';

class ClassContentState extends Equatable {
  @override
  List<Object?> get props => [throw UnimplementedError()];
}

class ClassContentDataLoadingState extends ClassContentState {}

class ClassContentDataLoadingSuccessState extends ClassContentState {
  final String? htmlText;
  final String? htmlFilePath;
  final ClassesBloc? classesBloc;

  ClassContentDataLoadingSuccessState(
      {required this.htmlText,
      required this.htmlFilePath,
      required this.classesBloc});

  @override
  List<Object?> get props => [htmlText, htmlFilePath, classesBloc];
}

class ClassContentDataSavingState extends ClassContentDataLoadingSuccessState {
  ClassContentDataSavingState(
      {required String htmlText,
      required String htmlFilePath,
      required ClassesBloc classesBloc})
      : super(
          htmlText: htmlText,
          htmlFilePath: htmlFilePath,
          classesBloc: classesBloc,
        );
}

class ClassContentDataSavingSuccessState extends ClassContentState {}
