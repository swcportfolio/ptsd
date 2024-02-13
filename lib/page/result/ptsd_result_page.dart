
import 'package:flutter/material.dart';
import 'package:vempire_app/data/result_list.dart';
import 'package:vempire_app/utils/color.dart';
import 'package:vempire_app/utils/constants.dart';
import 'package:vempire_app/utils/etc.dart';
import 'package:vempire_app/utils/frame.dart';

/// PTSD 결과 화면
class PTSDResultPage extends StatefulWidget {

  final PTSDResultList _resultListData; // 결과 데이터
  PTSDResultPage(this._resultListData);

  @override
  _PTSDResultPageState createState() => _PTSDResultPageState();
}

class _PTSDResultPageState extends State<PTSDResultPage> {

  final String title = 'PTSD 검사 결과';

  final String _headText = '수고하셨습니다.';
  final String _headText2 = '외상 후 스트레스 진단 검사가 모두 끝났습니다.';
  final String _resultContent = '외상 후 스트레스 진단 검사 결과';
  final String _resultContent2 = '으로 보입니다.';

  late String type;       // ptsd 최종 결과 ( normal , subPTSD, PTSD )
  late String diagnosis;  // 진단
  late String imageName;  // 결과 이미지
  late Color textColor;   // 결과 text 색상

  @override
  void initState() {
    super.initState();

    _setDiagnosis(); // 결과 초기화
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Frame.doAppBar(title),

      body: SingleChildScrollView(
        child: Padding(padding: const EdgeInsets.fromLTRB(15, 25, 15, 25),
          child: Column(
            children:
            [
              Card(
                elevation: 1,
                child: Padding(padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Text(_headText, softWrap: true, textScaleFactor: 0.9),

                            SizedBox(height: 5),

                            Text(_headText2, softWrap: true, textScaleFactor: 0.9)
                          ],
                        ),
                      ),

                      Etc.resultSolidLine(context),
                      Image.asset('images/${imageName}'),

                      SizedBox(height: 20),

                      Text(_resultContent, softWrap: true, textScaleFactor: 1.3, style: TextStyle(fontWeight: FontWeight.bold)),
                      Row(mainAxisAlignment: MainAxisAlignment.center,
                        children:
                        [
                          Text(type, softWrap: true, textScaleFactor: 1.3, style: TextStyle(fontWeight: FontWeight.bold, color:textColor)),
                          Text(_resultContent2, softWrap: true, textScaleFactor: 1.3, style: TextStyle(fontWeight: FontWeight.bold))
                        ],
                      )

                    ],
                  ),
                ),
              ),

              Card(
                elevation: 1,
                child: Padding(padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text(diagnosis == 'normal'? RESULT_PTSD_NORMAL: RESULT_PTSD_BAD, textScaleFactor: 0.9, style: TextStyle(height: 1.2)),

                      SizedBox(height: 20),

                      Text(RESULT_COMMON, textScaleFactor: 0.9, style: TextStyle(height: 1.2)),
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

/// 결과 초기화 method
  void _setDiagnosis()
  {
    if(widget._resultListData.type == 'Normal') {
      type = 'PTSD 정상';
      diagnosis = 'normal';
      imageName = 'ptsd_good.png';
      textColor = resultGreenColor;
    }

    else if(widget._resultListData.type == 'subPTSD') {
      type = 'PTSD 경향';
      diagnosis = 'bad';
      imageName = 'ptsd_bad.png';
      textColor = resultYellowColor;
    }

    else {
      type = 'PTSD 고 위험군';
      diagnosis = 'bad';
      imageName = 'ptsd_very_bad.png';
      textColor = resultRedColor;
    }
  }

}
