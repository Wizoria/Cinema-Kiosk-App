import 'package:cinema_kiosk_app/navigation/nav_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Payment extends StatelessWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
      ),
      body: (Center(
        child: ElevatedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
          onPressed: () {
            GoRouter.of(context).pushNamed(advertisingPoster);
          },
          child: const Text("To total"),
        ),
      )),
    );
  }
}
