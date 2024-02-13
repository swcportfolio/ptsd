import 'package:flutter/material.dart';
import 'package:vempire_app/data/body_default.dart';
import 'package:vempire_app/utils/constants.dart';
import 'package:vempire_app/widgets/popup_dialog.dart';
import '../utils/dio_client.dart';

/// 유효성 확인 클래스
class CheckValidate{

  /// 아이디 체크
  Future<bool> validateID(String value, BuildContext context) async {
    if(value.length < 6){
      PopUpDialog.dialog('아이디 확인', '아이디 6자 이상 작성해주세요.', context);
      return false;
    }

    else {
      DefaultStatus defaultStatus = await client.duplicatedId(value);
      if(defaultStatus.message == 'Success')
      {
        PopUpDialog.dialog('아이디 확인', MESSAGE_AVAILABLE_ID, context);
        return true;
      }

      else{
        PopUpDialog.dialog('아이디 확인', defaultStatus.message.toString(), context);
        return false;
      }
    }
  }

  /// 비밀번호 찾기 화면: 아이디 유효 체크
  bool validateFindID(String value, BuildContext context){
    if(value.isEmpty){
      PopUpDialog.dialog('아이디 확인', '아이디 작성바랍니다.', context);
      return false;
    }

    else if(value.length < 6){
      PopUpDialog.dialog('아이디 확인', '아이디 6자 이상 작성해주세요.', context);
      return false;
    }

    else{
      return true;
    }

  }

  /// 이메일 체크
  bool validateEmail(String value, BuildContext context){
    if(value.isEmpty) {
      PopUpDialog.dialog('이메일 확인', '이메일 작성바랍니다.', context);
      return false;
    }

    else {
      Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regExp = new RegExp(pattern.toString());

      if(!regExp.hasMatch(value)) {
        PopUpDialog.dialog('이메일 확인', '잘못된 이메일 형식입니다.', context);
        return false;
      }
      else
        return true;
    }
  }

  /// 비밀번호 체크
  bool validatePassword(String value, BuildContext context){
    if(value.isEmpty){
      PopUpDialog.dialog('비밀번호 확인', '비밀번호를 입력하세요.', context);
      return false;
    }
    else {
      String pattern = "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*\\W).{8,15}";
      RegExp regExp = new RegExp(pattern);

      if(!regExp.hasMatch(value)){
        PopUpDialog.dialog('비밀번호 확인', '특수,대소문자,숫자 포함 8자~15\n자로 입력하세요.', context);
        return false;
      }
      else{
        return true;
      }
    }
  }

  /// 비밀번호 일치 체크
  bool validateSamePassword(String value, String value2, BuildContext context){
    if(value != value2){
      PopUpDialog.dialog('비밀번호 확인', '비밀번호가 일치 하지 않습니다.', context);
      return false;
    }
    else
      return true;
  }

  /// 이름 체크
  bool validateName(String value, BuildContext context){
    if(value.isEmpty){
      PopUpDialog.dialog('이름 확인', '이름을 입력해주세요.', context);
      return false;
    }

    else if(value.length >10){
      PopUpDialog.dialog('이름 확인', '이름 10글자를 넘을 수 없습니다.', context);
      return false;
    }
    else
      return true;
  }

  /// 나이
  bool validateAge(String value, BuildContext context){
    // 사용하지 않는 코드 - 나이 필수 입력(x)
    // if(value.isNotEmpty){
    //   Etc.dialog('나이 확인', '10살부터 100살까지 사용가능합니다.', context);
    //   return false;
    // }else if(value.isNotEmpty &&  int.parse(value) > 100 ){
    //   Etc.dialog('나이 확인', '10살부터 100살까지 사용가능합니다.', context);
    //   return false;
    // }else
      return true;
  }

  /// 가족수
  bool validateFamiliesCnt(String value, String familyYN, BuildContext context){
    if(value.isEmpty && familyYN == '동거'){
      PopUpDialog.dialog('가족 수 확인', '같이 사는 가족의 수를 입력해 주세요', context);
      return false;
    }
    else
      return true;
  }

  // 교육연수
  bool validateEducation(String value, BuildContext context){
    // 사용하지 않는 코드 - 교육연수 필수(x)
    // if(value.isNotEmpty && int.parse(value) < 6){
    //   Etc.dialog('교육연수 확인', '교육은 최소 6년 이상이며 최대 30년\n을 넘을 수 없습니다.', context);
    //   return false;
    // }else if(value.isNotEmpty && int.parse(value) > 30){
    //   Etc.dialog('교육연수 확인', '교육은 최소 6년 이상이며 최대 30년\n을 넘을 수 없습니다.', context);
    //   return false;
    // }else
      return true;
  }

  /// 직업
  bool validateJob(String value, String jobYN, BuildContext context){
    if(value.isEmpty && jobYN == '유'){
      PopUpDialog.dialog('직업 확인', '직업을 선택해 주세요.', context);
      return false;
    }
    else
      return true;
  }

  /// 종교
  bool validateReligion(String value, String religionYN, BuildContext context){
    if(value.isEmpty && religionYN == '유'){
      PopUpDialog.dialog('종교 확인', '종교를 입력해주세요.', context);
      return false;
    }
    else
      return true;
  }

}