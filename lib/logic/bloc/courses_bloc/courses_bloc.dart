import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:study_platform/data/models/course/course.dart';
import 'package:study_platform/data/repositories/courses_repository.dart';

part 'courses_event.dart';
part 'courses_state.dart';

enum CoursesFilter { Public, Owner, Joined }

class CoursesBloc extends Bloc<CoursesEvent, CoursesState> {
  CoursesBloc({required CoursesRepository coursesRepository})
      : _coursesRepository = coursesRepository,
        super(CoursesStateLoading()) {
    on<CoursesEventStart>(_onStartEvent);
    on<CoursesEventLoad>(_onLoadEvent);
    on<CoursesEventFetchMore>(_onFetchMore);
    on<CurrentCourseEvent>(_onCurrentCourse);
    on<CourseJoinEvent>(_onCourseJoin);
    on<CurrentCourseJoinEvent>(_onCurrentCourseJoin);
    on<CurrentCourseLeaveEvent>(_onCurrentCourseLeave);
    on<CurrentCourseDeleteEvent>(_onCurrentCourseDelete);
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

    if (event.joinedCourses.isEmpty && event.coursesFilter == CoursesFilter.Joined) {
      emit(CoursesStateEmpty());
      return;
    } else if (event.ownerUid == null && event.coursesFilter == CoursesFilter.Owner) {
      emit(CoursesStateEmpty());
      return;
    }

    subscriptions.add(
      _coursesRepository
          .getCourses(
              coursesFilter: event.coursesFilter,
              ownerUid: event.ownerUid,
              joinedCourses: event.joinedCourses)
          .listen(
        (snapshot) {
          _handleStreamEvent(0, snapshot);
        },
      ),
    );
    emit(CoursesStateEmpty());
  }

  void _onLoadEvent(
    CoursesEventLoad event,
    Emitter<CoursesState> emit,
  ) {
    final elements = courses.expand((i) => i).toList();

    if (elements.isEmpty) {
      emit(CoursesStateEmpty());
    } else {
      emit(CoursesStateLoadSuccess(courses: elements, hasMoreData: hasMoreData));
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

  Future<void> _onCurrentCourse(
    CurrentCourseEvent event,
    Emitter<CoursesState> emit,
  ) async {
    emit((state as CoursesStateLoadSuccess).copyWith(
      currentCourse: event.currentCourse,
      owner: event.owner,
      joined: event.joined,
    ));
  }

  Future<void> _onCourseJoin(
    CourseJoinEvent event,
    Emitter<CoursesState> emit,
  ) async {
    List<String> newCoursesIdsList = [];
    newCoursesIdsList.addAll(event.currentCoursesIds);
    newCoursesIdsList.add(event.courseId);
    await _coursesRepository.updateJoinedCourses(
        userEmail: event.userEmail, coursesIds: newCoursesIdsList);
    emit((state as CoursesStateLoadSuccess).copyWith(owner: false, joined: true));
  }

  Future<void> _onCurrentCourseJoin(
    CurrentCourseJoinEvent event,
    Emitter<CoursesState> emit,
  ) async {
    List<String> newCoursesIdsList = [];
    newCoursesIdsList.addAll(event.currentCoursesIds);
    newCoursesIdsList.add((state as CoursesStateLoadSuccess).currentCourse.id);
    await _coursesRepository.updateJoinedCourses(
        userEmail: event.userEmail, coursesIds: newCoursesIdsList);
    emit((state as CoursesStateLoadSuccess).copyWith(joined: true));
  }

  Future<void> _onCurrentCourseLeave(
    CurrentCourseLeaveEvent event,
    Emitter<CoursesState> emit,
  ) async {
    List<String> newCoursesIdsList = [];
    newCoursesIdsList.addAll(event.currentCoursesIds);
    newCoursesIdsList.remove((state as CoursesStateLoadSuccess).currentCourse.id);
    await _coursesRepository.updateJoinedCourses(
        userEmail: event.userEmail, coursesIds: newCoursesIdsList);
    emit((state as CoursesStateLoadSuccess).copyWith(joined: false));
  }

  Future<void> _onCurrentCourseDelete(
    CurrentCourseDeleteEvent event,
    Emitter<CoursesState> emit,
  ) async {
    await _coursesRepository.deleteCourse(
        courseId: (state as CoursesStateLoadSuccess).currentCourse.id);
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
