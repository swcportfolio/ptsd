import 'package:flutter/material.dart';
import 'package:vempire_app/utils/color.dart';
import 'package:vempire_app/utils/constants.dart';
import 'package:vempire_app/widgets/popup_dialog.dart';

/// 교통사고 PTSD 치료 - [스트레스 버킷 모델]
class StressBucketPage extends StatefulWidget {

  @override
  _StressBucketPageState createState() => _StressBucketPageState();
}

class _StressBucketPageState extends State<StressBucketPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(padding: const EdgeInsets.all(10.0),
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
                          child: Text(BUCKET_DESCRIPTION_DEFINE, textScaleFactor: 1.0, softWrap: true, style: TextStyle(height: 1.4))),
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
                    children:
                    [
                      _buildMainTitle('소개'),

                      Container(
                          padding: EdgeInsets.only(top: 10, bottom: 20),
                          child: Text(BUCKET_DESCRIPTION_INTRODUCTION, textScaleFactor:1.0, softWrap: true, style:TextStyle(height: 1.4))),

                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top:10),
                          child: InkWell(
                            onTap: (){
                              PopUpDialog.vrDialog(URL_TO_LAUNCH_YOUTUBE_STRESS, context);
                            },
                            child: Container(height: 55, width: 300,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0), color: mainColor,
                                boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 1.0, spreadRadius: 0.0, offset: Offset(2.0, 2.0))]),
                              child: Center(child: Text('스트레스 컵 영상 시청', textScaleFactor: 1.2, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))
                            ),
                          ),
                        ),
                      ),

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
