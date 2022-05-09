import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:smartkit/integration/helper/Constant.dart';
import 'dart:math';

class StripeTransactionResponse {
  final String? message, status, stripePayId;
  bool? success;
  StripeTransactionResponse(
      {this.message, this.success, this.status, this.stripePayId});
}

class StripeService {
  static String apiBase = 'https://api.stripe.com/v1';
  static String paymentApiUrl = '${StripeService.apiBase}/payment_intents';
  static String secret = Constant.stripeSeckey;
  static String pubkey = Constant.stripePubkey;
  static String stripeMode = Constant.stripeMode;

  static Map<String, String> headers = {
    'Authorization': 'Bearer ${StripeService.secret}',
    'Content-Type': 'application/x-www-form-urlencoded'
  };
  final paymentMethod = Stripe.instance.createPaymentMethod(PaymentMethodParams.card());
  static init() {
    Stripe.publishableKey = pubkey;
  }

  static /*Future<StripeTransactionResponse>*/ payWithCard({String? amount, String? currency, CardDetails? card}) async {
    await Stripe.instance.dangerouslyUpdateCardDetails(card!);

    try {
      // 1. Gather customer billing information (ex. email)

      final billingDetails = BillingDetails(
        email: 'email@stripe.com',
        phone: '+48888000888',
        address: Address(
          city: 'Houston',
          country: 'US',
          line1: '1459  Circle Drive',
          line2: '',
          state: 'Texas',
          postalCode: '77063',
        ),
      ); // mocked data for tests

      // 2. Create payment method
      final paymentMethod =
      await Stripe.instance.createPaymentMethod(PaymentMethodParams.card(
          billingDetails: billingDetails
      ));
      print(paymentMethod.id);

      // 3. call API to create PaymentIntent
      final paymentIntentResult = await callNoWebhookPayEndpointMethodId(
        useStripeSdk: true,
        paymentMethodId: paymentMethod.id,
        currency: currency!, // mocked data
        items: [
          {'id': 'id'}
        ] ,
      );
      if (paymentIntentResult['error'] != null) {
        // Error during creating or confirming Intent
        return new StripeTransactionResponse(
            message:paymentIntentResult['error'],
            success: false,
            status: "",
            stripePayId: paymentMethod.id);
      }

      if (paymentIntentResult['clientSecret'] != null &&
          paymentIntentResult['requiresAction'] == null) {
        // Payment succedeed
        return new StripeTransactionResponse(
            message: 'Transaction successful',
            success: true,
            status: "",
            stripePayId: paymentMethod.id);
      }

      if (paymentIntentResult['clientSecret'] != null &&
          paymentIntentResult['requiresAction'] == true) {
        // 4. if payment requires action calling handleCardAction
        final paymentIntent = await Stripe.instance.handleCardAction(paymentIntentResult['clientSecret']);

        if (paymentIntent.status == PaymentIntentsStatus.RequiresConfirmation) {
          // 5. Call API to confirm intent
          await confirmIntent(paymentIntent.id);
        } else {
          return new StripeTransactionResponse(
              message:paymentIntentResult['error'],
              success: false,
              status: "",
              stripePayId: paymentMethod.id);
          // Payment succedeed
          // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: ${paymentIntentResult['error']}')));
        }
      }
    } on PlatformException catch (err) {
      return StripeService.getPlatformExceptionErrorResult(err);}
    catch (e) {
      print(e.toString());
      return new StripeTransactionResponse(
          message:"error",
          success: false,
          status: "",
          stripePayId:"");
    }
  }

  static Future<void> confirmIntent(String paymentIntentId) async {
    final result = await callNoWebhookPayEndpointIntentId(
        paymentIntentId: paymentIntentId);
    if (result['error'] != null) {
      StripeTransactionResponse(
          message:result['error'],
          success: false,
          status: "",
          stripePayId:"");
    } else {
      StripeTransactionResponse(
          message:"Success!: The payment was confirmed successfully!",
          success: true,
          status: "",
          stripePayId:"");
          }
  }

  static Future<Map<String, dynamic>> callNoWebhookPayEndpointIntentId({
    required String paymentIntentId,
  }) async {
    final url = Uri.parse(StripeService.paymentApiUrl);
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        "Authorization": "Bearer " + "sk_test_udo2toyNTi67pQj3mvndb0yo001oJo4q9i"
      },
      body: json.encode({'paymentIntentId': paymentIntentId}),
    );
    return json.decode(response.body);
  }
  static String _currentSecret = Constant.stripeSeckey;
  static String kApiUrl = defaultTargetPlatform == TargetPlatform.android
      ? 'http://10.0.2.2:4242'
      : 'http://localhost:4242';
  static /*Future<Map<String, dynamic>>*/ callNoWebhookPayEndpointMethodId({
    required bool useStripeSdk,
    required String paymentMethodId,
    required String currency,
    List<Map<String, dynamic>>? items,
  }) async {
    try {
      final url = Uri.parse(StripeService.paymentApiUrl);
      final response = await http.post(
        url,
        headers: {
          "Authorization": 'Bearer $_currentSecret',
          'Content-Type': 'application/x-www-form-urlencoded',

        },
        body: json.encode({
          /*'useStripeSdk': useStripeSdk,*/
          'paymentMethodId': paymentMethodId,
          'currency': currency,
          /*'items': items*/
        }),
      );
      print( json.decode(response.body));
      return json.decode(response.body);
    }catch(e){
      print(e.toString());
    }
  }

  static getPlatformExceptionErrorResult(err) {
    String message = 'Something went wrong';
    if (err.code == 'cancelled') {
      message = 'Transaction cancelled';
    }

    return new StripeTransactionResponse(
        message: message, success: false, status: "cancelled");
  }

  static Future<Map<String, dynamic>?> createPaymentIntent(
      String? amount, String? currency) async {
    String orderId =
        "order-${DateTime.now().millisecondsSinceEpoch}-${Random().nextInt(900) + 100}";

    try {
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
        'payment_method_types[]': 'card',
        'metadata[order_id]': orderId
      };

      var response = await http.post(Uri.parse(StripeService.paymentApiUrl),
          body: body, headers: StripeService.headers);

      return jsonDecode(response.body);
    } catch (err) {
     print("err is ....................."+err.toString());
    }
    return null;
  }
}
