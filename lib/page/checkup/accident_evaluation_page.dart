import 'package:flutter/material.dart';
import 'package:vempire_app/data/accident_grid_data.dart';
import 'package:vempire_app/data/date_picker_data.dart';
import 'package:vempire_app/data/grid_view_property.dart';
import 'package:vempire_app/data/picker_data.dart';
import 'package:vempire_app/data/selected_grid_data.dart';
import 'package:vempire_app/utils/color.dart';
import 'package:vempire_app/utils/constants.dart';
import 'package:vempire_app/utils/edit_controller.dart';
import 'package:vempire_app/utils/frame.dart';
import 'package:vempire_app/utils/grid_childAspectRatio.dart';
import 'package:vempire_app/widgets/custom_picker.dart';
import 'package:vempire_app/widgets/button.dart';
import 'package:vempire_app/widgets/date_picker.dart';
import 'package:vempire_app/widgets/edit.dart';
import 'package:vempire_app/widgets/grid_view_%20item.dart';

///신규 사고정보 입력화면
class EvaluationPage extends StatefulWidget {

  @override
  _EvaluationPageState createState() => _EvaluationPageState();
}

class _EvaluationPageState extends State<EvaluationPage> {

  final String title = '교통사고 평가';

  AccidentEdit _accidentEdit = AccidentEdit();
  GridViewEvaluation _gridViewEvaluation = GridViewEvaluation();
  SelectedGridData selectedGridData = SelectedGridData();

  List<bool> commonTrue = [false, false]; // 0: 종류및 색상, 1: 상대방 종류및 색상

  String accidentDate = '사고 날짜를 선택해 주세요.';
  String accidentTime = '사고 시간을 선택해 주세요.';
  String accidentSpeed = '사고 당시 속도을 입력해주세요.';

  var size;
  late double itemHeight, itemWidth;

  @override
  Widget build(BuildContext context) {

    size = MediaQuery.of(context).size;
    itemHeight = size.height < 700 ? ((size.height+30) - kToolbarHeight) : (size.height - kToolbarHeight);
    itemWidth = size.width > 500 ?  size.width / 4 : size.width / 1.9;

    return Scaffold(
      appBar: Frame.doAppBar(title),

      body: GestureDetector(
        onTap: ()=> {
         FocusScope.of(context).unfocus()
        },
        child: Center(
          child: Scrollbar(
              child: SingleChildScrollView(
                child: Padding(padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                 child: Container(
                   width: MediaQuery.of(context).size.width,
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                      [
                        /// 사고 유형
                        _columnGridView(AccidentGridData('사고유형', 80, _gridViewEvaluation.accidentTypeNames, _gridViewEvaluation.isAccidentType,
                            GridName.accidentType, 2)),

                        /// 나의 자동차 종류 및 색상
                        _columnGridView(AccidentGridData('자동차 종류 및 색상', 100, _gridViewEvaluation.colorAndTypeNames, _gridViewEvaluation.isColorAndType, GridName.carType, 2)),
                        Visibility(visible: commonTrue[0],
                          child: Padding(padding: const EdgeInsets.fromLTRB(7, 5, 7, 0),
                            child: InputEdit(controller:_accidentEdit.myCarColorController, iconData:Icons.directions_car, hint:'자동차 색상을 입력해주세요.', type: 'carColor')),
                        ),

                        /// 상대방 자동차 종류 및 색상
                        SizedBox(height: 25),
                        _columnGridView(
                            AccidentGridData('상대방 자동차 종류 및 색상', 100,
                                _gridViewEvaluation.opponentColorAndTypeNames, _gridViewEvaluation.isOpponentColorAndType, GridName.opponentCarType, 2)),
                        Visibility(visible: commonTrue[1],
                          child: Padding(padding: const EdgeInsets.fromLTRB(7, 5, 7, 10),
                            child: InputEdit(controller:_accidentEdit.opponentCarColorController, iconData:Icons.directions_car_sharp, hint: '자동차 색상을 입력해주세요.', type: 'carColor')),
                        ),

                        furtherExplanation(), // 이번사고 관련...

                        /// 사고 날짜 선택
                        CustomDatePicker.buildAccidentDate(DatePickerData('사고 날짜', Icons.date_range, accidentDate, context,
                                (callbackDateData)=>onGetDatePickerData(callbackDateData))),

                        /// 사고 시간
                        CustomDatePicker.buildAccidentTime(DatePickerData('사고 당시 시간', Icons.date_range, accidentTime, context,
                                (callbackTimeData)=>onGetDateTimePickerData(callbackTimeData))),

                        /// 사고 속도
                        buildAccidentSpeed('사고 당시 속도', Icons.speed, accidentSpeed),

                        /// 사고 장소
                        AccidentSpaceInputEdit(controller: _accidentEdit.spaceController, iconData: Icons.account_balance, headText: '사고 장소', hint: '사고 장소를 입력해주세요.'),

                        /// 사고 날씨
                        SizedBox(height: 25),
                        _columnGridView(AccidentGridData('사고 당시 날씨', 100,
                            _gridViewEvaluation.weatherNames, _gridViewEvaluation.isWeather, GridName.weather, 2)),

                        /// 사고 방향
                        SizedBox(height: 25),
                        _columnGridView(AccidentGridData('상대방과 부딪힌 방향', 120,
                            _gridViewEvaluation.directionNames, _gridViewEvaluation.isDirection, GridName.direction, 3)),

                        /// 입원 여부
                        SizedBox(height: 25),
                        _columnGridView(AccidentGridData('사고 이후 타과적으로 입원하였습니까?', 70,
                            _gridViewEvaluation.admissionNames, _gridViewEvaluation.isAdmission, GridName.admissionYN, 2)),

                        /// 머리 부상
                        _columnGridView(AccidentGridData('사고 당시 머리를 다치셨습니까?', 70,
                            _gridViewEvaluation.hurtTheHeadNames, _gridViewEvaluation.isHurtTheHea, GridName.hurtHeadYN, 2)),

                        /// 사고 기억
                        _columnGridView(AccidentGridData('사고 당시 상황을 기억하십니까?', 70,
                            _gridViewEvaluation.situationMemoryNames, _gridViewEvaluation.isSituationMemory, GridName.memoryYN, 2)),

                        /// 법적 문제
                        _columnGridView(AccidentGridData('현재 법적인 문제가 남아있습니까?', 70,
                            _gridViewEvaluation.legalMatterNames, _gridViewEvaluation.isLegalMatter, GridName.legalMatterYN, 2)),

                        /// 최종 확인 버튼
                        EvaluationButton(text: '확인', selectedGridData: selectedGridData, accidentEdit:_accidentEdit, context: context),

                        SizedBox(height: 15)
                      ],
                ),
                 ),),
          )),
        )
      ),
    );
  }



  /// GridView Column Widget
  /// @param gridData : 교통사고 Gridview 초기 데이터
  _columnGridView(AccidentGridData gridData){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(gridData.headText, textScaleFactor: 1.0, style: TextStyle(fontWeight: FontWeight.bold)),
        Container(
            padding: const EdgeInsets.fromLTRB(0, 7, 0, 0),
            child: SizedBox(
                width: MediaQuery.of(context).size.width, height: gridData.height,
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: gridData.girdNameList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: gridData.crossAxisCount,
                      childAspectRatio:
                      (gridData.typeName == GridName.direction || gridData.typeName == GridName.weather) ?
                      GridChildAspectRatio.convertAccident2ndRow(gridData.typeName, size, itemHeight, itemWidth) :
                      GridChildAspectRatio.convertAccident1ndRow(gridData.typeName, size, itemHeight, itemWidth)),
                  itemBuilder: (BuildContext context, int index) {
                    return _buildGridView(gridData.typeName, index, gridData.girdNameList, gridData.isGrid);
                  },
                ))
        ),
      ],
    );
  }


  /// GridView.builder itemBuilder
  _buildGridView(String typeName, int index, List commonName, List isCommon){
    String name = commonName[index];

    return GestureDetector(
        onTap: () {
          setState(() {
            FocusScope.of(context).unfocus();

            if (isCommon[index]){
              isCommon[index] = false;
              classifySelectDataByName(name, '');
            }

            else {
              for (int i = 0; i<isCommon.length; i++){
                if (index != i) {
                  isCommon[i] = false;
                }
              }

              isCommon[index] = true;
              classifySelectDataByName(typeName, commonName[index]);

              if(typeName == GridName.carType || typeName == GridName.opponentCarType){ // 나의 자동차 종류 및 색상, 상대방 자동차
                _visActivation(typeName, true); // 추가 입력란 무조건 활성화
              }
            }
          }
          );},
        child: typeName == GridName.weather ? GridViewItem.buildWeatherGridViewItem(name, isCommon[index]) : GridViewItem.buildGridViewItem(name, isCommon[index]) // 날씨 일때만
    );
  }

  /// 사고 당시 속도 widget
  buildAccidentSpeed(String headText, IconData iconData, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Padding(
          padding: const EdgeInsets.fromLTRB(0, 19, 0, 5),
          child: Text(headText, textScaleFactor: 1.0, style: TextStyle(color:Colors.black, fontWeight: FontWeight.bold)),
        ),

        InkWell(
          onTap: (){
            FocusScope.of(context).unfocus();
            CustomPicker().showBottomSheet(PickerData(PickerInitial.accidentInitialVal, PickerItemList.accidentSpeedItemList, context,
                    (callbackData)=>onGetPickerData(callbackData)));
          },
          child: Container(alignment: Alignment.centerLeft, height: 47.0,
            child: Padding(padding: const EdgeInsets.all(8.0),
              child: Row(
                children:
                [
                  Padding(padding: const EdgeInsets.fromLTRB(3, 0, 16, 0),
                      child: Icon(iconData, color: mainColor)),

                  Text(hint, textScaleFactor: 0.8, style: TextStyle(color: hint == '사고 당시 속도을 입력해주세요.' ? Colors.grey : Colors.black)),
                ],
              ),
            ),
            decoration: BoxDecoration(border: Border.all(width: 1.0, color: Colors.grey), borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
          ),
        )
      ],
    );
  }

  /// Number picker Function callback
  /// @param callbackData : 반환 값
  onGetPickerData(callbackData) {
    setState(() {
      _accidentEdit.speedController.text = callbackData.toString() +' km/h';
      accidentSpeed =_accidentEdit.speedController.text;
    });
  }

  /// Date picker Function callback
  /// @param callbackData : 반환 값
  onGetDatePickerData(callbackDateData) {
    setState(() {
      _accidentEdit.dateController.text = callbackDateData.year.toString() + '-' + callbackDateData.month.toString() + '-' + callbackDateData.day.toString(); // DB insert 용
      accidentDate = callbackDateData.year.toString() + '년 ' + callbackDateData.month.toString() + '월 ' + callbackDateData.day.toString()+ '일';
    });
  }

  /// Date Time picker Function callback
  /// @param callbackData : 반환 값
  onGetDateTimePickerData(callbackTimeData) {
    setState(() {
      _accidentEdit.timeController.text = callbackTimeData.hour.toString()+ '시 ' +callbackTimeData.minute.toString()+ '분';
      accidentTime =_accidentEdit.timeController.text;
    });
  }

  /// name 기준으로 선택한 데이터 set
  void classifySelectDataByName(String name, String selectData) {
    switch(name){
      case GridName.accidentType    : selectedGridData.accidentType = selectData; break;
      case GridName.carType         : selectedGridData.carType = selectData; break;
      case GridName.opponentCarType : selectedGridData.opponentCarType = selectData; break;
      case GridName.weather         : selectedGridData.weather = selectData; break;
      case GridName.direction       : selectedGridData.direction = selectData; break;
      case GridName.admissionYN     : selectedGridData.admissionYN = selectData; break;
      case GridName.hurtHeadYN      : selectedGridData.hurtHeadYN = selectData; break;
      case GridName.memoryYN        : selectedGridData.memoryYN = selectData; break;
      case GridName.legalMatterYN   : selectedGridData.legalMatterYN = selectData; break;
    }
  }

  /// Visibility 활성화 및 비활성화
  /// 본인 차량 타입, 상대방 차량 타입  -> 색상 입력란 활성화/비 활성화
  void _visActivation(String typeName, bool value) {
    print('>>>> [visActivation] : $typeName / $value');
    switch(typeName){
      case GridName.carType         : commonTrue[0] = value; break;
      case GridName.opponentCarType : commonTrue[1] = value; break;
    }
  }

  /// 중간 설명 글
  Widget furtherExplanation(){
    return Padding(
      padding: const EdgeInsets.only(top: 35),
      child: FittedBox(
        child: Row(
          children:
          [
            Image.asset('images/check.png',width: 15, height: 15),

            SizedBox(width: 5),

            Text('이번 사고와 관련하여 최대한 자세하게 적어주세요.', style: TextStyle(color: furtherExplanationColor, fontWeight: FontWeight.bold), softWrap: true)
          ],
        ),
      ),
    );
  }
}
