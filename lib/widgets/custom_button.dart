import 'package:flutter/material.dart';
import 'package:hci/constants/colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool isOutlined;
  final bool isFullWidth;
  final Color? backgroundColor;
  final Color? textColor;
  final double height;
  final IconData? prefixIcon;
  final IconData? suffixIcon;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.isOutlined = false,
    this.isFullWidth = true,
    this.backgroundColor,
    this.textColor,
    this.height = 56,
    this.prefixIcon,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isOutlined
              ? Colors.transparent
              : (backgroundColor ?? AppColors.primary),
          foregroundColor: isOutlined
              ? (textColor ?? AppColors.primary)
              : (textColor ?? Colors.white),
          elevation: isOutlined ? 0 : 1,
          side: isOutlined
              ? BorderSide(color: textColor ?? AppColors.primary)
              : null,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (prefixIcon != null) ...[
                    Icon(prefixIcon),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    text,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (suffixIcon != null) ...[
                    const SizedBox(width: 8),
                    Icon(suffixIcon),
                  ],
                ],
              ),
      ),
    );
  }
}
