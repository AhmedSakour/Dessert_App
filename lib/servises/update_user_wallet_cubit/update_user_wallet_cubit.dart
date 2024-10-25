import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../sharedPref.dart';

part 'update_user_wallet_cubit_state.dart';

class UpdateUserWalletCubit extends Cubit<UpdateUserWalletCubitState> {
  UpdateUserWalletCubit() : super(UpdateUserWalletCubitInitial());

  updateUserWallet(String id, String amount) async {
    emit(UpdateUserWalletCubitLoading());
    try {
      await FirebaseFirestore.instance.collection('users').doc(id).update({
        'Wallet': amount,
      });
      await SharedPrefHelper().saveUserWallet(amount.toString());
      emit(UpdateUserWalletCubitSuccess());
    } on Exception {
      emit(UpdateUserWalletCubitFailure());
    }
  }
}
