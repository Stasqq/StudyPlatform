import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:study_platform/data/models/user/user_info.dart';
import 'package:study_platform/data/repositories/files_repository.dart';
import 'package:study_platform/data/repositories/user_info_repository.dart';

part 'photo_uri_state.dart';

class PhotoUriCubit extends Cubit<PhotoUriState> {
  PhotoUriCubit(
      {required UserInfoRepository userInfoRepository,
      required FilesRepository filesRepository})
      : _userInfoRepository = userInfoRepository,
        _filesRepository = filesRepository,
        super(PhotoUriNotGenerated());

  final FilesRepository _filesRepository;
  final UserInfoRepository _userInfoRepository;

  Future<void> generateUri(String photoURL) async {
    emit(PhotoUriNotGenerated());
    String uri = await _filesRepository.getDownloadUriFromPath(
      filePath: photoURL,
    );
    emit(PhotoUriGenerated(uri: uri));
  }

  Future<void> uploadPhoto(UserInfo userInfo) async {
    try {
      if (userInfo.photoURL != '')
        await _filesRepository.deleteFile(
            filePath: 'users/' + userInfo.uid! + '/photo.png');

      String photoURL =
          await _filesRepository.pickAndSentUserPhoto(userId: userInfo.uid!);
      String uri = await _filesRepository.getDownloadUriFromPath(
        filePath: photoURL,
      );
      _userInfoRepository.saveUserInfoToFirebase(
          userInfo: userInfo.copyWith(photoURL: photoURL));
      emit(PhotoNewGenerated());
      emit(PhotoUriGenerated(uri: uri));
    } on NoFilePickedException catch (e) {}
  }
}
