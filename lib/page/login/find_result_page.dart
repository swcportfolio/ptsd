import 'package:flutter/material.dart';
import 'package:vempire_app/utils/color.dart';
import 'package:vempire_app/utils/constants.dart';
import 'package:vempire_app/utils/frame.dart';
import 'package:vempire_app/widgets/button.dart';

/// 아이디, 비밀번호 찾기 메일전송 완료 화면
class FindResultPage extends StatelessWidget {

  final String mailText;
  FindResultPage({required this.mailText});

  @override
  Widget build(BuildContext context) {

    final String title = '메일 전송';

    return Scaffold(
      appBar: Frame.doAppBar(title),

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Padding(padding: const EdgeInsets.only(top: 30, bottom: 10),
                child: Icon(Icons.outgoing_mail, size: 150, color: mainColor)),

              Text(mailText, textScaleFactor: 1.2, style: TextStyle(color: mainColor, fontWeight: FontWeight.bold)),

              Padding(padding: const EdgeInsets.only(top: 10, bottom: 30),
                child: Text(FIND_COMPLETE_MAIL_MSG, textScaleFactor: 0.9, style: TextStyle(color: Colors.grey))),

              CheckButton(text: '확인')
            ],
          ),
        ),
      ),
    );
  }
}
