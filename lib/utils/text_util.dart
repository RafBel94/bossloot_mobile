import 'package:flutter/material.dart';

class TextUtil extends StatelessWidget {
  final String text;
  final bool? isBold;
  final int? size;
  final Color? color;

  const TextUtil({super.key, required this.text, this.isBold, this.size, this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color ?? Colors.black,
        fontSize: size?.toDouble() ?? 15,
        fontWeight: isBold == true ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }
}