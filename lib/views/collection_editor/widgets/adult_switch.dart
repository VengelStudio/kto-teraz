import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdultSwitch extends StatelessWidget {
  final bool isForAdults;
  final bool readonly;
  final Function(bool) onChanged;

  AdultSwitch({
    required this.isForAdults,
    required this.readonly,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "18+",
          style: GoogleFonts.lato(),
        ),
        Switch(
          value: isForAdults,
          onChanged: readonly ? null : onChanged,
          activeColor: Theme.of(context).primaryColor,
        ),
      ],
    );
  }
}