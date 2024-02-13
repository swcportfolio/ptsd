
import 'package:flutter/material.dart';
import 'package:vempire_app/data/sign_grid_data.dart';
import 'package:vempire_app/utils/edit_controller.dart';
import 'package:vempire_app/validates/validate.dart';

/// 개인정보 변경 유효성 확인 클래스
class InfoChangeValidate{

  static bool checkValidate(SignEdit signEdit, GridViewData gridViewData, BuildContext context){
    if( CheckValidate().validateName(signEdit.nameController.text, context)&&

        CheckValidate().validateAge(signEdit.ageController.text, context)&&

        CheckValidate().validateEmail(signEdit.emailController.text, context) &&

        CheckValidate().validateFamiliesCnt(signEdit.familiesCntController.text, gridViewData.familyYN, context)&&

        CheckValidate().validateEducation(signEdit.educationController.text, context)&&

        CheckValidate().validateJob(signEdit.jobController.text, gridViewData.jobYN, context)&&

        CheckValidate().validateReligion(signEdit.religionController.text, gridViewData.religionYN, context))
    {
      return true; // 위 체크 내용이 true 경우
    }
    else{
      return false; // 위 체크 내용이 false 경우
    }
  }

}