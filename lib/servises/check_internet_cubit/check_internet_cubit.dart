import 'package:bloc/bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

part 'check_internet_state.dart';

class CheckInternetCubit extends Cubit<CheckInternetState> {
  CheckInternetCubit() : super(CheckInternetInitial());

  checkInternet() {
    InternetConnectionCheckerPlus().onStatusChange.listen((event) {
      if (event == InternetConnectionStatus.connected) {
        emit(InternetStateSuccess());
      } else {
        emit(InternetStateFailure());
      }
    });
  }
}
