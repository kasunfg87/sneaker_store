import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sneaker_store/provider/user_provider.dart';
import 'package:sneaker_store/screens/sign_in/sign_in.dart';
import 'package:sneaker_store/utilities/app_colors.dart';
import 'package:sneaker_store/utilities/navigation_function.dart';
import 'package:sneaker_store/utilities/size_config.dart';
import 'package:sneaker_store/widgets/custom_button.dart';
import 'package:sneaker_store/widgets/custom_text_popins.dart';
import 'package:sneaker_store/widgets/custom_text_raleway.dart';
import 'package:sneaker_store/widgets/custom_textfield.dart';
import 'package:sneaker_store/widgets/social_button.dart';

class Register extends StatefulWidget {
  static String routeName = "/register";

  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kWhite,
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Consumer<UserProvider>(
              builder: (context, value, child) {
                return Column(
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
                    const CustomTextRaleway(text: 'Register Account'),
                    const SizedBox(
                      height: 8,
                    ),
                    const CustomTextPopins(
                      text:
                          'Fill your details or continue with \n social media',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomTextfield(
                      headerText: 'Your Name',
                      hintText: 'xxxxxxxxx',
                      controller: value.fullNameController,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomTextfield(
                      headerText: 'Email Address',
                      hintText: 'xyz@gmail.com',
                      controller: value.emailController,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomTextfield(
                      headerText: 'Password',
                      hintText: '********',
                      controller: value.passwordController,
                      isObscure: true,
                      suffixIcon: const Icon(
                        Icons.remove_red_eye_outlined,
                        color: AppColors.kLiteBlack,
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    CustomButton(
                        buttonText: 'Sign Up',
                        onTap: () {
                          if (value.signUpFieldsValidate(context)) {
                            value.startSignUp(context).whenComplete(
                                  () => NavigationFunction.navigateTo(
                                      BuildContext,
                                      context,
                                      Widget,
                                      const SignIn()),
                                );
                          }
                        }),
                    const SizedBox(
                      height: 24,
                    ),
                    SocialButton(
                        buttonText: 'Sign Up with Google', onTap: () {}),
                    SizedBox(
                      height: SizeConfig.w(context) * 0.180,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CustomTextRaleway(
                          text: 'Already Have Account?',
                          fontSize: 16,
                          fontColor: AppColors.kLiteBlack,
                          fontWeight: FontWeight.normal,
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        InkWell(
                          onTap: () {
                            NavigationFunction.navigateTo(
                                BuildContext, context, Widget, const SignIn());
                          },
                          child: const CustomTextRaleway(
                            text: 'Log In',
                            fontSize: 16,
                            fontColor: AppColors.kBlack,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            )),
      ),
    );
  }
}
