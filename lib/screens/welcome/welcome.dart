import 'dart:async';

import 'package:flutter/material.dart';
import '../../helpers/platform_flat_button.dart';
import '../../screens/welcome/title_and_message.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double deviceHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    void goToHomeScreen() => Navigator.pushReplacementNamed(context, "/home");

    Timer(Duration(seconds: 4), goToHomeScreen);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: deviceHeight * 0.04,
            ),
            Image.asset('assets/images/welcome_pic.jpg',
                width: double.infinity, height: deviceHeight * 0.6),
            SizedBox(
              height: deviceHeight * 0.1,
            ),
            TitleAndMessage(deviceHeight),
          ],
        ),
      ),
    );
  }
}
