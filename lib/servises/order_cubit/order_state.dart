part of 'order_cubit.dart';

abstract class OrderState {}

class OrderInitial extends OrderState {}

class OrderGetSucces extends OrderState {}

class OrderGetLoading extends OrderState {}

class OrderGetError extends OrderState {
  final String errorMessage;

  OrderGetError(this.errorMessage);
}

class CartDeleteSuccess extends OrderState {}

class CartDeleteLoading extends OrderState {}

class CartDeleteFailure extends OrderState {}

class OrderDeleteSuccess extends OrderState {}

class OrderDeleteLoading extends OrderState {}

class OrderDeleteFailure extends OrderState {}
