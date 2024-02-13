
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:vempire_app/data/date_picker_data.dart';
import 'package:vempire_app/utils/color.dart';

/// Date Picker(날짜, 시간) class
/// 교통사고 평가화면에서 사용
class CustomDatePicker
{
  /// 사고 날짜 picker widget
  static buildAccidentTime(DatePickerData datePickerData){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
      [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 19, 0, 5),
          child: Text(datePickerData.headText, textScaleFactor:1.0, style: TextStyle(color:Colors.black, fontWeight: FontWeight.bold)),
        ),

        InkWell(
          onTap: (){
            FocusScope.of(datePickerData.context).unfocus();

            DatePicker.showTimePicker(datePickerData.context,
                showTitleActions: true,
                showSecondsColumn: false,
                onChanged: (date) {
                  print('>>>> [change] : $date');
                },
                onConfirm: (date) {
                  print('>>>> [confirm] : $date');
                  datePickerData.callback(date);
                },
                currentTime: DateTime.now(),
                locale: LocaleType.ko);
          },
          child: Container(
            alignment: Alignment.centerLeft, height: 47.0,
            decoration: BoxDecoration(border: Border.all(width: 1.0, color: Colors.grey), borderRadius: BorderRadius.all(Radius.circular(5.0))),
              child: Padding(padding: const EdgeInsets.all(8.0),
              child: Row(
                children:
                [
                  Padding(padding: const EdgeInsets.fromLTRB(3, 0, 16, 0),
                      child: Icon(datePickerData.iconData, color: mainColor)),

                  Text(datePickerData.hint, textScaleFactor: 0.8, style: TextStyle(color: datePickerData.hint == '사고 시간을 선택해 주세요.' ? Colors.grey : Colors.black)),
                ],
              ),
            ),
            ),
          ),
      ],
    );
  }


 /// 사고 날짜 Picker widget
 /// @param datePickerData
 static buildAccidentDate(DatePickerData datePickerData) {
   return Column(
     crossAxisAlignment: CrossAxisAlignment.start,
     children: [

       Padding(
         padding: const EdgeInsets.fromLTRB(0, 19, 0, 5),
         child: Text(datePickerData.headText, textScaleFactor: 1.0, style: TextStyle(color:Colors.black, fontWeight: FontWeight.bold)),
       ),
       InkWell(
         onTap: (){
           FocusScope.of(datePickerData.context).unfocus();
           DatePicker.showDatePicker(
               datePickerData.context,
               showTitleActions: true,
               minTime: DateTime(1900, 01, 01),
               maxTime: DateTime.now(),
               onChanged: (date) {
                 print('>>>> [change] : $date');
               },
               onConfirm: (date) {
                 print('>>>> [confirm] : $date');

                 datePickerData.callback(date);
               },
               currentTime: DateTime.now(),
               locale: LocaleType.ko);

         },
         child: Container(alignment: Alignment.centerLeft, height: 47.0,
           child: Padding(padding: const EdgeInsets.all(8.0),
             child: Row(
               children:
               [
                 Padding(padding: const EdgeInsets.fromLTRB(3, 0, 16, 0),
                     child: Icon(datePickerData.iconData, color: mainColor)),
                 Text(datePickerData.hint, textScaleFactor: 0.8, style: TextStyle(color: datePickerData.hint == '사고 날짜를 선택해 주세요.' ? Colors.grey : Colors.black)),
               ],
             ),
           ),
           decoration: BoxDecoration(border: Border.all( width: 1.0,color: Colors.grey), borderRadius: BorderRadius.all(Radius.circular(5.0)),
           ),
         ),
       )
     ],
   );
 }
}