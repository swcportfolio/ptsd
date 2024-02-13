import 'package:flutter/material.dart';

import 'package:vempire_app/data/picker_data.dart';
import 'package:vempire_app/utils/color.dart';
import 'package:vempire_app/utils/constants.dart';
import 'package:vempire_app/utils/etc.dart';
import 'package:vempire_app/widgets/custom_picker.dart';

/// 로그인 입력 란 Edit Widget
class LoginInputEdit extends StatelessWidget{

  final IconData iconData;
  final String hint;
  final String type;
  final TextEditingController controller;

  LoginInputEdit({required this.iconData, required this.hint, required this.controller, required this.type});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.centerLeft,
        height: 60.0,
        child: MediaQuery(
          data: Etc.getScaleFontSize(context, fontSize: 0.75),
          child: TextField(
            autofocus: false,
            obscureText: type == 'pass' ? true : false,
            controller: controller,
            keyboardType: TextInputType.text,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(border: OutlineInputBorder(borderRadius: const BorderRadius.all(const Radius.circular(1.0))),
                contentPadding: EdgeInsets.only(top: 14.0),
                prefixIcon: Icon(iconData, color: mainColor),
                hintText: hint,
                hintStyle: TextStyle(color: Colors.grey)
            ),
          ),
        )
    );
  }
}

/// 아이디, 이름, 이메일, 입력란 Edit Widget
class SignInputEdit extends StatelessWidget {

  final IconData iconData;
  final String hint;
  final String type;
  final String headText;
  final TextEditingController controller;

  SignInputEdit({required this.iconData, required this.hint, required this.controller, required this.type, required this.headText });

  @override
  Widget build(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
          child: Text(headText, textScaleFactor: 1.0, style: TextStyle( fontWeight: FontWeight.bold)),
        ),

        Container(
            alignment: Alignment.centerLeft,
            height: 60.0,
            child: MediaQuery(
              data: Etc.getScaleFontSize(context, fontSize: 0.7),
              child: TextField(
                autofocus: false,
                obscureText:type == 'pass' ? true : false,
                controller: controller,
                keyboardType: type == 'number' ? TextInputType.number : TextInputType.text,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: const BorderRadius.all(const Radius.circular(3.0))),
                    contentPadding: EdgeInsets.only(top: 0.0),
                    fillColor: Colors.red,
                    hoverColor: mainColor,
                    prefixIcon: Icon(iconData, color: mainColor),
                    hintText: hint,
                    hintStyle: TextStyle(color: Colors.grey)),
                onChanged: (text) {
                  if(text.contains(' ', 0)){ // 공백이 존재 할 경우 제거
                    controller..selection = Etc.removeSpaces(controller, text);
                  }
                },
              ),
            )
        )

      ],
    );
  }
}

/// 회원가입[나이, 교육정도] Number Picker Edit Widget
/// ignore: must_be_immutable
class SignSelectInputEdit extends StatelessWidget {

  final IconData iconData;
  final String hint;
  final String type;
  final String headText;
  final TextEditingController controller;

  SignSelectInputEdit({required this.iconData, required this.hint, required this.controller, required this.type, required this.headText });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
      [
        Padding(padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
          child: Text(headText, textScaleFactor: 1.0, style: TextStyle(fontWeight: FontWeight.bold)),
        ),

        Container(
            alignment: Alignment.centerLeft,
            height: 60.0,
            child: MediaQuery(
              data: Etc.getScaleFontSize(context, fontSize: 0.7),
              child: InkWell(
                onTap: ()=>
                {
                  FocusScope.of(context).unfocus(),

                  if(headText == '나이'){
                      CustomPicker().showBottomSheet(PickerData(PickerInitial.ageInitialVal, PickerItemList.ageItemList, context,
                              (callbackData)=>onGetPickerData(callbackData)))
                  }

                  else if(headText == '교육정도'){
                      CustomPicker().showBottomSheet(PickerData(PickerInitial.educationInitialVal, PickerItemList.educationItemList,
                          context, (callbackData)=>onGetPickerData(callbackData)))
                  },
                },
                child: TextField(
                  enabled: false,
                  autofocus: false,
                  obscureText: false,
                  controller: controller,
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      border: new OutlineInputBorder(borderRadius: const BorderRadius.all(const Radius.circular(3.0))),
                      contentPadding: EdgeInsets.only(top: 0.0),
                      fillColor: Colors.red,
                      hoverColor: mainColor,
                      prefixIcon: Icon(iconData, color: mainColor),
                      hintText: hint,
                      hintStyle: TextStyle(color: Colors.grey)
                  ),
                ),
              ),
            )
        )
      ],
    );
  }

  /// picker Function callback
  /// @param callbackData : 반환 값
  onGetPickerData(callbackData) {
    controller.text = callbackData.toString();
  }
}

/// 추가 입력 란 (GridView 선택 후) Edit Widget
/// 동거 수, 종교, 차량색상, 직업
class InputEdit extends StatelessWidget {

  final IconData? iconData;
  final String? hint;
  final String? type;
  final TextEditingController? controller;

  InputEdit({this.iconData, this.hint, this.controller , this.type});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
      {
        if(type == 'familiesCnt'){
          CustomPicker().showBottomSheet(PickerData(PickerInitial.familiesInitialVal, PickerItemList.familiesCntItemList, context,
                  (callbackData)=>onGetPickerData(callbackData)))
        }

        else if(type == 'religion'){
          CustomPicker().showBottomSheet(PickerData(PickerInitial.religionInitialVal, PickerItemList.religionItemList, context,
                  (callbackData)=>onGetPickerData(callbackData)))
        }

        else if(type == 'carColor'){
          CustomPicker().showBottomSheet(PickerData(PickerInitial.carColorInitialVal, PickerItemList.carColorItemList, context,
                  (callbackData)=>onGetPickerData(callbackData)))
        }

        else if(type == 'job'){
          CustomPicker().showBottomSheet(PickerData(PickerInitial.jobInitialVal, PickerItemList.jobItemList, context,
                  (callbackData)=>onGetPickerData(callbackData)))
        }
      },
      child: Container(
          height: 40.0,
          child: MediaQuery(
            data: Etc.getScaleFontSize(context, fontSize: 1.0),
            child: TextField(
              enabled: type == 'familiesCnt' || type == 'religion' || type == 'carColor' || type == 'job' ? false : true,
              controller: controller,
              keyboardType:type =='number' ? TextInputType.number : TextInputType.text,
              style: TextStyle(color: Colors.black, fontSize: 13),
              decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: const BorderRadius.all(const Radius.circular(5.0))),
                  contentPadding: EdgeInsets.only(top: 14.0),
                  fillColor: Colors.red,
                  hoverColor: mainColor,
                  prefixIcon: Icon(iconData, color: mainColor),
                  hintText: hint,
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 12)
              ),
            ),
          )
      ),
    );
  }

  /// picker Function callback
  /// @param callbackData : 반환 값
  onGetPickerData(callbackData) {
    controller?.text = callbackData.toString();
  }

}

/// 교통사고 정보 입력 [ 사고 장소 입력 ] Edit Widget
class AccidentSpaceInputEdit extends StatelessWidget {

  final IconData? iconData;
  final String? hint;
  final String? headText;
  final TextEditingController? controller;

  AccidentSpaceInputEdit({this.iconData, this.hint, this.controller, this.headText});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
      [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
          child: Text(headText!,textScaleFactor: 1.0, style: TextStyle(fontWeight: FontWeight.bold)),
        ),

        Container(
            alignment: Alignment.centerLeft,
            height: 60.0,
            child: MediaQuery(
              data: Etc.getScaleFontSize(context, fontSize: 0.7),
              child: TextField(
                autofocus: false,
                controller: controller,
                keyboardType: TextInputType.text,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    border: new OutlineInputBorder(borderRadius: const BorderRadius.all(const Radius.circular(5.0))),
                    contentPadding: EdgeInsets.only(top: 14.0),
                    fillColor: Colors.red,
                    hoverColor: mainColor,
                    prefixIcon: Icon(iconData, color: mainColor),
                    hintText: hint,
                    hintStyle: TextStyle(color: Colors.grey)
                ),
              ),
            )
        )
      ],
    );
  }
}

/// 아이디 찾기 [ 이메일, 이름 ] 입력 란 Edit Widget
class FindInputEdit extends StatelessWidget {

  final IconData? iconData;
  final String? hint;
  final String? headText;
  final TextEditingController? controller;

  FindInputEdit({this.iconData, this.hint, this.controller, this.headText});

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
      [
        Padding(padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
          child: Text(headText!, textScaleFactor: 1.0, style: TextStyle( fontWeight: FontWeight.bold)),
        ),

        Container(
            alignment: Alignment.centerLeft,
            height: 60.0,
            child: MediaQuery(
              data: Etc.getScaleFontSize(context, fontSize: 0.9),
              child: TextField(
                autofocus: false,
                controller: controller,
                keyboardType:TextInputType.text,
                decoration: InputDecoration(
                    border: new OutlineInputBorder(borderRadius: const BorderRadius.all(const Radius.circular(3.0))),
                    contentPadding: EdgeInsets.only(top: 0.0),
                    fillColor: Colors.red,
                    hoverColor: mainColor,
                    prefixIcon: Icon(iconData, color: mainColor),
                    hintText: hint,
                    hintStyle: TextStyle(color: Colors.grey)),
                onChanged: (text)=>
                {
                  if(text.contains(' ', 0)){ // 공백이 존재 할 경우 제거
                    controller!..selection = Etc.removeSpaces(controller!, text)
                  }
                }
              ),
            )
        )
      ],
    );
  }
}


