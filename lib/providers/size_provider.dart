import 'package:flutter/material.dart';

class SizeProvider extends ChangeNotifier {
  final double _bottomNavigationBarHeight = 70.0;

  double get bottomNavigationBarHeight => _bottomNavigationBarHeight;

}