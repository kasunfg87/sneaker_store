import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sneaker_store/provider/order_provider.dart';
import 'package:sneaker_store/utilities/app_colors.dart';
import 'package:sneaker_store/utilities/size_config.dart';
import 'package:sneaker_store/widgets/custom_text_popins.dart';
import 'package:sneaker_store/widgets/order_tile.dart';
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
                iconImage: '',
                onTapLeft: () {},
                onTapRight: () {},
                rightTextButton: true,
                rightButtonText: Provider.of<OrderPrvider>(context)
                    .allOrders
                    .length
                    .toString(),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: SizeConfig.h(context) * 0.75,
                width: SizeConfig.w(context),
                child: Consumer<OrderPrvider>(
                  builder: (context, value, child) {
                    return value.allOrders.isNotEmpty
                        ? ListView.builder(
                            itemCount: value.allOrders.length,
                            itemBuilder: (context, index) {
                              return OrderTile(
                                  orderModel: value.allOrders[index]);
                            },
                          )
                        : const Center(
                            child: CustomTextPopins(text: 'No Orders yet'));
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
