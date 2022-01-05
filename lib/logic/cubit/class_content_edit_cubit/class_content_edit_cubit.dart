import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:study_platform/data/repositories/files_repository.dart';
import 'package:study_platform/logic/bloc/classes_bloc/classes_bloc.dart';

part 'class_content_edit_state.dart';

class ClassContentEditCubit extends Cubit<ClassContentEditState> {
  ClassContentEditCubit({required FilesRepository filesRepository})
      : _filesRepository = filesRepository,
        super(ClassContentEditState());

  final FilesRepository _filesRepository;

  Future<void> loadClass(ClassesBloc classesBloc) async {
    emit(ClassContentDataLoadingState());
    String htmlFilePath = (classesBloc.state as ClassesStateLoadSuccess)
        .currentClass
        .htmlBodyPath;
    File htmlFile = await _filesRepository.getFile(
      path: htmlFilePath,
      fileName:
          (classesBloc.state as ClassesStateLoadSuccess).currentClass.name +
              '.html',
    );
    String htmlText = htmlFile.readAsStringSync();
    emit(ClassContentDataLoadingSuccessState(
        htmlFilePath: htmlFilePath,
        htmlText: htmlText,
        classesBloc: classesBloc));
  }

  Future<void> saveContent({required String htmlText}) async {
    var loadedState = state as ClassContentDataLoadingSuccessState;
    emit(
      ClassContentDataSavingState(
          htmlFilePath: loadedState.htmlFilePath!,
          htmlText: loadedState.htmlText!,
          classesBloc: loadedState.classesBloc!),
    );
    var savingState = state as ClassContentDataSavingState;
    await _filesRepository.deleteFile(filePath: savingState.htmlFilePath!);
    Directory appDocDir = await getApplicationDocumentsDirectory();
    File file =
        await File(appDocDir.absolute.path + '/class_content.html').create();
    await file.writeAsString(htmlText);
    await _filesRepository.saveFile(
        path: (savingState.classesBloc?.state as ClassesStateLoadSuccess)
            .currentClass
            .htmlBodyPath,
        file: file);
    file.delete();
    emit(ClassContentDataSavingSuccessState());
  }
}
