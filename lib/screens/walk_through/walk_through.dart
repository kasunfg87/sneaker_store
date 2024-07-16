import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sneaker_store/screens/sign_in/sign_in.dart';
import 'package:sneaker_store/utilities/app_colors.dart';
import 'package:sneaker_store/utilities/assets_constants.dart';
import 'package:sneaker_store/utilities/size_config.dart';
import 'package:sneaker_store/widgets/custom_text_raleway.dart';
import 'package:sneaker_store/widgets/get_started_button.dart';

class WalkThrough extends StatefulWidget {
  static String routeName = "/walkthrough";

  const WalkThrough({super.key});

  @override
  State<WalkThrough> createState() => _WalkThroughState();
}

class _WalkThroughState extends State<WalkThrough> {
  final PageController _controller = PageController();

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _controller,
        itemCount: AssetConstants.imageList.length,
        itemBuilder: (context, index) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(AssetConstants.imageList[index]),
              ),
            ),
            child: Stack(
              children: [
                if (index == 0)
                  const Positioned(
                    top: 130,
                    left: 90,
                    child: CustomTextRaleway(
                      text: 'WELCOME TO \n NIKE',
                      fontColor: AppColors.kWhite,
                      fontSize: 31,
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (index != 0)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(3, (indexDots) {
                            return SlideInLeft(
                              duration: const Duration(milliseconds: 400),
                              child: Container(
                                margin: const EdgeInsets.only(left: 6),
                                width: index == indexDots ? 25 : 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: index == indexDots
                                      ? AppColors.kWhite
                                      : AppColors.kWhite.withOpacity(0.3),
                                ),
                              ),
                            );
                          }),
                        ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GetStartedButton(
                              onTap: () {
                                if (index == 0) {
                                  Navigator.pushNamed(
                                      context, SignIn.routeName);
                                } else {
                                  _controller.animateToPage(
                                    index + 1,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.h(context) * 0.08,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
