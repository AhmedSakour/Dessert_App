part of 'upload_user_photo_cubit.dart';

abstract class UploadPhotoState {}

class GetPhotoLoading extends UploadPhotoState {}

class GetPhotoSuccess extends UploadPhotoState {}

class GetPhotoFailure extends UploadPhotoState {}

class UploadPhotoInitial extends UploadPhotoState {}

class UploadPhotoLoading extends UploadPhotoState {}

class UploadPhotoSuccess extends UploadPhotoState {}

class UploadPhotoFailure extends UploadPhotoState {}
