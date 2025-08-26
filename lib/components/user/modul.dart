import 'package:flutter/material.dart';

class AppBarModul extends StatefulWidget {
  final String titleModul;
  AppBarModul({super.key,
  required this.titleModul});

  @override
  State<AppBarModul> createState() => _AppBarModulState();
}

class _AppBarModulState extends State<AppBarModul> {
  @override
  Widget build(BuildContext context) {
     final size = MediaQuery.of(context).size;
    final sizewidth = size.width;
    final sizeheight = size.height;
    final fullheight = 956;
    final fullwidth = 440;
    return AppBar(
      backgroundColor: Colors.white,
        toolbarHeight: sizeheight * 112 / fullheight,
        elevation: 4,
        shadowColor: Colors.grey.withOpacity(0.5),
        surfaceTintColor: Colors.transparent,
      leading: 
        GestureDetector(
                  onTap: () {
                    Navigator.pop(
                      context
                    );
                  },
                  child: Icon(Icons.arrow_back),
                ),
      title: Text(widget.titleModul, style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),),
    );
  }
}