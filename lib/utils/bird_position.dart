import 'package:flutter/material.dart';

class BirdPosition extends ChangeNotifier {
  double _position = 0;
  double get position => _position;

  changePosition(double pos) {
    _position = pos;
    notifyListeners();
  }

  changePositionListener(double pos) {
    _position = pos;
  }
}
