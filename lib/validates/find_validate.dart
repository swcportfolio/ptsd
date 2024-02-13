
import 'package:flutter/material.dart';
import 'package:vempire_app/data/body_default.dart';
import 'package:vempire_app/page/login/find_result_page.dart';
import 'package:vempire_app/utils/constants.dart';
import 'package:vempire_app/utils/etc.dart';
import 'package:vempire_app/utils/frame.dart';
import 'package:vempire_app/validates/validate.dart';
import 'package:vempire_app/widgets/popup_dialog.dart';

/// 아이디, 비밀번호 유효성 확인 클래스
class FindValidate{

  /// 아이디 찾기 - 이메일, 이름 확인
  static bool checkIDValidate(String email, String name,  BuildContext context)
  {
    if(CheckValidate().validateEmail(email, context)&& // 이메일
    CheckValidate().validateName(name, context)){      // 이름
      return true; // 위 체크 내용이 true 경우
    }
    else
      return false; // 위 체크 내용이 false 경우
  }

  /// 아이디찾기 : 서버로부터 받은 결과 유효성 확인
  static void resultIDValidate(DefaultStatus defaultStatus, String email, BuildContext context)
  {
    if (defaultStatus.code == 'INFO_FIND_ID'){
      Navigator.pop(context);
      Frame.doPagePush(context, FindResultPage(mailText: email)); // 아이디 찾기 메일전송 완료 화면 이동
    }

    else if(defaultStatus.code == 'INFO_NOT_FIND_ID'){
      PopUpDialog.dialog('아이디 찾기 오류', defaultStatus.message.toString(), context);
    }

    else{
      PopUpDialog.dialog('다시 시도 바랍니다.', defaultStatus.message.toString(), context);
    }
  }


  /// 비밀번호 찾기 - 아이디, 이메일, 이름 확인
  static bool checkPassValidate(String userID, String email, String name,  BuildContext context)
  {
    if(CheckValidate().validateFindID(userID, context)&&  // ID
        CheckValidate().validateEmail(email, context)&&   // 이메일
        CheckValidate().validateName(name, context)){     // 이름
      return true; // 위 체크 내용이 true 경우
    }
    else
      return false; // 위 체크 내용이 false 경우
  }

  /// 비밀번호 찾기 : 서버로부터 받은 결과 메시지 확인
  static void resultPassValidate(DefaultStatus defaultStatus, String email, BuildContext context)
  {
    if (defaultStatus.code == '201'){
      Navigator.pop(context);
      Frame.doPagePush(context, FindResultPage(mailText: email)); // 비밀번호 찾기 메일전송 완료 화면 이동
    }

    else if (defaultStatus.code == 'INFO_NOT_FIND_ID'){
      Etc.showSnackBar(FIND_PASS_ID_NOT_MATCH, context);
    }

    else{
      PopUpDialog.dialog('다시 시도 바랍니다.', defaultStatus.message.toString(), context);
    }
  }
}