part of 'rate_course_cubit.dart';

class RateCourseState extends Equatable {
  final int currentRate;

  RateCourseState({
    required this.currentRate,
  });

  RateCourseState copyWith({
    int? currentRate,
  }) {
    return RateCourseState(currentRate: currentRate ?? this.currentRate);
  }

  @override
  List<Object?> get props => [currentRate];
}
