
import 'package:flutter/material.dart';
import 'package:vempire_app/data/authorization.dart';
import 'package:vempire_app/page/checkup/iesrk_chat_page.dart';
import 'package:vempire_app/page/main/main_page.dart';
import 'package:vempire_app/utils/color.dart';
import 'package:vempire_app/utils/constants.dart';
import 'package:vempire_app/utils/dio_client.dart';
import 'package:vempire_app/utils/etc.dart';
import 'package:vempire_app/utils/frame.dart';
import 'package:vempire_app/utils/save_data.dart';

/// AlertDialog class
class PopUpDialog{

  /// Common Dialog
  static dialog(String headText, String text, BuildContext mainContext) {
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
            content:Padding(
              padding: const EdgeInsets.fromLTRB(40, 12, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(text, textScaleFactor: 0.85, style: TextStyle(color: Colors.black)),
                ],
              ),
            ),
            contentPadding:EdgeInsets.all(0.0),
            actions: <Widget>
            [
              TextButton (
                child: new Text("확인", textScaleFactor:1),
                onPressed: () async
                {
                  Navigator.pop(context);
                  FocusScope.of(context).unfocus(); // 키보드 내리기
                },
              ),
            ],
          );
        });
  }

  /// 한국판 사건 충격 척도 수정판 검사 전 안내 Dialog
  static informIESRKDialog(String text, BuildContext mainContext) {
    return showDialog(context: mainContext, barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              title: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.assignment_late_outlined, color: mainColor),

                    Padding(padding: const EdgeInsets.only(left: 5),
                        child: Text('안내', textScaleFactor: 0.85, style: TextStyle(fontWeight: FontWeight.bold))),
                  ],
                ),
              ),
              content:Padding(padding: const EdgeInsets.fromLTRB(20, 12, 0, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(width: 240,
                        child: Text(DIALOG_DESCRIPTION, textScaleFactor: 0.85, style: TextStyle(height: 1.2))),
                  ],
                ),
              ),
              contentPadding: EdgeInsets.all(0.0),
              actions: [
                TextButton(child: Text("확인", textScaleFactor: 1.0),
                    onPressed: ()
                    {
                      Navigator.pop(context);

                      if(text == '한국판 사건 충격 척도 수정판')
                        Frame.doPagePush(context, IESRKChatPage());
                    })
              ]
          );
        }
    );
  }

  /// 회원 탈퇴 Dialog
 static deleteDialog(String title, BuildContext mainContext){
    return showDialog(context: mainContext, barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              title: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.assignment_late_outlined, color: Colors.red,),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text('탈퇴', textScaleFactor: 0.85, style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
              content:Padding(
                padding: const EdgeInsets.fromLTRB(20, 12, 0, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('$title 하시겠습니까? (데이터 삭제)', textScaleFactor: 0.85),
                  ],
                ),
              ),
              contentPadding:EdgeInsets.all(0.0),
              actions: <Widget>[

                TextButton(
                  child: new Text("취소", textScaleFactor: 1.0),
                  onPressed: () { Navigator.pop(context); }),

                TextButton(
                    child: new Text("확인", textScaleFactor: 1.0),
                    onPressed: () async {

                      Map<String, dynamic> toMap(String userID){
                        Map<String, dynamic> toMap ={
                          'userID': userID,
                        };
                        return toMap;
                      }

                      String success = await client.deleteUser(toMap(Authorization().userID));

                      if(success == 'Success')
                      {
                        Etc.showSnackBar('회원 탈퇴 되었습니다.', context);
                        deleteSaveData();
                        Authorization().clean();
                        Frame.doPageAndRemoveUntil(context, MainPage());
                      }
                    })
              ]);
        });
  }

  /// 로그아웃 dialog
  static logoutDialog(String title, BuildContext mainContext) {
    return showDialog(context: mainContext, barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            title: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.assignment_late_outlined, color: Colors.red),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text('로그아웃', textScaleFactor: 0.85, style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
            content: Padding(
              padding: const EdgeInsets.fromLTRB(40, 12, 0, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('$title 하시겠습니까?', textScaleFactor: 0.85),
                ],
              ),
            ),
            contentPadding:EdgeInsets.all(0.0),
            actions: <Widget>[
              TextButton(
                child: new Text("취소", textScaleFactor: 1.0),
                onPressed: () {  Navigator.pop(context); },
              ),
              TextButton (
                child: new Text("확인", textScaleFactor: 1.0),
                onPressed: ()
                {
                  Etc.showSnackBar('로그아웃 되었습니다.', context);
                  deleteSaveData();
                  Authorization().clean();
                  Frame.doPageAndRemoveUntil(context, MainPage());
                },
              ),
            ],
          );
        });
  }

  /// 앱 SharedPreferences data 삭제
  static void deleteSaveData()
  {
    SaveData _saveData = SaveData();
    _saveData.remove('userID');
    _saveData.remove('password');
  }

  /// vr guide Dialog
  static vrDialog(String url, BuildContext mainContext) {
    return showDialog(context: mainContext, barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            title:Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children:
                [
                  Icon(Icons.check_circle_outline, color: mainColor,),
                  Padding(padding: const EdgeInsets.only(left: 5),
                    child: Text('알림', textScaleFactor: 0.8, style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
            content:Padding(
              padding: const EdgeInsets.fromLTRB(40, 12, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      width: 220,
                      child: Text('기기에 유튜브 앱이 없으면 유튜브 사이트로 연결됩니다.', textScaleFactor: 0.85, style: TextStyle(color: Colors.black))),
                ],
              ),
            ),
            contentPadding: EdgeInsets.all(0.0),
            actions: <Widget>
            [
              TextButton (
                child: Text("확인", textScaleFactor:1),
                onPressed: () async
                {
                  Frame.doLaunchUniversalLink(url, context);
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

}