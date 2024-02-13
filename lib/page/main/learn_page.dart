import 'package:flutter/material.dart';
import 'package:vempire_app/utils/color.dart';
import 'package:vempire_app/utils/constants.dart';

/// PTSD 알아보기 화면
class LearnPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Card(
                elevation: 3,
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                child: Padding(padding: const EdgeInsets.all(25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                    [
                      _buildMainTitle('정의'),

                      Text(LEARN_DESCRIPTION_DEFINE, textScaleFactor: 1.0, style: TextStyle(height: 1.4)),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20),

              Card(
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                elevation: 3,
                child: Padding(padding: const EdgeInsets.all(25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                    [
                      _buildMainTitle('증상'),

                      Container(child: Text(LEARN_DESCRIPTION_SYMPTOM, textScaleFactor: 1.0, style: TextStyle(height: 1.4))),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20),

              Card(
                elevation: 3,
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                child: Padding(padding: const EdgeInsets.all(25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                    [
                      _buildMainTitle('조치'),

                      Text(LEARN_DESCRIPTION_ACTION, textScaleFactor: 1.0, style:TextStyle(height: 1.4)),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  /// 메인 타이틀 Widget
  _buildMainTitle(String text){
    return Padding(padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children:
        [
          Image.asset('images/check.png',width: 18, height: 18),

          SizedBox(width: 10),

          Text(text, textScaleFactor: 1.4, style: TextStyle(color: subTitleColor, fontWeight: FontWeight.bold))
        ],
      ),
    );
  }
}
