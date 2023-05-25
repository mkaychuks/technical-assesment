// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final void Function()? onTap;
  final String title;
  final Color color;
  const CustomButton({
    Key? key,
    this.onTap,
    required this.title,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color
        ),
        child: Center(
          child: Text(title, style: const TextStyle(color: Colors.white, fontSize: 18),),
        ),
      ),
    );
  }
}
