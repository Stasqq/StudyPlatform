import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:study_platform/data/models/course/course.dart';
import 'package:study_platform/data/repositories/courses_repository.dart';

part 'courses_event.dart';
part 'courses_state.dart';

class CoursesBloc extends Bloc<CoursesEvent, CoursesState> {
  CoursesBloc({required CoursesRepository coursesRepository})
      : _coursesRepository = coursesRepository,
        super(CoursesStateLoading()) {
    on<CoursesEventStart>(_onStartEvent);
    on<CoursesEventLoad>(_onLoadEvent);
    on<CoursesEventFetchMore>(_onFetchMore);
  }

  final CoursesRepository _coursesRepository;
  List<StreamSubscription> subscriptions = [];
  List<List<Course>> courses = [];
  bool hasMoreData = true;
  DocumentSnapshot? lastDoc;

  void _onStartEvent(
    CoursesEventStart event,
    Emitter<CoursesState> emit,
  ) {
    hasMoreData = true;
    lastDoc = null;
    subscriptions.forEach((subscription) {
      subscription.cancel();
    });
    courses.clear();
    subscriptions.clear();
    subscriptions.add(_coursesRepository.getCourses().listen((event) {
      _handleStreamEvent(0, event);
    }));
  }

  void _onLoadEvent(
    CoursesEventLoad event,
    Emitter<CoursesState> emit,
  ) {
    final elements = courses.expand((i) => i).toList();

    if (elements.isEmpty) {
      emit(CoursesStateEmpty());
    } else {
      emit(CoursesStateLoadSuccess(elements, hasMoreData));
    }
  }

  void _onFetchMore(
    CoursesEventFetchMore event,
    Emitter<CoursesState> emit,
  ) {
    if (lastDoc == null) {
      throw Exception('Last doc is not set');
    }
    final index = courses.length;
    subscriptions.add(_coursesRepository.getCoursesPage(lastDoc!).listen((event) {
      _handleStreamEvent(index, event);
    }));
  }

  void _handleStreamEvent(int index, QuerySnapshot snapshot) {
    hasMoreData = snapshot.docs.length < 15 ? false : true;

    if (snapshot.docs.isEmpty) return;

    if (index == courses.length) {
      lastDoc = snapshot.docs[snapshot.docs.length - 1];
    }

    List<Course> newList = [];
    snapshot.docs.forEach((doc) {
      newList.add(Course.fromJson(doc.data() as Map<String, dynamic>));
    });

    if (courses.length <= index) {
      courses.add(newList);
    } else {
      courses[index].clear();
      courses[index] = newList;
    }
    add(CoursesEventLoad(courses));
  }

  @override
  Future<void> close() async {
    subscriptions.forEach((subscription) {
      subscription.cancel();
    });
    super.close();
  }

  @override
  void onChange(Change<CoursesState> change) {
    print(change);
    super.onChange(change);
  }
}
