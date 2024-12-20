import 'package:flutter/material.dart';

Widget myButton({
  required Widget child,
  required void Function()? onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        borderRadius: BorderRadius.circular(50),
        boxShadow: <BoxShadow>[
          BoxShadow(
            blurRadius: 4,
            spreadRadius: 3,
            color: Colors.grey.shade600,
          ),
        ],
      ),
      child: child,
    ),
  );
}
