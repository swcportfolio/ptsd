import 'package:flutter/material.dart';
import 'color.dart';

class Etc{

  /// 띄어쓰기 제거 후 텍스트 반환
  static TextSelection removeSpaces(TextEditingController controller, String text)
  {
    controller.text = controller.text.trim();
    return TextSelection.fromPosition(TextPosition(offset: text.length - 1));
  }


   /// SnackBar 메시지
  static showSnackBar(String meg, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            duration: Duration(milliseconds: 1000),
            backgroundColor:mainColor,
            content: Text(meg, textScaleFactor: 0.9)));
    }

  /// Default 라인
  static solidLine(BuildContext context){
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 1.0,
        color: lineColor,
      ),
    );
  }

  /// PTSD 라인
  static resultSolidLine(BuildContext context){
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 1.0,
        color: lineColor,
      ),
    );
  }

  /// Map<T> Print()
  static void getValuesFromMap(Map map) {
    print('-----Get values-----');
    map.values.forEach((value) {
      print(value);
    });
    print('------------------');
  }

  /// Text Font Scale
  static MediaQueryData getScaleFontSize(BuildContext context, {required double fontSize}){
    final mqData = MediaQuery.of(context);
    return mqData.copyWith(textScaleFactor: fontSize);
  }



}