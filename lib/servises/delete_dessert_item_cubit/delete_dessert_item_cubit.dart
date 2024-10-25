import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_delivery/models/dessertModel.dart';

part 'delete_dessert_item_state.dart';

class DeleteDessertItemCubit extends Cubit<DeleteDessertItemState> {
  DeleteDessertItemCubit() : super(DeleteDessertItemInitial());
  deleteDessertItem(String categoryName, DessertModel dessertModel) async {
    emit(DeleteDessertItemLoading());
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection(categoryName).get();

      for (var item in snapshot.docs) {
        if (item.get('id').toString() == dessertModel.id) {
          await item.reference.delete();
        }
      }
      emit(DeleteDessertItemSuccess());
    } on Exception {
      emit(DeleteDessertItemFailure());
    }
  }
}
