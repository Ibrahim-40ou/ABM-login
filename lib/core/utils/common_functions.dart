import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../features/auth/presentation/widgets/button.dart';
import '../../features/auth/presentation/widgets/text.dart';

class Common {
  void showDialogue(
    BuildContext context,
    String errorText,
    String message,
    Function exitDialogue,
    Function confirmFunction,
  ) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async {
            context.router.popForced(true);
            return true;
          },
          child: AlertDialog(
            backgroundColor: Colors.white,
            title: CustomText(
              text: errorText.isNotEmpty ? 'error occurred' : 'confirmation',
              color: errorText.isNotEmpty
                  ? Theme.of(context).colorScheme.error
                  : Theme.of(context).colorScheme.primary,
            ),
            content: CustomText(
              text: errorText.isNotEmpty ? errorText : message,
              color: Colors.black,
            ),
            actions: <Widget>[
              CustomButton(
                function: () {
                  context.router.popForced(true);
                  confirmFunction();
                },
                color: Theme.of(context).colorScheme.primary,
                child: CustomText(
                  text: errorText.isNotEmpty ? 'okay' : 'confirm',
                  color: Colors.white,
                ),
              ),
              errorText.isNotEmpty
                  ? Container()
                  : CustomButton(
                      border: true,
                      borderColor: Colors.black,
                      function: () {
                        context.router.popForced(true);
                        exitDialogue();
                      },
                      color: Colors.white,
                      child: const CustomText(
                        text: 'cancel',
                        color: Colors.black,
                      ),
                    ),
            ],
          ),
        );
      },
    );
  }
}
