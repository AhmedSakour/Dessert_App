import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'viewed_user_single_item_sweet_state.dart';

class ViewedUserSingleItemSweetCubit
    extends Cubit<ViewedUserSingleItemSweetState> {
  ViewedUserSingleItemSweetCubit() : super(ViewedUserSingleItemSweetInitial());

  viewedUserSingleItemSweet(
      {required String id, required String nameProduct}) async {
    try {
      var dataCake = FirebaseFirestore.instance.collection(nameProduct);
      QuerySnapshot querySnapshot = await dataCake.get();
      for (var doc in querySnapshot.docs) {
        doc.reference.update({
          "ViewedBy": FieldValue.arrayUnion([id])
        });
      }
      emit(ViewedUserSingleItemSweetSuccess());
    } on Exception {
      emit(ViewedUserSingleItemSweetFailure());
    }
  }
}
