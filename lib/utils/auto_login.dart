import 'package:flutter/material.dart';
import 'package:vempire_app/data/authorization.dart';
import 'package:vempire_app/data/auto_login_data.dart';
import 'package:vempire_app/page/checkup/checkup_main_page.dart';
import 'package:vempire_app/utils/frame.dart';
import 'package:vempire_app/utils/save_data.dart';

/// 자동로그인 클래스
class AutoLoginManager{
  SaveData _saveData = SaveData();

 void authLogin(AutoLoginData authLogData){

   Authorization().userID   = authLogData.loginEdit.idController.text;
   Authorization().password = authLogData.loginEdit.passController.text;
   Authorization().name     = authLogData.profile.name!;
   Authorization().email    = authLogData.profile.mail!;

    if(authLogData.isAutoLogin) {
      setSharedPreferencesData(); // 로그인 성공으로 자동로그인을 위한 id, password 저장
    }

   Navigator.pop(authLogData.context);
   Frame.doPagePush(authLogData.context, CheckUpMainPage()); // 검사 메뉴 화면으로 이동
  }

  /// save SharedPreferences
  /// saving user data through SharedPreferences
  void setSharedPreferencesData() {
    _saveData.setStringData('userID'   , Authorization().userID);
    _saveData.setStringData('password' , Authorization().password);
    _saveData.setStringData('name'     , Authorization().name);
    _saveData.setStringData('email'    , Authorization().email);
  }
}