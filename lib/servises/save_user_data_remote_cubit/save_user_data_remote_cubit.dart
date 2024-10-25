import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'save_user_data_remote_state.dart';

class SaveUserDataRemoteCubit extends Cubit<SaveUserDataRemoteState> {
  SaveUserDataRemoteCubit() : super(SaveUserDataRemoteInitial());
  Future adduserDetail(Map<String, dynamic> userInfo, String id) async {
    emit(SaveUserDataRemoteLoading());
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(id)
          .set(userInfo);
      emit(SaveUserDataRemoteSuccess());
    } on Exception {
      SaveUserDataRemoteFailure();
    }
  }
}
