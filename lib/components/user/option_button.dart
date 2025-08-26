import 'package:bukulapak/components/colors.dart';
import 'package:flutter/material.dart';

class OptionButton extends StatefulWidget {
  final String option1;
  final String option2;
  final String option3;
  final String option4;
  final Function(String)? onChanged; // << tambahan callback

  const OptionButton({
    Key? key,
    required this.option1,
    required this.option2,
    this.option3 = '',
    this.option4 = '',
    this.onChanged, // << bisa null kalau ga dipakai
  }) : super(key: key);

  @override
  _OptionButtonState createState() => _OptionButtonState();
}

class _OptionButtonState extends State<OptionButton> {
  String _selectedOption = 'Pilih Opsi';

  void _onOptionSelected(String option) {
    setState(() {
      _selectedOption = option;
    });
    if (widget.onChanged != null) {
      widget.onChanged!(option); // << panggil callback ke parent
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return PopupMenuButton<String>(
      onSelected: _onOptionSelected,
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem<String>(
            value: widget.option1,
            child: Text(widget.option1),
          ),
          PopupMenuItem<String>(
            value: widget.option2,
            child: Text(widget.option2),
          ),
          if (widget.option3.isNotEmpty)
            PopupMenuItem<String>(
              value: widget.option3,
              child: Text(widget.option3),
            ),
          if (widget.option4.isNotEmpty)
            PopupMenuItem<String>(
              value: widget.option4,
              child: Text(widget.option4),
            ),
        ];
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.06,
          vertical: screenHeight * 0.01,
        ),
        decoration: BoxDecoration(
          color: darkWhite,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.transparent),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _selectedOption,
              style: TextStyle(
                fontFamily: 'poppins',
                color: Colors.black54,
                fontSize: screenWidth * 0.03,
              ),
            ),
            Icon(Icons.arrow_drop_down, color: Colors.black54),
          ],
        ),
      ),
    );
  }
}
