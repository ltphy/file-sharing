import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart';

class RobotLocation {
  final double x0;
  final double y0;
  final double r0;

  RobotLocation({this.x0 = 0, this.y0 = 0, this.r0 = 0});
}

class ControlCommandReceiver extends ChangeNotifier {
  final RobotLocation robotLocation;

  ControlCommandReceiver({required this.robotLocation});

  bool loading = false;

  void updateLoading() {
    loading = !loading;
    notifyListeners();
  }

  Future<void> backwardLeft() async {
    updateLoading();
    // Matrix4 matrix = Matrix4.identity().getRotation()
    Matrix2 matrix = Matrix2.rotation(pi * 1 / 3);
    print('matrix $matrix');
    double phi = pi * 1 / 4;
    Vector2 a = Vector2(-sin(phi), (1 - cos(phi)));
    Vector2 b = Vector2.zero();

    Matrix2.solve(matrix, a, b);
    print('result: ${b.toString()}');
    await Future.delayed(Duration(seconds: 1));
    updateLoading();

    notifyListeners();
  }

  void backwardRight() {}

  void backward() {}

  void forward() {}

  void forwardLeft() {}

  void forwardRight() {}
}
