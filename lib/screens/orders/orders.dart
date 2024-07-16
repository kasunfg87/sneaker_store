import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sneaker_store/provider/riverpod.dart';
import 'package:sneaker_store/utilities/app_colors.dart';
import 'package:sneaker_store/utilities/size_config.dart';
import 'package:sneaker_store/widgets/custom_text_popins.dart';
import 'package:sneaker_store/widgets/order_tile.dart';
import 'package:sneaker_store/widgets/screen_header.dart';

class Orders extends ConsumerStatefulWidget {
  static String routeName = "/orders";

  const Orders({super.key});

  @override
  ConsumerState<Orders> createState() => _OrdersState();
}

class _OrdersState extends ConsumerState<Orders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kButtonGray,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ScreenHeader(
                title: 'Orders',
                iconImage: '',
                onTapLeft: () {},
                onTapRight: () {},
                rightTextButton: true,
                rightButtonText:
                    ref.read(orderRiverPod).allOrders.length.toString(),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                height: SizeConfig.h(context) * 0.77,
                width: SizeConfig.w(context),
                child: ref.watch(orderRiverPod).allOrders.isNotEmpty
                    ? ListView.builder(
                        itemCount: ref.watch(orderRiverPod).allOrders.length,
                        itemBuilder: (context, index) {
                          return OrderTile(
                              orderModel:
                                  ref.watch(orderRiverPod).allOrders[index]);
                        },
                      )
                    : const Center(
                        child: CustomTextPopins(text: 'No Orders yet')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
