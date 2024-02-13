
import 'package:flutter/material.dart';
import 'package:vempire_app/data/sign_grid_data.dart';
import 'package:vempire_app/validates/validate.dart';

import '../utils/edit_controller.dart';

/// 회원가입 유효성 확인 클래스
class SignValidate{

  static bool checkValidate(SignEdit _signEdit, GridViewData gridViewData, BuildContext context)
  {
    if(CheckValidate().validatePassword(_signEdit.passController.text, context) && // 패스워드

        CheckValidate().validateSamePassword(_signEdit.passController.text, _signEdit.pass2Controller.text, context) && // 패드워드 일치

        CheckValidate().validateName(_signEdit.nameController.text, context)&& // 이름

        CheckValidate().validateAge(_signEdit.ageController.text, context)&& // 나이

        CheckValidate().validateEducation(_signEdit.educationController.text, context)&& // 교육 연수

        CheckValidate().validateEmail(_signEdit.emailController.text, context) && // 이메일

        CheckValidate().validateFamiliesCnt(_signEdit.familiesCntController.text, gridViewData.familyYN, context)&& // 동거 수

        CheckValidate().validateJob(_signEdit.jobController.text, gridViewData.jobYN, context)&& // 직업

        CheckValidate().validateReligion(_signEdit.religionController.text, gridViewData.religionYN, context)){ // 종교

      return true; // 위 체크 내용이 true 경우
    }
    else
      return false; // 위 체크 내용이 false 경우
  }
}