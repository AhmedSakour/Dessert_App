import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../sharedPref.dart';

part 'delete_user_account_state.dart';

class DeleteUserAccountCubit extends Cubit<DeleteUserAccountState> {
  DeleteUserAccountCubit() : super(DeleteUserAccountInitial());
  List<String> dessertItems = ['Cake', 'Cookies', 'Ice-cream', 'Pie'];

  deleteAccountUser() async {
    emit(DeleteUserAccountLoading());
    FirebaseAuth auth = FirebaseAuth.instance;
    String? email = await SharedPrefHelper().getUserEmail();
    String? password = await SharedPrefHelper().getUserPassword();
    String? id = await SharedPrefHelper().getUserId();

    AuthCredential credential = EmailAuthProvider.credential(
        email: email ?? '', password: password ?? '');
    try {
      await auth.currentUser?.reauthenticateWithCredential(credential);
      await FirebaseFirestore.instance.collection('users').doc(id).delete();
      await deleteIdUserFromViewedDesserts(id!);
      await auth.currentUser?.delete();
      await SharedPrefHelper().saveAuthRegister('false');
      await SharedPrefHelper().saveTheme('light');
      emit(DeleteUserAccountSuccess());
    } on FirebaseAuthException {
      emit(DeleteUserAccountFailure());
    }
  }

  deleteIdUserFromViewedDesserts(String id) async {
    for (int i = 0; i < dessertItems.length; i++) {
      var data = FirebaseFirestore.instance.collection(dessertItems[i]);
      QuerySnapshot querySnapshot = await data.get();
      for (var doc in querySnapshot.docs) {
        doc.reference.update({
          "ViewedBy": FieldValue.arrayRemove([id]),
        });
      }
    }
  }
}
