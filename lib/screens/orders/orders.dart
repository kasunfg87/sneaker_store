import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sneaker_store/provider/order_provider.dart';
import 'package:sneaker_store/provider/product_provider.dart';
import 'package:sneaker_store/utilities/app_colors.dart';
import 'package:sneaker_store/utilities/assets_constants.dart';
import 'package:sneaker_store/utilities/size_config.dart';
import 'package:sneaker_store/widgets/screen_header.dart';

class Orders extends StatefulWidget {
  static String routeName = "/orders";

  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  void initState() {
    Provider.of<OrderPrvider>(context, listen: false)
        .fetchOrders(FirebaseAuth.instance.currentUser!.uid);
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
                iconImage: AssetConstants.heartEmpty,
                onTapLeft: () {},
                onTapRight: () {},
              ),
              const SizedBox(
                height: 40,
              ),
              Consumer<OrderPrvider>(
                builder: (context, value, child) {
                  return SizedBox(
                    height: SizeConfig.h(context) * 0.9,
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          return Container(
                            child: Column(
                              children: [
                                Text(value.allOrders[index].orderId),
                                SizedBox(
                                  height: 30,
                                  child: ListView.separated(
                                      itemBuilder: (context, index2) =>
                                          Image.network(
                                              height: 30,
                                              value
                                                  .allOrders[index]
                                                  .cartItems[index2]
                                                  .productModel
                                                  .img),
                                      separatorBuilder: (context, index) =>
                                          const SizedBox(
                                            height: 10,
                                          ),
                                      itemCount: value
                                          .allOrders[index].cartItems.length),
                                ),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => const SizedBox(
                              height: 15,
                            ),
                        itemCount: value.allOrders.length),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
