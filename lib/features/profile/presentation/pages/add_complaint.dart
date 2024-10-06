import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

@RoutePage()
class AddComplaint extends StatelessWidget {
  const AddComplaint({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
    Theme.of(context).brightness == Brightness.dark ? true : false;
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Theme.of(context).colorScheme.surface,
        statusBarBrightness: isDarkMode ? Brightness.dark : Brightness.light,
        statusBarIconBrightness:
        isDarkMode ? Brightness.light : Brightness.dark,
      ),
    );
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.green,
      ),
    );
  }
}
