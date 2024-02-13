import 'package:flutter/material.dart';
import 'package:vempire_app/data/authorization.dart';
import 'package:vempire_app/utils/edit_controller.dart';
import 'package:vempire_app/utils/frame.dart';
import 'package:vempire_app/widgets/button.dart';
import 'package:vempire_app/widgets/edit.dart';

/// 비밀번호 변경 화면
class PassChangePage extends StatefulWidget {

  @override
  _PassChangePageState createState() => _PassChangePageState();
}

class _PassChangePageState extends State<PassChangePage> {

  final String title = '비밀번호 변경';
  final _passwordEdit = PasswordEdit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Frame.doAppBar(title),

      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(30, 1, 30, 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              SizedBox(height: 20),

              SignInputEdit(controller: _passwordEdit.beforePassController  , iconData: Icons.vpn_key, headText: '비밀번호', hint: '현재 비밀번호를 입력하세요.', type: 'pass'),

              SizedBox(height: 25),

              SignInputEdit(controller: _passwordEdit.newPassController  , iconData: Icons.vpn_key, headText: '새로운 비밀번호', hint: '특수, 대소문자, 숫자 포함 8자~15자 입력하세요.', type: 'pass'),
              SignInputEdit(controller: _passwordEdit.newPass2Controller  , iconData: Icons.vpn_key, headText: '새로운 비밀번호 확인', hint: '새로운 비밀번호 재입력해주세요.', type: 'pass'),

              SizedBox(height: 30),

              PassChangeButton('변경 하기', _passwordEdit, this.context)

            ],
          ),
        ),
      )
    );
  }
}
