part of 'class_content_cubit.dart';

class ClassContentState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ClassContentDataLoadingState extends ClassContentState {}

class ClassContentDataLoadingSuccessState extends ClassContentState {
  final String htmlText;
  final String? htmlFilePath;
  final ClassesBloc? classesBloc;

  ClassContentDataLoadingSuccessState({
    required this.htmlText,
    required this.htmlFilePath,
    required this.classesBloc,
  });

  bool get isTextValid => htmlText.length <= 10000000;

  @override
  List<Object?> get props => [htmlText, htmlFilePath, classesBloc];
}

class ClassContentDataSavingState extends ClassContentDataLoadingSuccessState {
  ClassContentDataSavingState({
    required String htmlText,
    required String htmlFilePath,
    required ClassesBloc classesBloc,
  }) : super(
          htmlText: htmlText,
          htmlFilePath: htmlFilePath,
          classesBloc: classesBloc,
        );
}

class ClassContentDataSavingSuccessState extends ClassContentState {}
