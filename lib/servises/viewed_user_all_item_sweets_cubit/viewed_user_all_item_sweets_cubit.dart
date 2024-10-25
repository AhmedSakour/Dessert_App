import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'viewed_user_all_item_sweets_state.dart';

class ViewedUserAllItemSweetsCubit extends Cubit<ViewedUserAllItemSweetsState> {
  ViewedUserAllItemSweetsCubit() : super(ViewedUserAllItemSweetsInitial());
  viewedUserAllSweetsItems() async {
    List items = [
      'Cake',
      'Ice-cream',
      'Pie',
      'Cookies',
    ];
    String id = FirebaseAuth.instance.currentUser?.uid ?? '';
    try {
      for (int i = 0; i < items.length; i++) {
        var data = FirebaseFirestore.instance.collection(items[i]);
        QuerySnapshot querySnapshot = await data.get();
        for (var doc in querySnapshot.docs) {
          doc.reference.update({
            "ViewedBy": FieldValue.arrayUnion([id])
          });
        }
      }
      emit(ViewedUserAllItemSweetsSucces());
    } on Exception {
      emit(ViewedUserAllItemSweetsFailure());
    }
  }
}
