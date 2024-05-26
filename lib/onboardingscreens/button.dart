import 'package:converrto/globalfunctions.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key, required this.press, required this.buttonname, required this.color});

  final VoidCallback press;
  final String buttonname;
  final String color;

  @override
  Widget build(BuildContext context) {
    // return Padding(
    //   padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
    //   child: SizedBox(
    //     width: 90,
    //     height: 50,
    //     child: ElevatedButton(
    //       onPressed: press,
    //       style: ElevatedButton.styleFrom(
    //         backgroundColor: const Color(0xFF209FA6),
    //         shape: const RoundedRectangleBorder(
    //           borderRadius: BorderRadius.all(Radius.circular(10)),
    //         ),
    //       ),
    //       child: Text(buttonname,
    //           style: const TextStyle(
    //               fontSize: 16,
    //               color: Colors.white,
    //               fontWeight: FontWeight.w400)),
    //     ),
    //   ),
    // );
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
