import 'package:flutter/material.dart';
import 'package:hci/constants/colors.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final String? hint;
  final TextEditingController controller;
  final bool isPassword;
  final String? errorText;
  final TextInputType keyboardType;
  final bool isEnabled;
  final String? example;
  final IconData? prefixIcon;
  final Widget? suffixWidget;
  final VoidCallback? onTap;
  final Function(String)? onChanged;

  const CustomTextField({
    super.key,
    required this.label,
    this.hint,
    required this.controller,
    this.isPassword = false,
    this.errorText,
    this.keyboardType = TextInputType.text,
    this.isEnabled = true,
    this.example,
    this.prefixIcon,
    this.suffixWidget,
    this.onTap,
    this.onChanged,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.text,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: widget.controller,
          obscureText: widget.isPassword && _obscureText,
          keyboardType: widget.keyboardType,
          enabled: widget.isEnabled,
          onTap: widget.onTap,
          onChanged: widget.onChanged,
          decoration: InputDecoration(
            hintText: widget.hint,
            errorText: widget.errorText,
            prefixIcon: widget.prefixIcon != null
                ? Icon(widget.prefixIcon, color: AppColors.textLight)
                : null,
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                      color: AppColors.textLight,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  )
                : widget.suffixWidget,
          ),
        ),
        if (widget.example != null) ...[
          const SizedBox(height: 4),
          Text(
            widget.example!,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textVeryLight,
            ),
          ),
        ],
      ],
    );
  }
}
