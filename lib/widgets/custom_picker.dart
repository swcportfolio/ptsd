import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:vempire_app/data/picker_data.dart';
import 'package:vempire_app/utils/color.dart';


/// CustomPicker class
/// 나이, 교육정도, 동거 수, 사고 당시 속도, 종교, 차량 색상, 직업 picker
class CustomPicker{

  var tempData;

  /// BottomSheet Widget
  /// @param pickerModel : PickerModel
  showBottomSheet(PickerData pickerData){
    tempData  = pickerData.indexInitialValue;

    showModalBottomSheet(context: pickerData.context, builder: (context) {
      return Container(
        height: 250,
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 상단 버튼
            Padding(padding: const EdgeInsets.all(12.0),
                child: _rowBottomSheetTopBtn(context, pickerData.callback)
            ),

            // 하단 picker
            _commonCupertinoPicker(pickerData.indexInitialValue, pickerData.itemList)
          ],
        ),
      );
    });
  }

  /// BottomSheet 상단 버튼
  /// Row [ 취소, 확인 ]
  /// @param context : Widget position
  /// @param Function() : callback 함수 - picker 에서 선택된 데이터가 콜백 된다.
  /// @param selectedData  : 임시로 선택된 데이터 저장 변수
  /// @return : Row()
  _rowBottomSheetTopBtn(BuildContext context, Function(dynamic ageData) callback){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children:
      [
        TextButton(
          child: Text("취소", textScaleFactor: 1.0, style: TextStyle(color: mainColor, fontWeight: FontWeight.bold)),
          onPressed: ()
          {
            Navigator.pop(context);
            print('>>>> [bottomSheet 취소]');
          },
        ),

        TextButton(
          child: Text("확인", textScaleFactor: 1.0, style: TextStyle(color: mainColor, fontWeight: FontWeight.bold)),
          onPressed: ()
          {
            Navigator.pop(context);
            callback(tempData);
            print('>>>> [bottomSheet 확인] : $tempData' );
          },
        )
      ],
    );
  }

  /// BottomSheet picker
  /// @param indexInitialValue : 각 index 의 초기 값 [ ex) 나이 10살부터 .. indexInitialValue => 10 ]
  /// @param itemList : picker 에 뿌려줄  리스트
  /// @return Expanded()
  _commonCupertinoPicker(dynamic indexInitialValue, List<dynamic> itemList){
    return Expanded(
        child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                  child: Container(height: 160,
                      child: CupertinoPicker(
                          itemExtent: 30,
                          onSelectedItemChanged: (int index)
                          {
                            if(indexInitialValue is String){ // String List 일때
                              tempData = itemList[index];
                            }

                            else{  // int List 일때
                              tempData = index+indexInitialValue;
                            }
                           },
                          children: itemList.map((e) => Text('$e', textScaleFactor: 0.93)).toList())
                  ))])
    );
  }

}