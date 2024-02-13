import 'package:flutter/material.dart';
import 'package:vempire_app/page/login/find_id_page.dart';
import 'package:vempire_app/page/login/find_pass_page.dart';
import 'package:vempire_app/page/terms_page.dart';
import 'package:vempire_app/utils/color.dart';
import 'package:vempire_app/utils/edit_controller.dart';
import 'package:vempire_app/utils/etc.dart';
import 'package:vempire_app/utils/frame.dart';
import 'package:vempire_app/utils/network_check.dart';
import 'package:vempire_app/widgets/button.dart';
import 'package:vempire_app/widgets/edit.dart';

/// 로그인 화면
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final loginEdit = LoginEdit();
  //final _check = CheckNetworkConnection();

  bool isAutoLogin = true; // 자동로그인 flag

  @override
  void initState() {
    super.initState();
    //_check.checkNetWork(context); // 네트워크  상태 확인
  }

  @override
  Widget build(BuildContext context) {
   double mHeight = MediaQuery.of(context).size.height; // 디바이스 높이

    return Scaffold(
        appBar: AppBar(
          backgroundColor: mainColor,
          elevation: 0
        ),
        body: GestureDetector(
          onTap: ()
          {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(color: mainColor, borderRadius: BorderRadius.only(bottomLeft: const Radius.circular(30.0), bottomRight: const Radius.circular(30.0))),
                      constraints: BoxConstraints.expand(height: mHeight*0.28),
                      child: Frame.doLogo(context, 320)),

                  Column(
                    children:
                    [
                      Padding(padding: const EdgeInsets.fromLTRB(40, 50, 40, 0),
                        child: LoginInputEdit(iconData: Icons.account_box, hint: '아이디를 입력해주세요', controller: loginEdit.idController, type: 'id')),

                      Padding(padding: const EdgeInsets.fromLTRB(40, 0, 40, 10),
                        child: LoginInputEdit(iconData: Icons.vpn_key, hint: '비밀번호를 입력해주세요', controller: loginEdit.passController, type: 'pass')),

                      LoginButton(loginEdit: loginEdit, isAutoLogin: isAutoLogin),

                      Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            child: InkWell(
                                onTap: () => {
                                  Frame.doPagePush(context, FindIdentificationPage()) // 아이디 찾기 화면 이동
                                },
                                child: Padding(padding: const EdgeInsets.all(15.0),
                                  child: Text('아이디 찾기', textScaleFactor: 0.9, style: TextStyle(color: Colors.grey))))),

                          Container(
                            child: InkWell(
                                onTap: () => {
                                  Frame.doPagePush(context, FindPassPage()) // 비밀번호 찾기 화면 이동
                                },
                                child: Padding(padding: const EdgeInsets.all(15.0),
                                  child: Text('비밀번호 찾기', textScaleFactor: 0.9, style: TextStyle(color: Colors.grey))))),

                          Container(
                            child: InkWell(
                                onTap: () => {
                                  Frame.doPagePush(context, TermsPage(signResultMsg:()=> signResultMsg())) // 회원가입 화면 이동
                                },
                                child: Padding(padding: const EdgeInsets.all(15.0),
                                  child: Text('회원가입', textScaleFactor: 0.9, style: TextStyle(color: Colors.grey)))))
                        ],
                      ),

                      _buildRowCheckBox('자동 로그인'),
                    ],
                  )
                ]),
          ),
        ));
  }

  /// 자동로그인 체크 박스
  _buildRowCheckBox(String name){
    return  Padding(
      padding: const EdgeInsets.only(left: 40),
      child: Row(
        children: [
          Transform.scale(
            scale: 1.1,
            child: Checkbox(
                activeColor: mainColor,
                checkColor: Colors.white,
                shape: CircleBorder(side: BorderSide(color: mainColor)),
                value: isAutoLogin,
                onChanged:(bool? value) {
                  setState(() {
                    isAutoLogin = value!;
                    print('>>>> [자동로그인 활성화] : ' + isAutoLogin.toString());
                  });
                }),
          ),
          Container(
              child: Text(name, softWrap: true, textScaleFactor: 0.8, style: TextStyle(fontWeight: FontWeight.normal))
          ),
        ],
      ),
    );
  }

  /// 회원가입 완료 msg
  signResultMsg(){
    Etc.showSnackBar('회원가입 완료되었습니다.', context);
  }
}
