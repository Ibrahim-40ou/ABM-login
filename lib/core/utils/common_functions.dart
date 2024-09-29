import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../features/auth/presentation/widgets/button.dart';
import '../../features/auth/presentation/widgets/text.dart';


class Common {
  void showSnackBar(BuildContext context, String text) {
    final bool isDarkMode =
    Theme.of(context).brightness == Brightness.dark ? true : false;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 20,
        ),
        content: Row(
          children: [
            Icon(
              Icons.check,
              color: Theme.of(context).colorScheme.primary,
              size: 24,
            ),
            const SizedBox(width: 8),
            MyText(
              text: text,
              size: 16,
              weight: FontWeight.normal,
              color: isDarkMode ? Colors.black : Colors.white,
            ),
          ],
        ),
        duration: const Duration(seconds: 3),
        backgroundColor: isDarkMode ? Colors.white : Colors.black,
      ),
    );
  }

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
            title: MyText(
              text: errorText.isNotEmpty ? 'error occurred' : 'confirmation',
              color: errorText.isNotEmpty
                  ? Theme.of(context).colorScheme.error
                  : Theme.of(context).colorScheme.primary,
            ),
            content: MyText(
              text: errorText.isNotEmpty ? errorText : message,
              color: Colors.black,
            ),
            actions: <Widget>[
              MyButton(
                function: () {
                  context.router.popForced(true);
                  confirmFunction();
                },
                color: Theme.of(context).colorScheme.primary,
                child: MyText(
                  text: errorText.isNotEmpty ? 'okay' : 'confirm',
                  color: Colors.white,
                ),
              ),
              errorText.isNotEmpty
                  ? Container()
                  : MyButton(
                border: true,
                borderColor: Colors.black,
                function: () {
                  context.router.popForced(true);
                  exitDialogue();
                },
                color: Colors.white,
                child: const MyText(
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
