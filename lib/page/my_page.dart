import 'package:flutter/material.dart';
import 'package:vempire_app/data/authorization.dart';
import 'package:vempire_app/page/password_change_page.dart';
import 'package:vempire_app/page/personal_information_change_page.dart';
import 'package:vempire_app/utils/color.dart';
import 'package:vempire_app/utils/frame.dart';
import 'package:vempire_app/widgets/popup_dialog.dart';

/// 마이 페이지
class MyPage extends StatefulWidget {

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {

  final String title = '마이페이지';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Frame.doAppBar(title),

      body: Container(
              color: myPageBackgroundColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                [
                     Container(
                       color: mainColor,
                        padding: EdgeInsets.only(left: 30),
                        constraints: BoxConstraints.expand(height: 80),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:
                            [
                              Text('${Authorization().name} 님', textScaleFactor: 1.8, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),

                              Text('${Authorization().email}', textScaleFactor: 0.92, style: TextStyle(color: Colors.white))
                            ]
                        )),

                  Padding(padding: const EdgeInsets.fromLTRB(15, 15, 15, 6),
                      child: Text('계정 관리', textScaleFactor: 1.1)),

                  _buildRowItem('images/info.png', '개인정보 변경'),

                  SizedBox(height: 15),

                  _buildRowItem('images/pass.png', '비밀번호 변경'),

                  SizedBox(height: 15),

                  _buildRowItem('images/logout.png', '로그 아웃'),

                  SizedBox(height: 15),

                  _buildRowItem('images/delete.png', '회원 탈퇴'),
                ],
              ),
            )
    );
  }

  _buildRowItem(String image, String textName){
    return InkWell(
      onTap: ()=>
      {
        if(textName == '개인정보 변경')
          Frame.doPagePush(context, PersonalInfoChangePage())

        else if(textName == '비밀번호 변경')
          Frame.doPagePush(context, PassChangePage())

        else if(textName == '로그 아웃')
          PopUpDialog.logoutDialog('로그 아웃', context)

        else if(textName == '회원 탈퇴')
          PopUpDialog.deleteDialog('회원 탈퇴', context)
      },
      child: Container(height: 70, color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:
          [
            Row(
              children:
              [
                Padding(padding: const EdgeInsets.fromLTRB(20, 0, 15, 0),
                    child: Image.asset(image, width: 40, height: 40)),

                Text(textName, textScaleFactor: 1.0),
              ],
            ),
            Padding(
                padding: const EdgeInsets.all(15.0),
                child:
                    Image.asset('images/my_arrow.png', height: 12, width: 12))
          ],
        ),
      ),
    );
  }
}
