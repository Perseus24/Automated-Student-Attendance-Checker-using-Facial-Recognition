import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/big_texts.dart';

class IconAndTextWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color textColor;
  final Color iconColor;
  double size;
  FontWeight fontWeight;
  IconAndTextWidget({Key? key,
    required this.icon,
    required this.text,
    required this.textColor,
    required this.iconColor,
    this.size = 16,
    this.fontWeight = FontWeight.w400}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: iconColor),
        SizedBox(width: 10,),
        BigText(text: text, color: textColor, size: size, fontWeight: fontWeight,)
      ],
    );
  }
}

