import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sneaker_store/provider/riverpod.dart';
import 'package:sneaker_store/utilities/app_colors.dart';
import 'package:sneaker_store/utilities/assets_constants.dart';
import 'package:sneaker_store/utilities/size_config.dart';
import 'package:sneaker_store/widgets/custom_button.dart';
import 'package:sneaker_store/widgets/custom_textfield.dart';
import 'package:sneaker_store/widgets/screen_header.dart';

class Profile extends ConsumerStatefulWidget {
  static String routeName = "/profile";
  const Profile({super.key});

  @override
  ConsumerState<Profile> createState() => _ProfileState();
}

class _ProfileState extends ConsumerState<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.kWhite,
        body: Container(
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
                    rightIconButton: true,
                    iconImage: AssetConstants.profile,
                    onTapLeft: () => Navigator.pop(context),
                    onTapRight: () {}),
                const SizedBox(
                  height: 40,
                ),
                ref.read(userRiverPod).isLoading
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
                        backgroundImage: NetworkImage(
                            ref.read(userRiverPod).userModel!.img.toString()),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: InkWell(
                            onTap: () {
                              ref
                                  .read(userRiverPod)
                                  .selectImageAndUpload()
                                  .whenComplete(() => ref
                                      .read(userRiverPod)
                                      .fetchUser(ref
                                          .read(userRiverPod)
                                          .userModel!
                                          .uid));
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
                  hintText: ref.read(userRiverPod).userModel!.fullName,
                  controller: ref.read(userRiverPod).fullNameController,
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomTextfield(
                  headerText: 'Email Address',
                  hintText: ref.read(userRiverPod).userModel!.email,
                  controller: ref.read(userRiverPod).emailController,
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomTextfield(
                  headerText: 'Location',
                  hintText:
                      ref.read(userRiverPod).userModel!.location.toString(),
                  controller: ref.read(userRiverPod).locationController,
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomTextfield(
                  headerText: 'Mobile Number',
                  hintText:
                      ref.read(userRiverPod).userModel!.mobileNo.toString(),
                  controller: ref.read(userRiverPod).mobileController,
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomButton(
                    buttonText: 'Update Info',
                    onTap: () {
                      ref.read(userRiverPod).updateUserDetails();
                    })
              ],
            ),
          ),
        ));
  }
}
