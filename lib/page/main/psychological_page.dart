
import 'package:flutter/material.dart';
import 'package:vempire_app/utils/color.dart';
import 'package:vempire_app/utils/constants.dart';

/// 심리교육 화면
class PsychologicalPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(26.0),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
              [
                _buildMainTitle('심리 교육의 정의'),

                Container(padding: EdgeInsets.only(top: 10, bottom: 30),
                    child: Text(PSYCHOLOGICAL_DESCRIPTION_DEFINE, textScaleFactor: 1.0, softWrap: true, style: TextStyle(height: 1.4))),

                _buildMainTitle('심리 교육 방법'),

                Container(padding: EdgeInsets.only(top: 10, bottom: 20),
                    child: Text(PSYCHOLOGICAL_DESCRIPTION_WAY, textScaleFactor: 1.0, softWrap: true, style: TextStyle(height: 1.4))),

                Image.asset('images/psychological_image.png')
              ],
            ),

          ),
        ),
      ),
    );
  }

  /// 메인 타이들 Widget
  _buildMainTitle(String text){
    return Row(
      children:
      [
        Image.asset('images/check.png',width: 18, height: 18),

        SizedBox(width: 10),

        Text(text, textScaleFactor: 1.4, style: TextStyle(color: subTitleColor, fontWeight: FontWeight.bold))
      ],
    );
  }
}
