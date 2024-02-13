import 'package:flutter/material.dart';
import 'package:vempire_app/data/authorization.dart';
import 'package:vempire_app/page/my_page.dart';
import 'package:vempire_app/utils/color.dart';
import 'package:vempire_app/utils/frame.dart';
import 'package:vempire_app/widgets/button.dart';

/// 검사 메인화면
/// 교통사고 평가, 한국판 사건 충격 척도 수정판, PTSD 챗봇 진단, 결과보기
class CheckUpMainPage extends StatefulWidget {

  @override
  _CheckUpMainPageState createState() => _CheckUpMainPageState();
}

class _CheckUpMainPageState extends State<CheckUpMainPage> {

 late double mHeight,mWidth; // 해상도에 따른 가로 세로

  @override
  Widget build(BuildContext context) {

    mHeight = MediaQuery.of(context).size.height;
    mWidth  = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor:mainColor,
        elevation: 0,
        actions:
        [
          IconButton(
              highlightColor: Colors.white,
              color: Colors.white,
              icon: Icon(Icons.settings),
              onPressed: ()=> {
                Frame.doPagePush(context, MyPage()) // 마이 페이지 이동
              }
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children:
            [
              Container(
                  alignment: Alignment.topCenter,
                  constraints: BoxConstraints.expand(height: mHeight * 0.25),
                  decoration: BoxDecoration(
                      color:mainColor,
                      borderRadius:  BorderRadius.only(bottomLeft: const Radius.circular(20.0), bottomRight: const Radius.circular(20.0))),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:
                      [
                        Frame.doLogo(context, 280),

                        SizedBox(height: 20),

                        Text(Authorization().name+'님 안녕하세요', textScaleFactor: 1.1, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ])
              ),

              SizedBox(height: 40),

              CheckUpMenuButton('images/inspection.png', '교통사고 평가', mWidth),

              SizedBox(height: 20),

              CheckUpMenuButton('images/inspection.png', '한국판 사건 충격 척도 수정판', mWidth),

              SizedBox(height: 20),

              CheckUpMenuButton('images/inspection.png', 'PTSD 챗봇 진단', mWidth),

              SizedBox(height: 20),

              CheckUpMenuButton('images/result.png', '결과보기', mWidth)
            ]
          ),
        ),
      )
    );
  }
}
