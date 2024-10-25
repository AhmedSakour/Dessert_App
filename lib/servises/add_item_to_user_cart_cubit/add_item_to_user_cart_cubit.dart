import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'add_item_to_user_cart_state.dart';

class AddItemToUserCartCubit extends Cubit<AddItemToUserCartState> {
  AddItemToUserCartCubit() : super(AddItemToUserCartInitial());
  Future adduserCart(Map<String, dynamic> userCart, String id) async {
    emit(AddItemToUserCartLoading());
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(id)
          .collection('Cart')
          .add(userCart);
      emit(AddItemToUserCartSuccess());
    } on Exception {
      emit(AddItemToUserCartFailure());
    }
  }
}
