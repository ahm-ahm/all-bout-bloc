import 'package:flutter/material.dart';
import '../Utils/app_strings.dart';
import 'custom_button.dart';
import 'custom_text.dart';

class SingleErrorTryAgainWidget extends StatelessWidget {
  final VoidCallback onClick;
  final double bottomMargin;
  final String? message;

  const SingleErrorTryAgainWidget(
      {super.key,
      required this.onClick,
      required this.bottomMargin,
      this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: bottomMargin),
      child: Center(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomText(text: message ?? AppStrings.unknownError, fontSize: 17),
            const SizedBox(height: 10),
            SizedBox(
                width: 110,
                height: 35,
                child: AppButton(
                  text: CustomText(
                      text: AppStrings.tryAgain,
                      fontSize: 15,
                      color: Theme.of(context).colorScheme.onPrimary),
                  shape: const RoundedRectangleBorder(
                      side: BorderSide(width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  onClick: onClick,
                  backgroundColor: Theme.of(context).primaryColor,
                ))
          ],
        ),
      )),
    );
  }
}
