import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_delivery/models/orderModel.dart';
part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderInitial());

  int? totalPrice;

  List<OrderModel>? orderModel;
  Future<void> getCart({required String id}) async {
    try {
      emit(OrderGetLoading());
      CollectionReference collection = FirebaseFirestore.instance
          .collection('users')
          .doc(id)
          .collection('Cart');
      QuerySnapshot querySnapshot = await collection.get();
      if (querySnapshot.docs.isNotEmpty) {
        orderModel = querySnapshot.docs
            .map((doc) => OrderModel(
                amount: doc['Quantity'],
                image: doc['Image'],
                title: doc['Name'],
                price: doc['Price']))
            .toList();
        totalPrice = 0;
        for (var doc in querySnapshot.docs) {
          int price = int.parse(doc['Quantity'] ?? '0') *
              int.parse(doc['Price'] ?? '0');
          totalPrice = ((totalPrice ?? 0) + price);
        }
        emit(OrderGetSucces());
      } else {
        emit(OrderGetError('No Order'));
      }
    } on Exception catch (e) {
      print(e);
      emit(OrderGetError(e.toString()));
    }
  }

  deletOrder(int index, String id) async {
    emit(OrderDeleteLoading());
    try {
      CollectionReference collection = FirebaseFirestore.instance
          .collection('users')
          .doc(id)
          .collection('Cart');
      QuerySnapshot querySnapshot = await collection.get();
      querySnapshot.docs[index].reference.delete();

      emit(OrderDeleteSuccess());
    } on Exception {
      emit(OrderDeleteFailure());
    }
  }

  Future<void> deleteCart(String id) async {
    emit(CartDeleteLoading());
    try {
      final CollectionReference collectionReference = FirebaseFirestore.instance
          .collection('users')
          .doc(id)
          .collection('Cart');

      final QuerySnapshot cartSnapshot = await collectionReference.get();
      final WriteBatch batch = FirebaseFirestore.instance.batch();

      for (DocumentSnapshot document in cartSnapshot.docs) {
        batch.delete(document.reference);
      }
      await batch.commit();
      emit(CartDeleteSuccess());
    } on Exception {
      emit(CartDeleteFailure());
    }
  }
}
