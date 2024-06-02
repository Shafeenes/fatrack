import 'package:flutter/material.dart';

void showAlertDialog(BuildContext context, String title, String message,
    List<Widget> actionList) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // Build the content of your dialog
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: actionList,
      );
    },
  );
}
