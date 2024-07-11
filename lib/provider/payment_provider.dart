import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:logger/logger.dart';
import 'package:sneaker_store/models/objects.dart';
import 'package:sneaker_store/models/payment_button_model.dart';
import 'package:sneaker_store/services/payment_services.dart';
import 'package:sneaker_store/utilities/alert_helper.dart';

class PaymentProvider extends ChangeNotifier {
  //--- payment service object
  final PaymentServices _paymentService = PaymentServices();

  // --- strat creating the payment
  Future<void> makePayment(BuildContext context, String amount,
      OrderModel orderModel, WidgetRef ref) async {
    try {
      //-- send payment intent request
      dynamic paymentIntent =
          await _paymentService.createPaymentIntent(amount, 'USD');
      if (paymentIntent != null) {
        Logger().e(paymentIntent);

        //initizlize payment sheet
        await Stripe.instance.initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent['client_secret'],
          style: ThemeMode.system,
          merchantDisplayName: 'Sneaker Store',
        ));
        //-- disply payment sheet
        // ignore: use_build_context_synchronously
        displayPaymentSheet(context, orderModel, ref);
      }
    } catch (e) {
      Logger().e(e);
    }
  }

  //-- disply payment sheet
  void displayPaymentSheet(
      BuildContext context, OrderModel orderModel, WidgetRef ref) async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        AlertHelper.openDialog(context, orderModel, ref);
      });
    } on StripeException catch (e) {
      Logger().e(e);
    } catch (e) {
      Logger().e(e);
    }
  }

  //-- payment button
  final List<PaymentButtonModel> _paymentButton = [
    PaymentButtonModel(iconsName: Icons.credit_card, text: 'Credit/Debit Card'),
    PaymentButtonModel(iconsName: Icons.money, text: 'Cash On Delivery'),
    PaymentButtonModel(iconsName: Icons.card_giftcard, text: 'Gift Card')
  ];

  List<PaymentButtonModel> get paymentButton => _paymentButton;

  //-- active payment button index

  int _selectedPaymentIndex = 0;

  int get selectedPaymentIndex => _selectedPaymentIndex;

  // Setter for the payment index
  void setPaymentIndex(int index) {
    _selectedPaymentIndex = index;
    notifyListeners();
  }
}
