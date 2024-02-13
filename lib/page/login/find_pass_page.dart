import 'package:flutter/material.dart';
import 'package:vempire_app/utils/color.dart';
import 'package:vempire_app/utils/constants.dart';
import 'package:vempire_app/utils/frame.dart';
import 'package:vempire_app/widgets/button.dart';
import 'package:vempire_app/widgets/edit.dart';

/// 비밀번호 찾기 화면
class FindPassPage extends StatefulWidget {

  @override
  _FindPassPageState createState() => _FindPassPageState();
}

class _FindPassPageState extends State<FindPassPage> {

  final String title = '비밀번호 찾기';

  TextEditingController emailController = TextEditingController();   // 이메일
  TextEditingController nameController  = TextEditingController();   // 이름
  TextEditingController idController    = TextEditingController();   // 아이디

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Frame.doAppBar(title),

      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: ()
          {
            FocusScope.of(context).unfocus();
          },
          child: Padding(padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
              [
                Padding(padding: const EdgeInsets.only(bottom: 5),
                    child: Text(APP_NAME, textScaleFactor: 1.2, style: TextStyle(color: mainColor, fontWeight: FontWeight.bold))),

                Text(FIND_PASS_DESCRIPTION, textScaleFactor: 1.0, style: TextStyle(fontWeight: FontWeight.bold)),

                SizedBox(height: 20),

                // 아이디 입력
                FindInputEdit(iconData: Icons.admin_panel_settings_rounded,headText: '아이디', hint: '아이디을 입력해주세요.', controller: idController),

                // 이메일 입력
                FindInputEdit(iconData: Icons.email, headText: '이메일', hint: '이메일을 입력해주세요.', controller: emailController),

                // 이름 입력
                FindInputEdit(iconData: Icons.account_circle, headText: '이름', hint: '이름을 입력해주세요.', controller: nameController),

                SizedBox(height: 10),

                // 찾기 버튼
                CheckButton(text: '비밀번호 찾기', idController: idController, emailController: emailController, nameController: nameController),
              ],
            ),
          ),
        ),
      ),
    );;
  }
}
