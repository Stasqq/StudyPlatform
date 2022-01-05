part of 'class_content_edit_cubit.dart';

class ClassContentEditState extends Equatable {
  @override
  List<Object?> get props => [throw UnimplementedError()];
}

class ClassContentDataLoadingState extends ClassContentEditState {}

class ClassContentDataLoadingSuccessState extends ClassContentEditState {
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

class ClassContentDataSavingSuccessState extends ClassContentEditState {}
