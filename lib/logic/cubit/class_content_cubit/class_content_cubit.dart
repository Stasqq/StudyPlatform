import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:study_platform/data/repositories/files_repository.dart';
import 'package:study_platform/logic/bloc/classes_bloc/classes_bloc.dart';

part 'class_content_state.dart';

class ClassContentCubit extends Cubit<ClassContentState> {
  ClassContentCubit({required FilesRepository filesRepository})
      : _filesRepository = filesRepository,
        super(ClassContentState());

  final FilesRepository _filesRepository;

  Future<void> loadClass(ClassesBloc classesBloc) async {
    emit(
      ClassContentDataLoadingState(),
    );

    String htmlFilePath = (classesBloc.state as ClassesStateLoadSuccess)
        .currentClass
        .htmlBodyPath;

    String htmlText = await _filesRepository.getFileDataAsString(
      path: htmlFilePath,
      fileName:
          '${(classesBloc.state as ClassesStateLoadSuccess).currentClass.name}.html',
    );

    emit(
      ClassContentDataLoadingSuccessState(
        htmlFilePath: htmlFilePath,
        htmlText: htmlText,
        classesBloc: classesBloc,
      ),
    );
  }

  Future<void> saveContent({required String htmlText}) async {
    var loadedState = state as ClassContentDataLoadingSuccessState;

    emit(
      ClassContentDataSavingState(
        htmlFilePath: loadedState.htmlFilePath!,
        htmlText: loadedState.htmlText,
        classesBloc: loadedState.classesBloc!,
      ),
    );

    var savingState = state as ClassContentDataSavingState;

    await _filesRepository.deleteFile(
      filePath: savingState.htmlFilePath!,
    );

    await _filesRepository.saveTextFile(
      path: (savingState.classesBloc?.state as ClassesStateLoadSuccess)
          .currentClass
          .htmlBodyPath,
      text: htmlText,
    );

    emit(
      ClassContentDataSavingSuccessState(),
    );
  }
}
