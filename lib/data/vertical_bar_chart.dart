import 'package:flutter/material.dart';

/// 가로형 차트 클래스
class  VerticalBarChart{
  final String yAxis;
  final int score;
  final Color barColor;

  VerticalBarChart({
    required this.yAxis,
    required this.score,
    required this.barColor
  });
}