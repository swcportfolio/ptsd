import 'package:flutter/material.dart';
import 'package:vempire_app/data/authorization.dart';
import 'package:vempire_app/data/auto_login_data.dart';
import 'package:vempire_app/data/body_default.dart';
import 'package:vempire_app/data/profile.dart';
import 'package:vempire_app/data/selected_grid_data.dart';
import 'package:vempire_app/data/sign_grid_data.dart';
import 'package:vempire_app/page/checkup/accident_evaluation_page.dart';
import 'package:vempire_app/page/checkup/before_%20accident_evaluation_page.dart';
import 'package:vempire_app/page/checkup/checkup_main_page.dart';
import 'package:vempire_app/page/checkup/ptsd_chat_page.dart';
import 'package:vempire_app/page/login/login_page.dart';
import 'package:vempire_app/page/login/signup_page.dart';
import 'package:vempire_app/page/main/find_out_page.dart';
import 'package:vempire_app/page/main/healing_page.dart';
import 'package:vempire_app/page/main/main_page.dart';
import 'package:vempire_app/page/result/result_list_page.dart';
import 'package:vempire_app/utils/auto_login.dart';
import 'package:vempire_app/utils/color.dart';
import 'package:vempire_app/utils/constants.dart';
import 'package:vempire_app/utils/dio_client.dart';
import 'package:vempire_app/utils/edit_controller.dart';
import 'package:vempire_app/utils/etc.dart';
import 'package:vempire_app/utils/frame.dart';
import 'package:vempire_app/utils/save_data.dart';
import 'package:vempire_app/validates/accident_validate.dart';
import 'package:vempire_app/validates/find_validate.dart';
import 'package:vempire_app/validates/info_change_validate.dart';
import 'package:vempire_app/validates/sign_validate.dart';
import 'package:vempire_app/validates/validate.dart';

import 'popup_dialog.dart';

/// 로그인 버튼
class LoginButton extends StatelessWidget {

  final LoginEdit loginEdit;  // 로그인 TextEditingController.text Data
  final bool isAutoLogin;     // 자동로그인 활성화 \ 비활성화
  LoginButton({required this.loginEdit, required this.isAutoLogin});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
        width: double.infinity,
        child:  ElevatedButton(
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(1.0)),
              backgroundColor: mainColor,
              padding: EdgeInsets.all(17.0),
              elevation: 5.0,
            ),
            onPressed: () { _checkLogin(context); },
            child: Text('로그인',textScaleFactor: 1.1, style: TextStyle(color: Colors.white, letterSpacing: 1.2))),
        );
  }

  /// 로그인 확인
  void _checkLogin(BuildContext context) async
  {
    if (loginEdit.idController.text.isEmpty || loginEdit.passController.text.isEmpty) {
      Etc.showSnackBar('아이디 또는 패스워드를 입력하세요.', context);
    }

    else {
      try{
        DefaultStatus loginStatus = await client.dioLogin(loginEdit.toMap());

        if (loginStatus.message == 'Success'){
          _checkUserData(loginEdit, context); // 로그인 유저 데이터 가져오기
        }

        else if(loginStatus.message == MESSAGE_LOGIN_FALSE){
          Etc.showSnackBar(MESSAGE_CHECK_ID_PASS, context);
        }

        else {
          Etc.showSnackBar(MESSAGE_SERVER_ERROR_DEFAULT, context);
        }
      }
      catch (e) {
        Etc.showSnackBar(e.toString().replaceFirst('error : ', ''), context);
      }
    }
  }

  /// 로그인 유저 데이터 확인
  void _checkUserData(LoginEdit loginEdit , BuildContext context) async
  {
    AutoLoginManager autoLoginManager = AutoLoginManager();
    Profile profile = Profile();

    try{
      profile = await client.getUserData(loginEdit.idController.text);

      if(profile.message == 'Success') {
        autoLoginManager.authLogin(AutoLoginData(loginEdit, context, isAutoLogin, profile));
      }

      else if(profile.message == MESSAGE_NOT_EXIST_RESULT) {
        Etc.showSnackBar(MESSAGE_NOT_EXIST_RESULT, context);
      }

      else{
        Etc.showSnackBar(MESSAGE_SERVER_ERROR_DEFAULT, context);
      }
    }
    catch (e) {
      Etc.showSnackBar(e.toString().replaceFirst('error : ', ''), context);
    }

  }
}


/// 회원가입 버튼
class SignButton extends StatelessWidget
{

  final String text;                // 버튼 이름
  final SignEdit signEdit;          // 회원가입 TextEditingController.text Data
  final VoidCallback signResultMsg; // 회원가입 완료 CallBack Function
  final bool isPossibleID;          // 중복 체크 여부
  final GridViewData gridViewData;  // 선택한 gridview data
  SignButton({required this.text, required this.signEdit , required this.signResultMsg, required this.isPossibleID, required this.gridViewData});

  @override
  Widget build(BuildContext context) {
      return  Container(
            padding: EdgeInsets.only(top: 20.0, right: 0.0, left: 0.0, bottom: 10.0),
            width: double.infinity,
            child: ElevatedButton(
                style:TextButton.styleFrom(backgroundColor: mainColor,
                  padding: EdgeInsets.all(17.0),
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(1.0)),
                ),
                onPressed: () {
                  if(_checkSign(context)){
                    _doSignUp(context);
                  }
                },
                child: Text(text, textScaleFactor:1.0, style: TextStyle(color: Colors.white, letterSpacing: 1.5, fontWeight: FontWeight.bold))));
      }

  /// 회원가입 유효성 체크
  bool _checkSign(BuildContext context)
  {
    if(isPossibleID) {
      return SignValidate.checkValidate(signEdit, gridViewData, context);
    }

    else{
      PopUpDialog.dialog('아이디 확인', '아이디 중복체크 확인바랍니다.', context);
      return false;
    }
  }

  /// 회원정보 서버로 insert
  _doSignUp(BuildContext context) async {
    try {
      DefaultStatus defaultStatus = await client.dioSign(signEdit.toMap(gridViewData)); // 서버로 회원가입

      if (defaultStatus.message == 'Success') {
        Navigator.pop(context);
        signResultMsg(); // 회원가입 완료 CallBack Function
      }

      else if (defaultStatus.message == '계정 중복') {
        PopUpDialog.dialog('계정중복', '계정 중복 체크 필요합니다.', context);
      }

      else {
        Etc.showSnackBar(MESSAGE_SERVER_ERROR_DEFAULT, context);
      }

    } catch (e) {
      Etc.showSnackBar(e.toString(), context);
    }
  }
}

/// 신규 사고 평가 완료 버튼
class EvaluationButton extends StatelessWidget {

  final String text;
  final AccidentEdit accidentEdit;
  final SelectedGridData selectedGridData;
  final BuildContext context;

  EvaluationButton({required this.text, required this.selectedGridData, required this.accidentEdit, required this.context});

  @override
  Widget build(BuildContext context) {

    return  Container(
        padding: EdgeInsets.only(top: 20.0, right: 0.0, left: 0.0, bottom: 10.0),
        width: double.infinity,
        child: ElevatedButton(
            style:TextButton.styleFrom(
              backgroundColor: mainColor,
              padding: EdgeInsets.all(17.0),
              elevation: 5.0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.0)),
            ),
            onPressed: () async {
              if(AccidentValidate.checkAccidentValue(accidentEdit, selectedGridData, context)) {
                _doEvaluation();
              }
            },
            child: Text(text, textScaleFactor: 1.1, style: TextStyle(color: Colors.white, letterSpacing: 1.5, fontWeight: FontWeight.bold))));
  }

  /// 사고 정보 insert
  void _doEvaluation() async
  {
    int accidentIdx = await client.dioEvaluation(accidentEdit.toMap(Authorization().userID, selectedGridData));

    if(accidentIdx != null){
      print('>>>> [accidentIdx] : $accidentIdx');
      Navigator.pop(context);
      Frame.doPagePush(context, PTSDChatPage(accidentIdx: accidentIdx));
    }

    else if(accidentIdx == -1){
      Etc.showSnackBar(MESSAGE_INSERT_FAILURE, context);
    }

    else {
      Etc.showSnackBar(MESSAGE_SERVER_ERROR_DEFAULT, context);
    }
  }
}

/// 이용약관 완료 버튼
class TermsButton extends StatelessWidget {

  final String btnName;
  final List<bool> agree;
  final VoidCallback signResultMsg;  // 회원가입 완료 CallBack Function
  final bool isAgree = true;
  TermsButton({ required this.btnName, required this.agree, required this.signResultMsg});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 60,
        child: Padding(padding: EdgeInsets.all(4.0),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(elevation: 2, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2.0)), primary: mainColor),
              onPressed: ()
              {
                if(agree[1] == false || agree[2] == false){
                  Etc.showSnackBar('모두 동의 바랍니다.', context);
                }
                else{
                  Navigator.pop(context); // 이용약관 pop
                  Frame.doPagePush(context, SignUpPage(signResultMsg: ()=> signResultMsg()));  // 회원가입 화면이동
               }
              },
              child: Text(btnName, textScaleFactor: 1.1,style: TextStyle(color: Colors.white, letterSpacing: 1.5, fontWeight: FontWeight.bold))),
        ));
  }
}


/// 패스워드 변경 버튼
class PassChangeButton extends StatelessWidget {

  final btnName;
  final PasswordEdit passwordEdit;
  final BuildContext context;
  PassChangeButton(this.btnName, this.passwordEdit, this.context);

  final _checkValidate = CheckValidate();

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.0)),
                primary: mainColor
            ),
            onPressed: ()
            {
              _checkInputValue();
            },
            child: Text(btnName, textScaleFactor: 1.1, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))));
  }

  /// 비밀번호 변경 데이터 체크
  void _checkInputValue() {
    if(passwordEdit.beforePassController.text.isEmpty){
      PopUpDialog.dialog('비밀번호 확인', '현재 비밀번호란이 비어있습니다.', context);
    }
    else if(Authorization().password != passwordEdit.beforePassController.text){
      PopUpDialog.dialog('비밀번호 확인', '현재 비밀번호가 틀립니다.', context);
    }
    else if(passwordEdit.newPassController.text.isEmpty || passwordEdit.newPass2Controller.text.isEmpty){
      PopUpDialog.dialog('새 비밀번호 확인', '새 비밀번호가 비어있습니다.', context);
    }
    else if(passwordEdit.newPassController.text != passwordEdit.newPass2Controller.text) {
      PopUpDialog.dialog('새 비밀번호 확인', '새 비밀번호가 다릅니다.', context);
    }
    else if(!_checkValidate.validatePassword(passwordEdit.newPassController.text, context)){
    }else{
      print('비밀번호 변경!!');
      logoutDialog('비밀번호 변경', context);
    }
  }

  /// 비밀번호 변경 후 show Dialog
  logoutDialog(String title, BuildContext mainContext) {
    return showDialog(context: mainContext, barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            title:Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.check_circle_outline,color: mainColor,),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text('비밀번호 변경', textScaleFactor: 0.85, style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
            content:Padding(
              padding: const EdgeInsets.fromLTRB(40, 12, 0, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('비밀번호 변경 시 재로그인이 필요합니다', textScaleFactor: 0.8, style: TextStyle(color: Colors.red)),
                ],
              ),
            ),
            contentPadding:EdgeInsets.fromLTRB(0.0, 0.0, 0.0,0.0),
            actions: <Widget>
            [
              TextButton(
                child: new Text("취소", textScaleFactor:1),
                onPressed: () {  Navigator.pop(context); },
              ),

              TextButton (
                child: new Text("확인", textScaleFactor:1),
                onPressed: () async
                {
                  DefaultStatus defaultStatus = await client.passUpdateDio(passwordEdit.toMap(Authorization().userID));
                  if(defaultStatus.code == '200')
                  {
                    Etc.showSnackBar('비밀번호가 변경되었습니다.', context);
                    deleteSaveData();
                    Authorization().clean();
                    Frame.doPageAndRemoveUntil(context, MainPage());
                  }

                  else if(defaultStatus.code == 'ERR_MS_6002'){
                    Etc.showSnackBar(MESSAGE_UPDATE_FAILURE, context);
                  }

                  else {
                    Etc.showSnackBar(MESSAGE_SERVER_ERROR_DEFAULT, context);
                  }
                },
              ),
            ],
          );
        });
  }

  /// 앱 SharedPreferences data 삭제
  void deleteSaveData() {
    SaveData _saveData = SaveData();
    _saveData.remove('userID');
    _saveData.remove('password');
  }

}

/// 회원정보 업데이트 버튼
class UpdateButton extends StatelessWidget {

  final String text;
  final GridViewData signGrid;
  final SignEdit signEdit;
  final VoidCallback? callback;
  UpdateButton({required this.text, required this.signGrid, required this.signEdit , this.callback});

  @override
  Widget build(BuildContext context) {
    return  Container(
        padding: EdgeInsets.only(top: 20.0, right: 0.0, left: 0.0, bottom: 10.0),
        width: double.infinity,
        child: ElevatedButton(
            style:TextButton.styleFrom(backgroundColor: mainColor,
              padding: EdgeInsets.all(17.0),
              elevation: 5.0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(1.0)),
            ),
            onPressed: (){
              if(InfoChangeValidate.checkValidate(signEdit, signGrid, context)) {
                Etc.getValuesFromMap(signEdit.toMap(signGrid));
                _updateDialog('개인정보 수정', '개인정보 수정 하시겠습니까?', context);
              }
             },
            child: Text(text, textScaleFactor:1.0, style: TextStyle( color: Colors.white, letterSpacing: 1.5, fontWeight: FontWeight.bold))));
  }

  /// 개인정보 업데이트 dialog
  _updateDialog(String headText, String text, BuildContext mainContext) {
    return showDialog(context: mainContext, barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            title:Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.check_circle_outline, color: mainColor,),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(headText, textScaleFactor: 0.8, style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
            content:Padding(padding: const EdgeInsets.fromLTRB(40, 12, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(text, textScaleFactor: 0.85, style: TextStyle(color: Colors.black)),
                ],
              ),
            ),
            contentPadding:EdgeInsets.fromLTRB(0.0, 0.0, 0.0,0.0),
            actions: [
              TextButton (
                child: new Text("취소", textScaleFactor: 1),
                onPressed: () async {
                  Navigator.pop(context);
                },
              ),

              TextButton (
                child: new Text("확인", textScaleFactor: 1),
                onPressed: () async {
                  _doUpdate(context);
                },
              ),
            ],
          );
        });
  }

  /// 수정된 개인정보 업데이트
  _doUpdate(BuildContext context) async
  {
    DefaultStatus defaultStatus = await client.dioUpdate(signEdit.toMap(signGrid));

    if (defaultStatus.code == '200'){
      Navigator.pop(context); // showDialog pop
      Navigator.pop(context); // 개인정보 수정 메인 화면 pop
      Etc.showSnackBar('회원 정보 수정이 완료되었습니다.', context);
    }
    else{
      Etc.showSnackBar(MESSAGE_UPDATE_FAILURE, context);
    }
  }
}

/// Id , Password 찾기 버튼
class CheckButton extends StatelessWidget {

  final String text;
  final TextEditingController? emailController;
  final TextEditingController? nameController;
  final TextEditingController? idController;
  CheckButton({required this.text, this.emailController, this.nameController,this.idController});

  @override
  Widget build(BuildContext context) {
    return  Container(
        padding: EdgeInsets.only(top: 20.0, right: 0.0, left: 0.0, bottom: 10.0),
        width: double.infinity,
        child: ElevatedButton(
            style:TextButton.styleFrom(backgroundColor: mainColor,
              padding: EdgeInsets.all(17.0),
              elevation: 5.0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(1.0)),
            ),
            onPressed: () async
            {
              /// 결과페이지 버튼
              if(text == '확인') {
                Navigator.pop(context);
              }

              /// 아이디 찾기
              else if(text == '아이디 찾기'){
               if(FindValidate.checkIDValidate(emailController!.text, nameController!.text, context))
               {
                  DefaultStatus defaultStatus = await client.findIDDio(nameController!.text, emailController!.text);
                  FindValidate.resultIDValidate(defaultStatus, emailController!.text, context); // 결과 값 확인
               }
               else{
                 print('>>>> [FindValidate.checkIDValidate] : false');
               }
              }

              /// 비밀번호 찾기
              else {
                if(FindValidate.checkPassValidate(idController!.text, emailController!.text, nameController!.text, context))
                {
                   DefaultStatus defaultStatus = await client.findPassDio(idController!.text, nameController!.text.toString(), emailController!.text.toString());
                   FindValidate.resultPassValidate(defaultStatus, emailController!.text, context);
                 }
                else{
                  print('>>>> [FindValidate.checkPassValidate] : false');
                }
               }

            },
            child: Text(text, textScaleFactor: 1.0, style: TextStyle(color: Colors.white, letterSpacing: 1.5, fontWeight: FontWeight.bold))));
  }
}

/// ptsd 사고평가 이전화면의 새로시작하기 화면 버튼
class PTSTNewButton extends StatelessWidget{

  final String text;
  PTSTNewButton({required this.text});

  @override
  Widget build(BuildContext context){
    return  Container(
        padding: EdgeInsets.only(top: 20.0, right: 0.0, left: 0.0, bottom: 10.0),
        width: double.infinity,
        child: ElevatedButton(
            style:TextButton.styleFrom(backgroundColor: mainColor,
              padding: EdgeInsets.all(17.0),
              elevation: 5.0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(1.0)),
            ),
            onPressed: ()
            {
              Navigator.pop(context); // 사고이력 화면 pop
              Frame.doPagePush(context, EvaluationPage()); // 신규 사고 평가 화면으로 이동
            },
            child: Text(text, textScaleFactor:1.0, style: TextStyle(color: Colors.white, letterSpacing: 1.5, fontWeight: FontWeight.bold))));
  }
}

/// ptsd 사고평가 이전화면의 검사시작버튼
class PTSTBeforeButton extends StatelessWidget {

  final String accidentIdx;
  final String text;
  PTSTBeforeButton({required this.accidentIdx, required this.text});

  @override
  Widget build(BuildContext context) {
    return  Container(
        padding: EdgeInsets.only(top: 20.0, right: 0.0, left: 0.0, bottom: 10.0),
        width: double.infinity,
        child: ElevatedButton(
            style:TextButton.styleFrom(backgroundColor: mainColor,
              padding: EdgeInsets.all(17.0),
              elevation: 5.0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(1.0)),
            ),
            onPressed: () async {
              Navigator.pop(context); // 사고 상세 화면 pop
              Navigator.pop(context); // 사고 이력 화면 pop

              Frame.doPagePush(context, PTSDChatPage(accidentIdx:int.parse(accidentIdx))); // PTSD 검사 화면 이동
            },
            child: Text(text, textScaleFactor:1.0, style: TextStyle( color: Colors.white, letterSpacing: 1.5, fontWeight: FontWeight.bold))));
  }
}

/// 메인 화면 버튼
/// PTSD 바로 알기, PTSD 자가진단, PTSD 치료, VR 노출
class MainScreenButton extends StatelessWidget{

  final String startImage;
  final String text;
  MainScreenButton(this.startImage, this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
      child: InkWell(
          onTap: ()=> {
            if(text == 'PTSD 바로알기')
              Frame.doPagePush(context, FindOutPage()) // PTSD 바로알기 화면으로 이동

            else if(text == 'PTSD 자가 진단')
            {
              if(Authorization().userID == '')
              {
                Frame.doPagePush(context, LoginPage()), // 로그인화면으로 이동
              }
              else{
                Frame.doPagePush(context, CheckUpMainPage()) // 검사 메뉴 화면으로 이동
              }
            }

            else if(text == 'PTSD 치료')
                Frame.doPagePush(context, HealingPage()) // 안정화 화면으로 이동

            else if(text == 'VR 노출 치료')
                PopUpDialog.vrDialog(URL_TO_LAUNCH_YOUTUBE_VR, context) // 유튜브 시청

          },
          child: Container(
            height: 90,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0), color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 1.0, spreadRadius: 0.0, offset: Offset(2.0, 2.0))],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:
              [
                Expanded(flex: 2, child: Image.asset('images/$startImage', height: 40, width: 40)),

                Expanded(flex: 3, child: Text(text, textScaleFactor: 1.2, style: TextStyle(fontWeight: FontWeight.bold))),

                Expanded(child: Image.asset('images/arrow.png', height: 13, width: 13)),
              ],
            ),
          ),
        ),
      );
    }
}

/// 진단 화면 메뉴 버튼
/// 한국판 사건 충격 척도 검사, 교통사고 평가, PTSD 챗봇 진단, 결과화면
class CheckUpMenuButton extends StatelessWidget {

  final String imageName;
  final String btnName;
  final double mWidth;

  CheckUpMenuButton(this.imageName, this.btnName, this.mWidth);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=>
      {
        if(btnName == '한국판 사건 충격 척도 수정판')
          PopUpDialog.informIESRKDialog(btnName, context)

        else if(btnName == '교통사고 평가')
          Frame.doPagePush(context, BeforeAccidentEvaluationPage())

        else if(btnName == 'PTSD 챗봇 진단')
          Frame.doPagePush(context,  PTSDChatPage(accidentIdx: -1))

        else
          Frame.doPagePush(context, ResultListPage()) // 결과 화면

      },
      child: Container(
        height: 75,
        width: mWidth / 1.4,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(3.0), color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 2.0, spreadRadius: 0.0, offset: Offset(2.0, 2.0))]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children:
          [
            Image.asset(imageName, height: 35, width: 35),

            Container(width: 110, child: Text(btnName, textScaleFactor: 1.0, style: TextStyle(fontWeight: FontWeight.bold), softWrap: true)),

            Image.asset('images/arrow.png', height: 13, width: 13),
          ],
        ),
      ),
    );
  }
}