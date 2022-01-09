import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:study_platform/logic/bloc/courses_bloc/courses_bloc.dart';
import 'package:study_platform/logic/cubit/user_info_cubit/user_info_cubit.dart';

part 'rate_course_state.dart';

class RateCourseCubit extends Cubit<RateCourseState> {
  RateCourseCubit({
    required UserInfoCubit userInfoCubit,
    required CoursesBloc coursesBloc,
  })  : _coursesBloc = coursesBloc,
        _userInfoCubit = userInfoCubit,
        super(
          RateCourseState(
            currentRate: 1,
          ),
        );

  final CoursesBloc _coursesBloc;
  final UserInfoCubit _userInfoCubit;

  void currentRateChanged(int rate) {
    emit(
      state.copyWith(
        currentRate: rate,
      ),
    );
  }

  void submitRating({required String courseId}) {
    _userInfoCubit.updateCourseRate(courseId, state.currentRate);
    _coursesBloc.add(CurrentCourseRateUpdateEvent(rate: state.currentRate));
  }
}
