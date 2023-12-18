import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:kinder_joy_1/parents/parentsFragments/parents_study_fee_fragment_screen.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {

  Map<String, dynamic>? paymentIntent;
  var clientkey = "sk_test_51OOBkICvnNFxCr3XyEcCUlFExFjaVdsfKTHJjFCyKxn04AivLF45WH6DSnsasOHD4bqFE0glkA8R90VmeN5MokzA00kA6b6y2s"; // Secret Key

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(38.0),
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "STUDY FEE",
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(width: 16,),
                    Text(
                      "RM400",
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "MEALS FEE",
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(width: 16,),
                    Text(
                      "RM300",
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "TRANSPORTATION FEE",
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(width: 16,),
                    Text(
                      "RM300",
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "SERVICE FEE",
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(width: 16,),
                    Text(
                      "RM200",
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "TOTAL",
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(width: 16,),
                    Text(
                      "RM1200",
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 40),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "PAYMENT STATUS",
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(width: 16,),
                    Text(
                      "UNPAID",
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20),

                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image:  NetworkImage(
                        "https://i.pinimg.com/564x/16/9a/88/169a88947fe29fb44d8f24d8d31b82ee.jpg",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // const Text("Buy Premium Membership at 10 INR"),
                Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.teal,
                  margin: const EdgeInsets.all(10),
                  child: TextButton(
                    onPressed: () => makePayment(),
                    child: const Text(
                      'Pay',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  createPaymentIntent(String amount, String currency) async {
    try {

      // TODO: Request body
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };

      // TODO: POST request to stripe
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer ' + clientkey,
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      log('Payment Intent Body->>> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      log('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final calculatedAmout = (int.parse(amount)) * 100;
    return calculatedAmout.toString();
  }

  Future<void> makePayment() async {
    try {

      // TODO: Create Payment intent
      paymentIntent = await createPaymentIntent('1200', 'MYR');

      // TODO: Initialte Payment Sheet
      await Stripe.instance
          .initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent!['client_secret'],
          applePay: null,
          googlePay: null,
          style: ThemeMode.light,
          merchantDisplayName: 'someMerchantName',
        ),
      )
          .then((value) {
        log("Success");
      });

      // TODO: now finally display payment sheeet
      displayPaymentSheet();
    } catch (e, s) {
      String ss = "exception 1 :$e";
      String s2 = "reason :$s";
      log("exception 1:$e");
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Icon(
                        Icons.check_circle,
                        color: Colors.green,
                      ),
                    ),
                    Text("Payment Successful"),
                  ],
                ),
              ],
            ),
          ),
        );

        // TODO: update payment intent to null
        paymentIntent = null;

        Future.delayed(Duration(milliseconds: 2000), ()
        {
          Get.to(StudyFeeYearList());
        });
      }).onError((error, stackTrace) {
        String ss = "exception 2 :$error";
        String s2 = "reason :$stackTrace";
      });
    } on StripeException catch (e) {
      print('Error is:---> $e');
      String ss = "exception 3 :$e";
    } catch (e) {
      log('$e');
    }
  }
}