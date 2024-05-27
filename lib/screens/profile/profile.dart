import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sneaker_store/provider/user_provider.dart';
import 'package:sneaker_store/utilities/app_colors.dart';
import 'package:sneaker_store/utilities/assets_constants.dart';
import 'package:sneaker_store/utilities/size_config.dart';
import 'package:sneaker_store/widgets/custom_button.dart';
import 'package:sneaker_store/widgets/custom_textfield.dart';
import 'package:sneaker_store/widgets/screen_header.dart';

class Profile extends StatefulWidget {
  static String routeName = "/profile";
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.kWhite,
        body: Consumer<UserProvider>(builder: (context, value, child) {
          return Container(
            padding: const EdgeInsets.all(20),
            height: SizeConfig.h(context),
            width: SizeConfig.w(context),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  ScreenHeader(
                      title: 'Profile',
                      rightIconButton: false,
                      iconImage: '',
                      onTapLeft: () => Navigator.pop(context),
                      onTapRight: () {}),
                  const SizedBox(
                    height: 40,
                  ),
                  value.isLoading
                      ? Shimmer.fromColors(
                          baseColor: AppColors.kButtonGray,
                          highlightColor: AppColors.kLiteBlack,
                          child: const CircleAvatar(
                            radius: 65,
                          ),
                        )
                      : CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 65,
                          backgroundImage:
                              NetworkImage(value.userModel!.img.toString()),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: InkWell(
                              onTap: () {
                                value.selectImageAndUpload().whenComplete(() =>
                                    value.fetchUser(value.userModel!.uid));
                              },
                              child: Container(
                                  height: 44,
                                  width: 44,
                                  padding: const EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                      color: AppColors.kLiteBlue,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: AppColors.kWhite,
                                        width: 3,
                                      )),
                                  child: SvgPicture.asset(
                                      AssetConstants.pencilIcon)),
                            ),
                          ),
                        ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomTextfield(
                    readOnly: true,
                    headerText: 'Your Name',
                    hintText: value.userModel!.fullName,
                    controller: value.fullNameController,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomTextfield(
                    headerText: 'Email Address',
                    hintText: value.userModel!.email,
                    controller: value.emailController,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomTextfield(
                    headerText: 'Location',
                    hintText: value.userModel!.location.toString(),
                    controller: value.locationController,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomTextfield(
                    headerText: 'Mobile Number',
                    hintText: value.userModel!.mobileNo.toString(),
                    controller: value.mobileController,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomButton(
                      buttonText: 'Update Info',
                      onTap: () {
                        value.updateUserDetails();
                      })
                ],
              ),
            ),
          );
        }));
  }
}
