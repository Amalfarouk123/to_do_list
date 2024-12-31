import 'package:flutter/material.dart';

import '../constant/colors.dart';


class CustomGeneralButton extends StatelessWidget {
  const CustomGeneralButton({
    super.key,
    required this.onPressed,
    required this.name,
  });

  final Function() onPressed;
  final String name;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
     style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).primaryColor, // لون الخلفية
        foregroundColor: Colors.white, // لون النص
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.symmetric(vertical: 14.0), // للتحكم في الحشو
      ),
      onPressed: onPressed,
      child: Text(
        name,
        style: TextStyle(
          color: AppColors.titleApp,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }
}
