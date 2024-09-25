import 'package:flutter/material.dart';
import 'package:studio_partner_app/src/res/colors.dart';

class ReusableButton extends StatelessWidget {
  final void Function()? onPressed;
  final String? label;
  final double? radius;
  const ReusableButton({
    super.key,
    this.radius,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryBackgroundColor,
            padding: const EdgeInsets.symmetric(vertical: 13),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius ?? 90),
            ),
          ),
          onPressed: onPressed,
          child: Text(
            label!,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}