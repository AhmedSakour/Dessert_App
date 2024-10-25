part of 'check_internet_cubit.dart';

abstract class CheckInternetState {}

class CheckInternetInitial extends CheckInternetState {}

class InternetStateSuccess extends CheckInternetState {}

class InternetStateFailure extends CheckInternetState {}
