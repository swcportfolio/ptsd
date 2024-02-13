import 'package:flutter/material.dart';
import 'package:vempire_app/data/selected_grid_data.dart';
import 'package:vempire_app/data/sign_grid_data.dart';

/// Login editingController class
class LoginEdit
{
  TextEditingController idController   = TextEditingController(); // 아이디
  TextEditingController passController = TextEditingController(); // 비밀번호

  Map<String, dynamic> toMap() {
    Map<String, dynamic> toMap = {
      'userID'   : idController.text,
      'password' : passController.text,
    };
    return toMap;
  }
}

/// Sign editingController class
class SignEdit
{
  TextEditingController idController            = TextEditingController(); // 아이디
  TextEditingController passController          = TextEditingController(); // 비밀번호
  TextEditingController pass2Controller         = TextEditingController(); // 비밀번호 확인
  TextEditingController nameController          = TextEditingController(); // 이름
  TextEditingController ageController           = TextEditingController(); // 나이
  TextEditingController familiesCntController   = TextEditingController(); // 동거형태- 가족수
  TextEditingController jobController           = TextEditingController(); // 직업
  TextEditingController educationController     = TextEditingController(); // 교육정도
  TextEditingController religionController      = TextEditingController(); // 종교
  TextEditingController emailController         = TextEditingController(); // 이메일

  Map<String, dynamic> toMap(GridViewData signGrid) {
    Map<String, dynamic> toMap = {
      'userID'        : idController.text,
      'password'      : passController.text,
      'name'          : nameController.text,
      'mail'          : emailController.text,
      'age'           : ageController.text,
      'education'     : educationController.text,
      'gender'        : signGrid.gender,
      'married'       : signGrid.married ,
      'familyYN'      : signGrid.familyYN,
      'familiesCnt'   : familiesCntController.text,
      'jobYN'         : signGrid.jobYN,
      'jobName'       : jobController.text,
      'religionYN'    : signGrid.religionYN,
      'religionName'  : religionController.text,
    };

    return toMap;
  }
}

/// Accident evaluation editingController class
class AccidentEdit
{
  TextEditingController myCarColorController         = TextEditingController(); // 나의 자동차 색상
  TextEditingController opponentCarColorController   = TextEditingController(); // 상대 자동차 색상
  TextEditingController dateController               = TextEditingController(); // 사고 날짜
  TextEditingController spaceController              = TextEditingController(); // 장소
  TextEditingController timeController               = TextEditingController(); // 시간
  TextEditingController speedController              = TextEditingController(); // 속도


  Map<String, dynamic> toMap(String userID, SelectedGridData selectedGridData) {
    Map<String, dynamic> toMap = {
      'userID'          : userID,
      'accidentType'    : selectedGridData.accidentType,
      'carType'         : selectedGridData.carType,
      'carColor'        : myCarColorController.text,
      'opponentCarType' : selectedGridData.opponentCarType,
      'opponentCarColor': opponentCarColorController.text,
      'accidentDate'    : dateController.text ,
      'place'           : spaceController.text ,
      'weather'         : selectedGridData.weather,
      'direction'       : selectedGridData.direction,
      'speed'           : speedController.text,
      'accidentTime'    : timeController.text,
      'admissionYN'     : selectedGridData.admissionYN,
      'hurtHeadYN'      : selectedGridData.hurtHeadYN,
      'memoryYN'        : selectedGridData.memoryYN,
      'legalMatterYN'   : selectedGridData.legalMatterYN,
    };

    return toMap;
  }
}

/// password change editingController class
class PasswordEdit
{
  TextEditingController beforePassController  = TextEditingController(); // 현재 비밀번호
  TextEditingController newPassController     = TextEditingController(); // 새 비밀번호
  TextEditingController newPass2Controller    = TextEditingController(); // 새 비밀번호 확인

  Map<String, dynamic> toMap(String userID) {
    Map<String, dynamic> toMap =
    {
      'userID'      : userID,
      'password'    : beforePassController.text,
      'npassword'   : newPass2Controller.text,
    };

    return toMap;
  }
}