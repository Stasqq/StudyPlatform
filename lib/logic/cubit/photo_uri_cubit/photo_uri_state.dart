part of 'photo_uri_cubit.dart';

class PhotoUriState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PhotoUriNotGenerated extends PhotoUriState {}

class PhotoUriGenerated extends PhotoUriState {
  final String uri;

  PhotoUriGenerated({required this.uri});
}

class PhotoNewGenerated extends PhotoUriState {}
