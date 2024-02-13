import 'package:flutter/material.dart';
import 'package:vempire_app/utils/color.dart';
import 'package:vempire_app/utils/constants.dart';

/// 교통사고 PTSD 치료 - [안정화 기법 화면]
class StabilizeTechniquePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children:
            [
              Card(
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                elevation: 3,
                child: Padding(padding: const EdgeInsets.all(25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                    [
                      _buildMainTitle('정의'),

                      Container(padding: EdgeInsets.only(top: 10, bottom: 20),
                          child: Text(STABILIZE_DESCRIPTION_DEFINE, textScaleFactor:1.0, softWrap: true, style:TextStyle(height: 1.4))),
                      ],
                  ),
                ),
              ),

              SizedBox(height: 10),

              Card(
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                elevation: 3,
                child: Padding(padding: const EdgeInsets.all(25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                    [
                      _buildMainTitle('사용'),

                      Container(padding: EdgeInsets.only(top: 10, bottom: 20),
                          child: Text(STABILIZE_DESCRIPTION_USE, textScaleFactor:1.0, softWrap: true, style:TextStyle(height: 1.4))),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),

              Card(
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildMainTitle('따라하기'),

                      Container(padding: EdgeInsets.only(top: 20, bottom: 20),
                          child: Text(STABILIZE_DESCRIPTION_TO_FOLLOW, textScaleFactor: 1.0, softWrap: true,style:TextStyle(height: 1.4))),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 10),

              buildActionWay('images/stabilize_1.png', '심호흡', STABILIZE_DESCRIPTION_TO_FOLLOW_STEP_1),
              buildActionWay('images/stabilize_2.png', '복식호흡', STABILIZE_DESCRIPTION_TO_FOLLOW_STEP_2),
              buildActionWay('images/stabilize_3.png', '착지법', STABILIZE_DESCRIPTION_TO_FOLLOW_STEP_3),
              buildActionWay('images/stabilize_4.png', '나비포옹법', STABILIZE_DESCRIPTION_TO_FOLLOW_STEP_4),
              //
            ],
          ),
        ),
      ),
    );
  }

  /// 안정화 기법 Card Widget
  Card buildActionWay(String image, String headText, String exampleText) {
    return Card(
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  children:
                  [
                    Image.asset(image),

                    Padding
                      (padding: const EdgeInsets.only(top: 20, bottom: 8),
                      child: Text(headText, textScaleFactor: 1.2, style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
                    ),

                    Container(padding: EdgeInsets.only(top: 10, bottom: 20),
                        child: Text(exampleText, textScaleFactor:1.0, softWrap: true, style:TextStyle(height: 1.4))),
                  ],
                ),
              ),
            );
  }

  /// 메인 타이틀 Widget
  _buildMainTitle(String text){
    return Row(
      children:
      [
        Image.asset('images/check.png', width: 18, height: 18),

        SizedBox(width: 10),

        Text(text, textScaleFactor: 1.4, style: TextStyle(color: subTitleColor, fontWeight: FontWeight.bold))
      ],
    );
  }

}
