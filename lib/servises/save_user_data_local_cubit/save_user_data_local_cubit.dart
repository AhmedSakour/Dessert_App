import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../sharedPref.dart';

part 'save_user_data_local_state.dart';

class SaveUserDataToSharedPreferenceCubit
    extends Cubit<SaveUserDataToSharedPreferenceState> {
  SaveUserDataToSharedPreferenceCubit() : super(SaveUserDataLocalInitial());
  saveUserData() async {
    emit(SaveUserDataLocalLoading());
    FirebaseAuth auth = FirebaseAuth.instance;

    String? userId = auth.currentUser?.uid;

    if (userId != null) {
      try {
        var data = FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .snapshots();

        data.forEach((element) async {
          if (element.exists) {
            await SharedPrefHelper().saveUserName(element.data()?['Name']);
            await SharedPrefHelper().saveUserEmail(element.data()?['Email']);
            await SharedPrefHelper()
                .saveUserWallet(element.data()?['Wallet'].toString() ?? '');
            await SharedPrefHelper()
                .saveUserPassword(element.data()?['Password']);
            await SharedPrefHelper().saveUserId(element.data()?['Id']);
            await SharedPrefHelper()
                .saveUserProfileImage(element.data()?['Image']);
            await SharedPrefHelper().saveAuthRegister('true');
            await SharedPrefHelper().saveTheme('light');
          }
        });
        emit(SaveUserDataLocalSuccess());
      } on Exception {
        emit(SaveUserDataLocalFailure());
      }
    }
  }
}
