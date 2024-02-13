
import 'package:flutter/cupertino.dart';
import 'package:vempire_app/data/profile.dart';
import 'package:vempire_app/utils/edit_controller.dart';

/// 자동 로그인 데이터 클래스
class AutoLoginData{

  LoginEdit loginEdit;  // 로그인 edit data
  BuildContext context; // widget 위치
  bool isAutoLogin;     // 자동로그인 여부
  Profile profile;      // 프로필 데이터

  AutoLoginData(this.loginEdit, this.context, this.isAutoLogin, this.profile);

  @override
  String toString() {
    return 'AutoLoginData{loginEdit: $loginEdit, context: $context, isAutoLogin: $isAutoLogin, profile: $profile}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AutoLoginData &&
          runtimeType == other.runtimeType &&
          loginEdit == other.loginEdit &&
          context == other.context &&
          isAutoLogin == other.isAutoLogin &&
          profile == other.profile;

  @override
  int get hashCode =>
      loginEdit.hashCode ^
      context.hashCode ^
      isAutoLogin.hashCode ^
      profile.hashCode;
}