import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/models/dessertModel.dart';

import 'package:food_delivery/servises/sharedPref.dart';
import 'package:food_delivery/servises/viewed_user_singleItem_cubit/viewed_user_single_item_sweet_cubit.dart';

import '../constant/app_colors.dart';
import '../servises/get_dessert_cubit/get_dessert_cubit.dart';
import '../widgets/item_sweet.dart';
import '../widgets/item_sweet_hor.dart';
import '../widgets/item_sweet_ver.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomeState();
}

bool iceCream = false, pie = false, cookies = false, cake = false;
List<DessertModel> desserts = [];
String? id, name;
List<String> itemsNames = ['Cake', 'Ice-cream', 'Pie', 'Cookies'];

class _HomeState extends State<HomePage> {
  getDessert() async {
    desserts =
        await BlocProvider.of<GetDessertCubit>(context).getDessert('Cake');
  }

  getUserInfo() async {
    id = await SharedPrefHelper().getUserId();
    name = await SharedPrefHelper().getUserName();
  }

  @override
  void initState() {
    getDessert();
    getUserInfo();
    cake = true;
    pie = false;
    iceCream = false;
    cookies = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final getDessertCubit = BlocProvider.of<GetDessertCubit>(context);
    return BlocProvider<ViewedUserSingleItemSweetCubit>(
      create: (context) => ViewedUserSingleItemSweetCubit(),
      child: Scaffold(
        body: BlocBuilder<GetDessertCubit, GetDessertState>(
          builder: (context, state) {
            if (state is GetDessertSuccess) {
              return SafeArea(
                  child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Hello $name',
                          style: TextStyle(
                              color: AppColor.mainColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              fontFamily: 'poppins'),
                        ),
                        Image.asset(
                          'assest/images/desset_logo.png',
                          width: 60,
                          height: 60,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                              onTap: () async {
                                setState(() {
                                  cake = true;
                                  cookies = false;
                                  pie = false;
                                  iceCream = false;
                                });
                                desserts =
                                    await getDessertCubit.getDessert('Cake');
                              },
                              child: ItemSweet(
                                img: 'assest/images/cake.png',
                                containerColor: cake
                                    ? AppColor.mainColor
                                    : Theme.of(context).colorScheme.background,
                                colimg: cake
                                    ? Colors.white
                                    : Theme.of(context).colorScheme.primary,
                              )),
                          GestureDetector(
                              onTap: () async {
                                setState(() {
                                  cake = false;
                                  cookies = false;
                                  pie = false;
                                  iceCream = true;
                                });
                                desserts = await getDessertCubit
                                    .getDessert('Ice-cream');
                              },
                              child: ItemSweet(
                                img: 'assest/images/ice-cream.png',
                                containerColor: iceCream
                                    ? AppColor.mainColor
                                    : Theme.of(context).colorScheme.background,
                                colimg: iceCream
                                    ? Colors.white
                                    : Theme.of(context).colorScheme.primary,
                              )),
                          GestureDetector(
                              onTap: () async {
                                setState(() {
                                  cake = false;
                                  cookies = false;
                                  pie = true;
                                  iceCream = false;
                                });
                                desserts =
                                    await getDessertCubit.getDessert('Pie');
                              },
                              child: ItemSweet(
                                img: 'assest/images/pie.png',
                                containerColor: pie
                                    ? AppColor.mainColor
                                    : Theme.of(context).colorScheme.background,
                                colimg: pie
                                    ? Colors.white
                                    : Theme.of(context).colorScheme.primary,
                              )),
                          GestureDetector(
                              onTap: () async {
                                setState(() {
                                  cake = false;
                                  cookies = true;
                                  pie = false;
                                  iceCream = false;
                                });
                                desserts =
                                    await getDessertCubit.getDessert('Cookies');
                              },
                              child: ItemSweet(
                                img: 'assest/images/cookie.png',
                                containerColor: cookies
                                    ? AppColor.mainColor
                                    : Theme.of(context).colorScheme.background,
                                colimg: cookies
                                    ? Colors.white
                                    : Theme.of(context).colorScheme.primary,
                              )),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      height: 240,
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        separatorBuilder: (context, index) => SizedBox(
                          width: 10,
                        ),
                        itemCount: desserts.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () async {
                              Navigator.pushNamed(context, 'Detail',
                                  arguments: desserts[index]);
                              if (!desserts[index].viewedBy.contains(id)) {
                                await BlocProvider.of<
                                        ViewedUserSingleItemSweetCubit>(context)
                                    .viewedUserSingleItemSweet(
                                        id: id!,
                                        nameProduct: itemsNames[index]);
                                desserts = await getDessertCubit
                                    .getDessert(itemsNames[index]);
                              }
                            },
                            child: ItemSweetVertical(
                                isVisible:
                                    desserts[index].viewedBy.contains(id),
                                img: desserts[index].image,
                                price: desserts[index].price,
                                subtitle: desserts[index].description,
                                titel: desserts[index].name),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 400,
                      child: ListView.separated(
                        separatorBuilder: (context, index) => SizedBox(
                          height: 5,
                        ),
                        itemCount: desserts.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return ItemSweetHorizintal(
                              img: desserts[index].image,
                              price: desserts[index].price,
                              subtitle: desserts[index].description,
                              titel: desserts[index].name);
                        },
                      ),
                    ),
                  ]),
                ),
              ));
            } else if (state is GetDessertLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is GetDessertFailure) {
              return Center(child: Text(state.errorMessage));
            }
            return Container();
          },
        ),
      ),
    );
  }
}
