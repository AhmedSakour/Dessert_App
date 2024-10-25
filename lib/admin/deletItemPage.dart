import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/constant/app_colors.dart';
import 'package:food_delivery/servises/get_dessert_cubit/get_dessert_cubit.dart';
import '../models/dessertModel.dart';
import '../servises/delete_dessert_item_cubit/delete_dessert_item_cubit.dart';
import '../widgets/custom_confirm_dialog.dart';
import '../widgets/custom_result_dialog.dart';
import '../widgets/deleteItem.dart';

class DeleteItemPage extends StatefulWidget {
  const DeleteItemPage({super.key, required this.sweetName});
  final String? sweetName;

  @override
  State<DeleteItemPage> createState() => _DeleteItemPageState();
}

class _DeleteItemPageState extends State<DeleteItemPage> {
  List<DessertModel> desserts = [];

  getDessert() async {
    desserts = await BlocProvider.of<GetDessertCubit>(context)
        .getDessert(widget.sweetName!);
  }

  @override
  void initState() {
    getDessert();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DeleteDessertItemCubit>(
      create: (context) => DeleteDessertItemCubit(),
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(
              '${widget.sweetName} category',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'poppins',
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            backgroundColor: AppColor.mainColor,
            automaticallyImplyLeading: false,
          ),
          body: BlocBuilder<GetDessertCubit, GetDessertState>(
            builder: (context, state) {
              if (state is GetDessertLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is GetDessertSuccess) {
                return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 30),
                    child: SizedBox(
                        width: 330,
                        child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            var ds = desserts[index];
                            return DeleteItemSweet(
                              onpree: () {
                                try {
                                  customConfirmDilogo(context,
                                      data:
                                          'Are you sure you want to delete the item? ',
                                      ontap1: () {
                                    Navigator.pop(context);
                                  }, ontap2: () async {
                                    Navigator.pop(context);
                                    await BlocProvider.of<
                                            DeleteDessertItemCubit>(context)
                                        .deleteDessertItem(
                                            widget.sweetName!, desserts[index]);
                                    await getDessert();
                                  }, dataButton1: 'No', dataButton2: 'Yes');
                                } on Exception {
                                  customResultDilogo(context,
                                      data: 'There\'s a error',
                                      dataButton: 'ok',
                                      icon: Icons.error, ontap: () {
                                    Navigator.pop(context);
                                  }, colorIcon: Colors.red);
                                }
                              },
                              img: ds.image,
                              name: ds.name,
                              price: ds.price,
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(height: 20);
                          },
                          itemCount: desserts.length,
                        )));
              } else {
                return Center(
                    child: Text(
                  'NO Item',
                  style: TextStyle(
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 40),
                ));
              }
            },
          )),
    );
  }
}
