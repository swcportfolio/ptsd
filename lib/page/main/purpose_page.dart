
import 'package:flutter/material.dart';
import 'package:vempire_app/utils/color.dart';
import 'package:vempire_app/utils/constants.dart';

/// 교통사고 PTSD 치료 - [ 목적화면 ]
class PurposePage extends StatelessWidget {

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
                      _buildMainTitle('목적'),

                      Container(padding: EdgeInsets.only(top: 10, bottom: 20),
                          child: Text(PURPOSE_DESCRIPTION, textScaleFactor: 1.0, softWrap: true, style: TextStyle(height: 1.4))),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20),
              
              Card(
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildMainTitle('치료 방법의 제공'),

                      Container(padding: EdgeInsets.only(top: 10, bottom: 20),
                          child: Text(PURPOSE_PROVIDE_TREATMENT, textScaleFactor: 1.0, softWrap: true, style: TextStyle(height: 1.4))),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 메인 타이틀 Widget
  _buildMainTitle(String titleName){
    return Row(
      children:
      [
        Image.asset('images/check.png',width: 18, height: 18),

        SizedBox(width: 10),

        Text(titleName, textScaleFactor: 1.4, style: TextStyle(color: subTitleColor, fontWeight: FontWeight.bold))
      ],
    );
  }

}
