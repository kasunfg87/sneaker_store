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
  @override
  void initState() {
    // ------ to remove top icon bar from splash screen

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    super.initState();
  }

  // --- page controller
  final PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: controller,
        itemCount: AssetConstants.imageList.length,
        itemBuilder: (context, index) {
          return Container(
            width: double.maxFinite,
            height: double.maxFinite,
            decoration: BoxDecoration(
                image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(AssetConstants.imageList[index]),
            )),
            child: Stack(
              children: [
                index == 0
                    ? const Positioned(
                        top: 130,
                        left: 90,
                        child: CustomTextRaleway(
                          text: 'WELLCOME TO \n NIKE',
                          fontColor: AppColors.kWhite,
                          fontSize: 31,
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.w900,
                        ))
                    : const SizedBox(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      index == 0
                          ? const SizedBox()
                          : Row(
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
                                            : AppColors.kWhite
                                                .withOpacity(0.3)),
                                  ),
                                );
                              })),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // FloatingActionButton(
                            //   isExtended: true,
                            //   onPressed: () {
                            //     index == 0
                            //         ? NavigationFunction.navigateTo(
                            //             BuildContext,
                            //             context,
                            //             Widget,
                            //             const SignIn())
                            //         : controller.animateToPage(index + 1,
                            //             duration:
                            //                 const Duration(milliseconds: 300),
                            //             curve: Curves.easeInOut);
                            //   },
                            //   backgroundColor: AppColors.kWhite,
                            //   child: SizedBox(
                            //       width: SizeConfig.w(context) * 0.4,
                            //       child: const Icon(Icons.arrow_forward_ios)),
                            // ),
                            GetStartedButton(onTap: () {
                              index == 0
                                  ? Navigator.pushNamed(
                                      context, SignIn.routeName)
                                  : controller.animateToPage(index + 1,
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.easeInOut);
                            })
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
