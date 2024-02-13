
import 'package:flutter/material.dart';
import 'package:vempire_app/data/accident_data.dart';
import 'package:vempire_app/utils/color.dart';
import 'package:vempire_app/utils/etc.dart';
import 'package:vempire_app/utils/frame.dart';
import 'package:vempire_app/widgets/button.dart';

/// 사고 평가 상세 화면
class AccidentDetailPage extends StatelessWidget {

  final String title = '사고 상세';

  final Accident _resultListData;
  AccidentDetailPage(this._resultListData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Frame.doAppBar(title),

      body: Container(
        child: Padding(padding: const EdgeInsets.fromLTRB(13, 20, 13, 20),
          child: Column(
            children:
            [
              Container(
                  height: 370,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(border: Border.all(width: 2.0, color: mainColor), borderRadius: BorderRadius.all(Radius.circular(2.0))),
                  child: Padding(padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:
                      [
                        _contentsItem('사고 날짜', _resultListData.accidentDate),
                        Etc.solidLine(context),

                        _contentsItem('사고 시간', _resultListData.accidentTime),
                        Etc.solidLine(context),

                        _contentsItem('장소', _resultListData.place),
                        Etc.solidLine(context),

                        _contentsItem('상대방 차 종류' , _resultListData.opponentCarType),
                        Etc.solidLine(context),

                        _contentsItem('상대방 차 색상', _resultListData.opponentCarColor),
                        Etc.solidLine(context),

                        _contentsItem('상대방과 부딪힌 방향 ', _resultListData.direction),
                        Etc.solidLine(context),

                        _contentsItem('사고 당시 속도', _resultListData.speed),
                      ],
                    ),
                  )
              ),
              Padding(padding: const EdgeInsets.only(top: 20),
                child: PTSTBeforeButton(accidentIdx: _resultListData.accidentIdx, text: '검사 진행 하기'),
              )
            ],
          ),
        ),
      ),
    );
  }

  /// 사고 평가 화면에 표시될 내용
  _contentsItem(String textTitle, String value){
    return Padding(padding: const EdgeInsets.all(13.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:
        [
          Row(
            children:
            [
              Image.asset('images/uu.png', width: 10, height: 10),

              SizedBox(width: 10),

              Text(textTitle, textScaleFactor:0.95, style: TextStyle(fontWeight: FontWeight.bold))
            ]
          ),
          Text(value, textScaleFactor:0.9),
        ],
      ),
    );
  }
}
