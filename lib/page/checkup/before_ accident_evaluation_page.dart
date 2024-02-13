import 'package:flutter/material.dart';
import 'package:vempire_app/data/accident_data.dart';
import 'package:vempire_app/data/authorization.dart';
import 'package:vempire_app/utils/dio_client.dart';
import 'package:vempire_app/utils/frame.dart';
import 'package:vempire_app/widgets/button.dart';
import 'package:vempire_app/widgets/list_item.dart';

/// PTSD 교통사고 평가전 화면
/// 신규 등록, 과거 이력 확인
class BeforeAccidentEvaluationPage extends StatefulWidget {

  @override
  _BeforeAccidentEvaluationPageState createState() => _BeforeAccidentEvaluationPageState();
}

class _BeforeAccidentEvaluationPageState extends State<BeforeAccidentEvaluationPage> {

  final String title = '교통사고 평가 이력';

  final _scrollController = ScrollController();
  List<Accident> _accidentData = []; // 과거 사고 평가 이력 리스트

  bool isAccidentDataEmpty = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Frame.doAppBar(title),

      body: FutureBuilder(
          future: client.getAccidentData(Authorization().userID),
          builder: (context, snapshot) {

            if(snapshot.hasError){
              return Container(
                  child: Center(
                      child: Text(snapshot.error.toString().replaceFirst('Exception: ', ''),
                          style: TextStyle(color: Colors.black, fontSize: 10.0))));
            }

            if (!snapshot.hasData) {
              return Container(
                  child: Center(
                      child: SizedBox(height: 40.0, width: 40.0,
                          child: CircularProgressIndicator(strokeWidth: 5))));
            }

            if (snapshot.connectionState == ConnectionState.done) {
              _accidentData = snapshot.data!;
            }

            if (_accidentData.isEmpty) {
              isAccidentDataEmpty = false;
            }
              return Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                  [
                    Padding(padding: const EdgeInsets.only(left: 13, right: 13, top:20),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children:
                            [
                              Image.asset('images/result_icon.jpg', width: 15, height: 15),

                              SizedBox(width: 10),

                              Text('신규로 시작하기', textScaleFactor: 1.2, style: TextStyle(fontWeight: FontWeight.bold))
                            ]
                        )),

                    Padding(padding: const EdgeInsets.only(right: 12, bottom: 12, left: 12),
                      child: PTSTNewButton(text:'신규 선택')),

                    Padding(padding: const EdgeInsets.all(13.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children:
                            [
                              Image.asset('images/result_icon.jpg', width: 15, height: 15),

                              SizedBox(width: 10),

                              Text('과거 이력 조회', textScaleFactor: 1.2, style: TextStyle(fontWeight: FontWeight.bold))
                            ]
                        )),

                    Visibility(
                      visible: isAccidentDataEmpty,
                      child: Expanded(
                        child: Padding(padding: const EdgeInsets.only(top: 10),
                            child: ListView.builder(
                                controller: _scrollController,
                                itemCount: _accidentData.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return AccidentInfoItem(_accidentData[index]);
                                }
                                ))),
                    ),

                    Visibility(
                      visible: !isAccidentDataEmpty,
                      child: Center(
                        child: Text('결과 내역이 없습니다.', textScaleFactor: 0.96),
                      ),
                    )
                  ],
                ),
              );
          }
      )
    );
  }
}
