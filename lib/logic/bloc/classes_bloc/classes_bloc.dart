import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:study_platform/data/models/course/class.dart';
import 'package:study_platform/data/repositories/classes_repository.dart';
import 'package:study_platform/data/repositories/files_repository.dart';

part 'classes_event.dart';
part 'classes_state.dart';

class ClassesBloc extends Bloc<ClassesEvent, ClassesState> {
  ClassesBloc({
    required ClassesRepository classesRepository,
    required FilesRepository filesRepository,
  })  : _classesRepository = classesRepository,
        _filesRepository = filesRepository,
        super(ClassesStateLoading()) {
    on<ClassesEventStart>(_onStartEvent);
    on<ClassesEventLoad>(_onLoadEvent);
    on<ClassesEventFetchMore>(_onFetchMore);
    on<CurrentClassEvent>(_onCurrentClass);
    on<CurrentClassMaterialAddEvent>(_onCurrentClassMaterialAdd);
    on<CurrentClassMaterialDeleteEvent>(_onCurrentClassMaterialDelete);
    on<CurrentClassDeleteEvent>(_onCurrentClassDelete);
    on<ClassCreateEvent>(_onClassCreate);
  }

  final FilesRepository _filesRepository;
  final ClassesRepository _classesRepository;
  List<StreamSubscription> subscriptions = [];
  List<List<Class>> classes = [];
  bool hasMoreData = true;
  DocumentSnapshot? lastDoc;

  void _onStartEvent(
    ClassesEventStart event,
    Emitter<ClassesState> emit,
  ) {
    hasMoreData = true;
    lastDoc = null;
    subscriptions.forEach((subscription) {
      subscription.cancel();
    });
    classes.clear();
    subscriptions.clear();

    subscriptions.add(
      _classesRepository
          .getClasses(
        courseId: event.courseId,
      )
          .listen(
        (snapshot) {
          _handleStreamEvent(0, snapshot);
        },
      ),
    );
    emit(ClassesStateEmpty(courseId: event.courseId));
  }

  void _onLoadEvent(
    ClassesEventLoad event,
    Emitter<ClassesState> emit,
  ) {
    final elements = classes.expand((i) => i).toList();

    if (elements.isEmpty) {
      emit(ClassesStateEmpty(courseId: state.courseId));
    } else {
      emit(ClassesStateLoadSuccess(
          classes: elements,
          hasMoreData: hasMoreData,
          courseId: state.courseId));
    }
  }

  void _onFetchMore(
    ClassesEventFetchMore event,
    Emitter<ClassesState> emit,
  ) {
    if (lastDoc == null) {
      throw Exception('Last doc is not set');
    }
    final index = classes.length;
    subscriptions.add(_classesRepository
        .getClassesPage(lastDoc: lastDoc!, courseId: state.courseId)
        .listen((event) {
      _handleStreamEvent(index, event);
    }));
  }

  void _onCurrentClass(
    CurrentClassEvent event,
    Emitter<ClassesState> emit,
  ) {
    emit((state as ClassesStateLoadSuccess).copyWith(
      currentClass: event.currentClass,
    ));
  }

  Future<void> _onCurrentClassMaterialAdd(
    CurrentClassMaterialAddEvent event,
    Emitter<ClassesState> emit,
  ) async {
    var loadState = (state as ClassesStateLoadSuccess);
    emit(ClassesStateActionLoading(currentState: loadState));
    String fileName = await _filesRepository.pickAndSentFile(
        pathToSent: 'courses/' +
            loadState.courseId +
            '/' +
            loadState.currentClass.name +
            '/materials/');
    await _classesRepository.addClassMaterials(
      fileName: fileName,
      courseId: loadState.courseId,
      className: loadState.currentClass.name,
    );
    loadState.currentClass.materials.add(fileName);
    emit(loadState.copyWith(
        currentClass: loadState.currentClass
            .copyWith(materials: loadState.currentClass.materials)));
  }

  Future<void> _onCurrentClassMaterialDelete(
    CurrentClassMaterialDeleteEvent event,
    Emitter<ClassesState> emit,
  ) async {
    var loadState = (state as ClassesStateLoadSuccess);
    emit(ClassesStateActionLoading(currentState: loadState));
    await _filesRepository.deleteFile(
        filePath: 'courses/' +
            loadState.courseId +
            '/' +
            loadState.currentClass.name +
            '/materials/' +
            event.fileName);
    await _classesRepository.deleteClassMaterials(
        courseId: loadState.courseId,
        className: loadState.currentClass.name,
        fileName: event.fileName);
    List<String> newMaterialsList = loadState.currentClass.materials;
    newMaterialsList.remove(event.fileName);
    emit(loadState.copyWith(
        currentClass:
            loadState.currentClass.copyWith(materials: newMaterialsList)));
  }

  Future<void> _onClassCreate(
    ClassCreateEvent event,
    Emitter<ClassesState> emit,
  ) async {
    await _classesRepository.sentNewClass(
      courseId: state.courseId,
      newClass: Class(
          event.name,
          event.index,
          event.description,
          'courses/' +
              state.courseId +
              '/' +
              event.name +
              '/' +
              event.name +
              '.html',
          <String>[]),
    );

    await _filesRepository.createNewClassFiles(
      courseId: state.courseId,
      className: event.name,
    );
  }

  Future<void> _onCurrentClassDelete(
    CurrentClassDeleteEvent event,
    Emitter<ClassesState> emit,
  ) async {
    var loadState = (state as ClassesStateLoadSuccess);
    emit(ClassesStateActionLoading(currentState: loadState));
    await _classesRepository.deleteClass(
        courseId: loadState.courseId, className: loadState.currentClass.name);
    await _filesRepository.deleteClassDirectory(
        directoryPath: 'courses/' +
            loadState.courseId +
            '/' +
            loadState.currentClass.name +
            '/',
        className: loadState.currentClass.name);
    List<Class> newClassesList = loadState.classes;
    newClassesList.remove(loadState.currentClass);
    emit(loadState.copyWith(classes: newClassesList));
  }

  void _handleStreamEvent(int index, QuerySnapshot snapshot) {
    hasMoreData = snapshot.docs.length < 15 ? false : true;

    if (snapshot.docs.isEmpty) return;

    if (index == classes.length) {
      lastDoc = snapshot.docs[snapshot.docs.length - 1];
    }

    List<Class> newList = [];
    snapshot.docs.forEach((doc) {
      newList.add(Class.fromJson(doc.data() as Map<String, dynamic>));
    });

    if (classes.length <= index) {
      classes.add(newList);
    } else {
      classes[index].clear();
      classes[index] = newList;
    }
    add(ClassesEventLoad(classes));
  }

  @override
  Future<void> close() async {
    subscriptions.forEach((subscription) {
      subscription.cancel();
    });
    super.close();
  }

  @override
  void onChange(Change<ClassesState> change) {
    print(change);
    super.onChange(change);
  }
}
