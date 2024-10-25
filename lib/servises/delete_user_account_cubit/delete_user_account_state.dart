part of 'delete_user_account_cubit.dart';

abstract class DeleteUserAccountState {}

class DeleteUserAccountInitial extends DeleteUserAccountState {}

class DeleteUserAccountLoading extends DeleteUserAccountState {}

class DeleteUserAccountSuccess extends DeleteUserAccountState {}

class DeleteUserAccountFailure extends DeleteUserAccountState {}
