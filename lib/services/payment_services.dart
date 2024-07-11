import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class PaymentServices {
  // Calculate amount in cents
  String calculateAmount(String amount) {
    final doubleAmount = double.parse(amount);
    final centsAmount = (doubleAmount * 100).toInt();
    return centsAmount.toString();
  }

  Future<Map<String, dynamic>> createPaymentIntent(
      String amount, String currency) async {
    try {
      // Request body
      final Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
      };

      // Make the HTTP request to Stripe
      final response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET']}',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: body,
      );

      // Log the response
      Logger().e(response.body);

      // Parse and return the response body
      return json.decode(response.body) as Map<String, dynamic>;
    } catch (e) {
      // Log the error
      Logger().e(e.toString());
      throw Exception('Failed to create payment intent: ${e.toString()}');
    }
  }
}
