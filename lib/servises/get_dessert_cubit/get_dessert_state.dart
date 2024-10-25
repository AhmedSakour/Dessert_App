part of 'get_dessert_cubit.dart';

abstract class GetDessertState {}

class GetDessertInitial extends GetDessertState {}

class GetDessertLoading extends GetDessertState {}

class GetDessertSuccess extends GetDessertState {}

class GetDessertFailure extends GetDessertState {
  final String errorMessage;

  GetDessertFailure({required this.errorMessage});
}
