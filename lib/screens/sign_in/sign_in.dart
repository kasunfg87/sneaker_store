import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sneaker_store/provider/riverpod.dart';
import 'package:sneaker_store/screens/forgot_password/forgot_password.dart';
import 'package:sneaker_store/screens/register_account/register_account.dart';
import 'package:sneaker_store/utilities/app_colors.dart';
import 'package:sneaker_store/utilities/navigation_function.dart';
import 'package:sneaker_store/utilities/size_config.dart';
import 'package:sneaker_store/widgets/custom_button.dart';
import 'package:sneaker_store/widgets/custom_text_popins.dart';
import 'package:sneaker_store/widgets/custom_text_raleway.dart';
import 'package:sneaker_store/widgets/custom_textfield.dart';
import 'package:sneaker_store/widgets/social_button.dart';

class SignIn extends ConsumerStatefulWidget {
  static String routeName = "/signin";
  const SignIn({super.key});

  @override
  ConsumerState<SignIn> createState() => _SignInState();
}

class _SignInState extends ConsumerState<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kWhite,
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(
                  height: 60,
                ),
                Row(
                  children: [
                    Container(
                      height: 44,
                      width: 44,
                      padding: const EdgeInsets.all(10.0),
                      decoration: const BoxDecoration(
                        color: AppColors.kButtonGray,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        size: 24,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const CustomTextRaleway(text: 'Hello Again!'),
                const SizedBox(
                  height: 8,
                ),
                const CustomTextPopins(
                  text: 'Fill your details or continue with \n social media',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomTextfield(
                  headerText: 'Email Address',
                  hintText: 'xyz@gmail.com',
                  controller: ref.read(userRiverPod).emailController,
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomTextfield(
                  headerText: 'Password',
                  hintText: '********',
                  isObscure: true,
                  controller: ref.read(userRiverPod).passwordController,
                  suffixIcon: const Icon(
                    Icons.remove_red_eye_outlined,
                    color: AppColors.kLiteBlack,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        CustomNavigator.navigateTo(
                            context, const ForgotPassword());
                      },
                      child: const CustomTextPopins(
                        text: 'Recovery Password',
                        fontSize: 14,
                        fontColor: AppColors.kLiteBlack,
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                CustomButton(
                    buttonText: 'Sign In',
                    onTap: () {
                      if (ref
                          .read(userRiverPod)
                          .signInFieldsValidate(context)) {
                        ref.read(userRiverPod).startLogin(context).whenComplete(
                            () => ref
                                .read(userRiverPod)
                                .initializeUser(context, ref));
                      }
                      ref.read(userRiverPod).isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : const SizedBox();
                    }),
                const SizedBox(
                  height: 24,
                ),
                SocialButton(buttonText: 'Sign In with Google', onTap: () {}),
                SizedBox(
                  height: SizeConfig.w(context) * 0.4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CustomTextRaleway(
                      text: 'New User?',
                      fontSize: 17,
                      fontColor: AppColors.kLiteBlack,
                      fontWeight: FontWeight.normal,
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    InkWell(
                      onTap: () {
                        CustomNavigator.navigateTo(context, const Register());
                      },
                      child: const CustomTextRaleway(
                        text: 'Create Account',
                        fontSize: 17,
                        fontColor: AppColors.kBlack,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
