// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool obscureText;
  final String? Function(String?)? validator;
  final String hintText;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.label,
    required this.obscureText,
    this.validator,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
              fontSize: 16, color: Colors.grey, fontWeight: FontWeight.w400),
        ),
        const SizedBox(height: 4,),
        SizedBox(
          // height: 64,
          child: TextFormField(
            obscureText: obscureText,
            controller: controller,
            validator: validator,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(color: Colors.grey),
              focusedBorder: const OutlineInputBorder(borderSide: BorderSide.none),
              enabledBorder: const OutlineInputBorder(borderSide: BorderSide.none),
              errorBorder: const OutlineInputBorder(borderSide: BorderSide.none),
              focusedErrorBorder: const OutlineInputBorder(borderSide: BorderSide.none),
              filled: true,
              fillColor: Colors.grey.shade300
            ),
          ),
        ),
      ],
    );
  }
}
