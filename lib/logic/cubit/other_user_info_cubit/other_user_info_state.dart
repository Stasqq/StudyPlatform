part of 'other_user_info_cubit.dart';

class OtherUserInfoState extends Equatable {
  @override
  List<Object?> get props => [];
}

class OtherUserInfoLoadingState extends OtherUserInfoState {}

class OtherUserInfoLoadingSuccessState extends OtherUserInfoState {
  final UserInfo otherUserInfo;

  OtherUserInfoLoadingSuccessState({
    required this.otherUserInfo,
  });
}
