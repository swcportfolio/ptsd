
import 'package:flutter/cupertino.dart';

/// Custom picker data class
class DatePickerData{

  String headText;       // title
  IconData iconData;     // icon
  String hint;           // inputText hint
  BuildContext context;  // widget position
  Function(dynamic data) callback; // callback 함수 -Date picker 에서 선택된 데이터가 콜백 된다.

  DatePickerData(this.headText, this.iconData, this.hint, this.context, this.callback);
}