import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sneaker_store/provider/user_provider.dart';
import 'package:sneaker_store/utilities/app_colors.dart';
import 'package:sneaker_store/widgets/custom_button.dart';
import 'package:sneaker_store/widgets/custom_text_popins.dart';
import 'package:sneaker_store/widgets/custom_text_raleway.dart';
import 'package:sneaker_store/widgets/custom_textfield.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kWhite,
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Consumer<UserProvider>(builder: (context, value, child) {
              return Column(
                children: [
                  const SizedBox(
                    height: 60,
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Container(
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
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const CustomTextRaleway(text: 'Forgot Password'),
                  const SizedBox(
                    height: 8,
                  ),
                  const CustomTextPopins(
                    text: 'Enter your Email account to reset \n your password',
                    textAlign: TextAlign.center,
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
                  CustomButton(
                      buttonText: 'Reset password',
                      onTap: () {
                        if (value.forgotPasswordFieldsValidate(context)) {
                          value.sendPasswordResetLink(context);
                        }
                      }),
                ],
              );
            })),
      ),
    );
  }
}
