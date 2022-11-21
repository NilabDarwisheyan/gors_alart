import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class TitleAndMessage extends StatelessWidget {
  final double deviceHeight;
  TitleAndMessage(this.deviceHeight);
  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Container(
          height: deviceHeight * 0.10,
          child: Padding(
            padding: const EdgeInsets.only(left: 40.0, right: 40.0),
              child: AutoSizeText(
                "به موقع دارو مصرف کن",
                style: Theme.of(context)
                    .textTheme
                    .headline1
                    .copyWith(color: Colors.black, height: 1.3),
                textAlign: TextAlign.center,
                maxLines: 2,
              ),
            ),
          ),
        Container(
          height: deviceHeight * 0.15,
          child: Padding(
            padding: const EdgeInsets.only(left: 40.0, right: 40.0),
            child: AutoSizeText(
              "اپلیکیشن ساده که به شما یاد اوری میکند تا قرص های تان را فراموش نکنید.",
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  .copyWith(color: Colors.grey[600], height: 1.3,),
              textAlign: TextAlign.center,
              maxLines: 3,
            ),
          ),
        ),
      ],
    );
  }
}
