import 'package:flutter/material.dart';
import 'package:vempire_app/data/accident_data.dart';
import 'package:vempire_app/data/result_list.dart';
import 'package:vempire_app/page/checkup/accident_detail_page.dart';
import 'package:vempire_app/page/result/iesrk_result_page.dart';
import 'package:vempire_app/page/result/ptsd_result_page.dart';
import 'package:vempire_app/utils/frame.dart';

/// IES-R-K List Item
class IESRKResultItem extends StatelessWidget {

  final IESRKResultList resultListData;
  IESRKResultItem(this.resultListData);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: InkWell(
        onTap: ()=> {
          Frame.doPagePush(context, IESRKResultPage(resultListData)) // IES-R-K 상세 화면 이동
        },
        child: Card(
          elevation: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:
            [
              Padding(padding: const EdgeInsets.all(3.0),
                child: Row(
                  children:
                  [
                    Padding(padding: const EdgeInsets.all(12.0),
                        child: Image.asset('images/result_list_icon.jpg', height: 35, width: 35)),

                    Text(resultListData.createDT, textScaleFactor: 1.0, style: TextStyle(fontWeight: FontWeight.bold)), // 생성 날짜
                  ],
                ),
              ),

              Padding(padding: const EdgeInsets.all(10.0),
                child: Image.asset('images/result_arrow.png', height: 15, width: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// PTSD Result List Item
class PTSDResultItem extends StatelessWidget {

  final PTSDResultList _resultListData;
  PTSDResultItem(this._resultListData);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: InkWell(
        onTap: ()=> {
          Frame.doPagePush(context, PTSDResultPage(_resultListData)) // PTSD 결과 화면 이동
        },
        child: Card(
          elevation: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:
            [
              Padding(padding: const EdgeInsets.all(3.0),
                child: Row(
                  children:
                  [
                    Padding(padding: const EdgeInsets.all(12.0),
                        child: Image.asset('images/result_list_icon.jpg', height: 35, width: 35)),

                    Text(_resultListData.createDT, textScaleFactor: 1.0, style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),

              Padding(padding: const EdgeInsets.all(10.0),
                child: Image.asset('images/result_arrow.png', height: 15, width: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 교통사고 평가 이력 List item
class AccidentInfoItem extends StatelessWidget {

  final Accident _resultListData;
  AccidentInfoItem(this._resultListData);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: InkWell(
        onTap: ()=> {
          Frame.doPagePush(context, AccidentDetailPage(_resultListData)) // 사고평가 상세 화면
        },
        child: Card(
          elevation: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Padding(padding: const EdgeInsets.all(3.0),
                child: Row(
                  children:
                  [
                    Padding(padding: const EdgeInsets.all(12.0),
                        child: Image.asset('images/result_list_icon.jpg', height: 35, width: 35)),

                    Text(_resultListData.accidentDate, textScaleFactor: 1.0, style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),

              Padding(padding: const EdgeInsets.all(10.0),
                child: Image.asset('images/result_arrow.png', height: 15, width: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}