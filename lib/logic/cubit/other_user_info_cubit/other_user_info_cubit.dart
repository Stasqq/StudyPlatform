import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:study_platform/data/models/user/user_info.dart';
import 'package:study_platform/data/repositories/user_info_repository.dart';

part 'other_user_info_state.dart';

class OtherUserInfoCubit extends Cubit<OtherUserInfoState> {
  OtherUserInfoCubit({required UserInfoRepository userInfoRepository})
      : _userInfoRepository = userInfoRepository,
        super(OtherUserInfoState());

  final UserInfoRepository _userInfoRepository;

  Future<void> loadOtherUserInfo(String otherUserEmail) async {
    emit(
      OtherUserInfoLoadingState(),
    );

    UserInfo otherUserInfo = await _userInfoRepository.readUserInfo(
      email: otherUserEmail,
    );

    emit(
      OtherUserInfoLoadingSuccessState(
        otherUserInfo: otherUserInfo,
      ),
    );
  }
}
