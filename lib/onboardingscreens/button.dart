import 'package:converrto/utils/globalfunctions.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key, required this.press, required this.buttonname, required this.color});

  final VoidCallback press;
  final String buttonname;
  final String color;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: GestureDetector(
          onTap: press,
          child: Text(
            buttonname,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: hexToColor(color),
                  fontWeight: FontWeight.w600,
                ),
          ),
        ));
  }
}
