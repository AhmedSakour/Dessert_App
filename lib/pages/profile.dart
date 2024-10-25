import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/servises/upload_user_photo_cubit/upload_user_photo_cubit.dart';

import 'package:url_launcher/link.dart';
import '../constant/app_colors.dart';

import '../servises/delete_user_account_cubit/delete_user_account_cubit.dart';
import '../servises/sharedPref.dart';
import '../servises/theme_cubit/theme_cubit.dart';
import '../widgets/custom_confirm_dialog.dart';
import '../widgets/custom_profile_container.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? name, email, id, theme;

  bool dark = false;

  getUserProfile() async {
    name = await SharedPrefHelper().getUserName();
    email = await SharedPrefHelper().getUserEmail();
    id = await SharedPrefHelper().getUserId();
    setState(() {});
  }

  load() async {
    theme = await SharedPrefHelper().getUserTheme();

    dark = theme == 'dark' ? true : false;
    setState(() {});
  }

  @override
  void initState() {
    getUserProfile();
    load();

    BlocProvider.of<ThemeCubit>(context).themeDataStyle;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeCubit = BlocProvider.of<ThemeCubit>(context);
    return Scaffold(
        body: SafeArea(
            child: BlocProvider.of<UploadUserPhotoCubit>(context)
                        .imageProfile ==
                    null
                ? Center(
                    child: CircularProgressIndicator(color: Colors.blue),
                  )
                : SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(children: [
                      Stack(
                        children: [
                          Container(
                            height: 200,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(120),
                                    bottomLeft: Radius.circular(120)),
                                color: AppColor.mainColor),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(top: 120),
                              child: Align(
                                alignment: Alignment.center,
                                child: GestureDetector(
                                    onTap: () async {
                                      final currentContext = context;
                                      await BlocProvider.of<
                                              UploadUserPhotoCubit>(context)
                                          .getImage();
                                      if (mounted) {
                                        await BlocProvider.of<
                                                    UploadUserPhotoCubit>(
                                                currentContext)
                                            .uploadImage(id!);
                                        setState(() {});
                                      }
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: CachedNetworkImage(
                                        imageUrl: BlocProvider.of<
                                                UploadUserPhotoCubit>(context)
                                            .imageProfile!,
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                        placeholder: (context, url) => Center(
                                          child: SizedBox(
                                              width: 20,
                                              height: 20,
                                              child:
                                                  CircularProgressIndicator()),
                                        ),
                                        width: 90,
                                        height: 90,
                                        fit: BoxFit.cover,
                                      ),
                                    )),
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomContainerProfile(
                        icon: Icons.person,
                        nameField: 'Name',
                        valueField: '$name',
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomContainerProfile(
                        icon: Icons.email,
                        nameField: 'Email',
                        valueField: '$email',
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomContainerProfile(
                          nameField: 'Dark Theme',
                          icon: Icons.color_lens,
                          suffixIconVisible: true,
                          darkValue: dark,
                          changeTheme: (value) async {
                            await themeCubit.changeTheme();
                            await themeCubit.initializeTheme();

                            dark = !dark;
                            setState(() {});
                          },
                          visiblevalueField: false),
                      SizedBox(
                        height: 20,
                      ),
                      Link(
                        uri: Uri.tryParse(
                            'https://sites.google.com/view/skgdessert'),
                        target: LinkTarget.defaultTarget,
                        builder: (context, openLink) => GestureDetector(
                          onTap: openLink,
                          child: CustomContainerProfile(
                            icon: Icons.privacy_tip,
                            nameField: 'Privacy Policy',
                            visiblevalueField: false,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, 'ContactUs');
                        },
                        child: CustomContainerProfile(
                          icon: Icons.help_outline,
                          nameField: 'Help',
                          visiblevalueField: false,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () async {
                          customConfirmDilogo(
                            context,
                            data: 'Are you sure to delete the account?',
                            dataButton1: 'No',
                            dataButton2: 'Yes',
                            ontap1: () {
                              Navigator.pop(context);
                            },
                            ontap2: () async {
                              await BlocProvider.of<DeleteUserAccountCubit>(
                                      context)
                                  .deleteAccountUser();
                              await themeCubit.initializeTheme();

                              if (mounted) {
                                Navigator.pushNamedAndRemoveUntil(
                                    context, 'Welcome', (route) => false);
                              }
                            },
                          );
                        },
                        child: CustomContainerProfile(
                          icon: Icons.delete,
                          nameField: 'Delete Account',
                          visiblevalueField: false,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          customConfirmDilogo(
                            context,
                            data: 'Are you sure to Log out?',
                            dataButton1: 'No',
                            dataButton2: 'Yes',
                            ontap1: () {
                              Navigator.pop(context);
                            },
                            ontap2: () async {
                              Navigator.pushNamedAndRemoveUntil(
                                  context, 'Welcome', (route) => false);
                              await SharedPrefHelper().saveTheme('light');
                              await themeCubit.initializeTheme();

                              await SharedPrefHelper()
                                  .saveAuthRegister('false');
                            },
                          );
                        },
                        child: CustomContainerProfile(
                          icon: Icons.logout,
                          nameField: 'Log out',
                          visiblevalueField: false,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ]))));
  }
}
