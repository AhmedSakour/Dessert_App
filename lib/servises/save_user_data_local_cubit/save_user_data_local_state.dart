part of 'save_user_data_local_cubit.dart';

abstract class SaveUserDataToSharedPreferenceState {}

class SaveUserDataLocalInitial extends SaveUserDataToSharedPreferenceState {}

class SaveUserDataLocalLoading extends SaveUserDataToSharedPreferenceState {}

class SaveUserDataLocalFailure extends SaveUserDataToSharedPreferenceState {}

class SaveUserDataLocalSuccess extends SaveUserDataToSharedPreferenceState {}
