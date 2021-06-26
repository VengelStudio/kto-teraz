import 'package:flutter/material.dart';
import '../utils/players.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Winner extends Player {
  Winner({required int id, required Color color, required Image emoji})
      : super(id: id, color: color, emoji: emoji);
}
