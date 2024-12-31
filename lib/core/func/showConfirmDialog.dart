import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/core/constant/colors.dart';

showConfirmDialog(BuildContext context, String title, String message) {
  showCupertinoDialog(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: Text(
        '$title',
        style: TextStyle(fontSize: 25, color: AppColors.primary),
      ),
      content: Text(
        '$message',
        style: TextStyle(fontSize: 16),
      ),
      actions: <Widget>[
        CupertinoDialogAction(
          child: Text(
            'موافق',
            style: TextStyle(color: AppColors.primary),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    ),
  );
}
