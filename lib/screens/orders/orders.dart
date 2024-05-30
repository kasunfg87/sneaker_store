import 'package:firebase_auth/firebase_auth.dart';
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
  void initState() {
    ref.read(orderRiverPod).fetchOrders(FirebaseAuth.instance.currentUser!.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kButtonGray,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
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
                height: 20,
              ),
              SizedBox(
                height: SizeConfig.h(context) * 0.75,
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
