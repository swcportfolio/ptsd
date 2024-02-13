
import 'package:flutter/material.dart';
import 'package:vempire_app/utils/color.dart';
import 'package:vempire_app/utils/constants.dart';
import 'package:vempire_app/utils/frame.dart';
import 'package:vempire_app/widgets/button.dart';
import 'package:vempire_app/widgets/edit.dart';

/// 아이디 찾기 화면
class FindIdentificationPage extends StatefulWidget {

  @override
  _FindIdentificationPageState createState() => _FindIdentificationPageState();
}

class _FindIdentificationPageState extends State<FindIdentificationPage> {

  final String title = '아이디 찾기';

  final emailController = TextEditingController(); // 이메일
  final nameController  = TextEditingController(); // 이름

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
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
              [
                Padding(padding: const EdgeInsets.only(bottom: 5),
                  child: Text(APP_NAME, textScaleFactor: 1.2, style: TextStyle(color: mainColor, fontWeight: FontWeight.bold))),

                Text(FIND_ID_DESCRIPTION, textScaleFactor: 1.0, style: TextStyle(fontWeight: FontWeight.bold)),

                SizedBox(height: 20),

                // 이메일 입력
                FindInputEdit(iconData: Icons.email, headText: '이메일', hint: '이메일을 입력해주세요.', controller:emailController),

                // 이름 입력
                FindInputEdit(iconData: Icons.account_circle, headText: '이름', hint: '이름을 입력해주세요.', controller:nameController),

                SizedBox(height: 10),

                // 찾기 버튼
                CheckButton(text: '아이디 찾기', emailController: emailController, nameController: nameController),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
