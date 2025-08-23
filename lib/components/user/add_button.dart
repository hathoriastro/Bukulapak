import 'package:bukulapak/components/colors.dart';
import 'package:flutter/material.dart';

class IconButtonComponent extends StatelessWidget {
  final IconData icon; // Icon to be displayed
  final VoidCallback onPressed;
  final Color color; // Icon color
  final double size; // Icon size
  final double padding; // Padding to adjust the button size

  // Constructor
  const IconButtonComponent({
    Key? key,
    required this.icon,
    required this.onPressed,
    this.color = darkBlue,
    this.size = 30.0,
    this.padding = 154.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(
          horizontal: padding,
          vertical: padding / 2,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: lightBlue),
        ),
        backgroundColor: Colors.white
      ),
      child: Icon(
        icon,
        color: color,
        size: size,
      ),
    );
  }
}
