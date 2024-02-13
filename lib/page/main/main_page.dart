import 'package:flutter/material.dart';
import 'package:vempire_app/utils/color.dart';
import 'package:vempire_app/utils/constants.dart';
import 'package:vempire_app/utils/frame.dart';
import 'package:vempire_app/widgets/button.dart';

/// 메인화면
/// 로딩화면 이후 첫 화면
/// PTSD 바로 알기, PTSD 자가진단, PTSD 치료, VR 노출 치료 버튼
class MainPage extends StatefulWidget {

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  var size ;
  late double topPadding;

  @override
  Widget build(BuildContext context) {

    size = MediaQuery.of(context).size;
    print('>>> [size height] : ' + size.height.toString());
    size.height > 800 ? topPadding = 60 : topPadding = 10 ;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: mainColor,
          padding: const EdgeInsets.only(top: 26, right: 26, left: 26),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  child: Padding(padding : EdgeInsets.only(top: topPadding),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children:
                      [
                        Container(
                            decoration: BoxDecoration(color: mainColor, borderRadius: BorderRadius.only(bottomLeft: const Radius.circular(30.0),
                                bottomRight: const Radius.circular(30.0))),
                            constraints: BoxConstraints.expand(height: 170),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Frame.doLogo(context, 300),

                                  Text('반갑습니다. $APP_NAME 입니다.',textScaleFactor:1.3, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                ])
                        ),

                        MainScreenButton('menu_1.gif', 'PTSD 바로알기'),
                        MainScreenButton('menu_2.gif', 'PTSD 자가 진단'),
                        MainScreenButton('menu_3.gif', 'PTSD 치료'),
                        MainScreenButton('menu_3.gif', 'VR 노출 치료'),
                      ],
                    ),
                  ),
                ),
              ),

              // Copyright
              // Align(
              //     alignment:Alignment.bottomCenter,
              //     child: Padding(padding: const EdgeInsets.fromLTRB(20, 10, 20, 15),
              //         child: _buildCopyright()))
            ],
          ),
        ),
      ),
    );
  }

  /// 하단 저작권 표시
  _buildCopyright(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:
      [
        Text('Copyright © 2022  ', textScaleFactor: 0.9),
        Image.asset('images/copyright.png', width: 130, height: 30)
      ],
    );
  }
}

