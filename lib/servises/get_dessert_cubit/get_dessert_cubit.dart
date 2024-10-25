import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_delivery/models/dessertModel.dart';

part 'get_dessert_state.dart';

class GetDessertCubit extends Cubit<GetDessertState> {
  GetDessertCubit() : super(GetDessertInitial());
  getDessert(String name) async {
    emit(GetDessertLoading());
    List<DessertModel> dessertList = [];
    try {
      var data = FirebaseFirestore.instance.collection(name);
      QuerySnapshot snapshot = await data.get();
      for (var element in snapshot.docs) {
        dessertList.add(
            DessertModel.fromfireStore(element.data() as Map<String, dynamic>));
      }
      emit(GetDessertSuccess());
      return dessertList;
    } on Exception catch (e) {
      emit(GetDessertFailure(errorMessage: e.toString()));
    }
  }
}
