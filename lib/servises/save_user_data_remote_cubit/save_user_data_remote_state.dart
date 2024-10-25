part of 'save_user_data_remote_cubit.dart';

abstract class SaveUserDataRemoteState {}

class SaveUserDataRemoteInitial extends SaveUserDataRemoteState {}

class SaveUserDataRemoteSuccess extends SaveUserDataRemoteState {}

class SaveUserDataRemoteLoading extends SaveUserDataRemoteState {}

class SaveUserDataRemoteFailure extends SaveUserDataRemoteState {}
