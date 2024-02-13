
import 'package:flutter/material.dart';
import 'package:vempire_app/data/selected_grid_data.dart';
import 'package:vempire_app/utils/edit_controller.dart';
import 'package:vempire_app/utils/etc.dart';
import 'package:vempire_app/widgets/popup_dialog.dart';

/// 교통 사고 입력 유효성 확인 클래스
class AccidentValidate{

  /// 교통사고 입력 데이터 확인
  static bool checkAccidentValue(AccidentEdit accidentEdit, SelectedGridData selectedGridData, BuildContext context)
  {
    if(selectedGridData.accidentType!.isEmpty)
    {
      PopUpDialog.dialog('사고 정보 입력','사고 유형을 선택 해주세요.', context);
      return false;
    }
    else if(selectedGridData.carType!.isEmpty)
    {
      PopUpDialog.dialog('사고 정보 입력','자동차 종류를 선택 해주세요.', context);
      return false;
    }
    else if(accidentEdit.myCarColorController.text.isEmpty)
    {
      PopUpDialog.dialog('사고 정보 입력','자신의 차량 색상 작성란이 비어\n있습니다.', context);
      return false;
    }
    else if(selectedGridData.opponentCarType!.isEmpty)
    {
      PopUpDialog.dialog('사고 정보 입력','상대방 자동차 종류를 선택 해주세요.', context);
      return false;
    }
    else if(accidentEdit.opponentCarColorController.text.isEmpty)
    {
      PopUpDialog.dialog('사고 정보 입력','상대방의 차량 색상 작성란이 비어\n있습니다.', context);
      return false;
    }
    else if(accidentEdit.dateController.text.isEmpty)
    {
      PopUpDialog.dialog('사고 정보 입력','사고 날짜 작성란이 비어있습니다.', context);
      return false;
    }
    else if(accidentEdit.timeController.text.isEmpty)
    {
      PopUpDialog.dialog('사고 정보 입력','사고 시간 작성란이 비어있습니다.', context);
      return false;
    }
    else if(accidentEdit.speedController.text.isEmpty)
    {
      PopUpDialog.dialog('사고 정보 입력','사고 속도 작성란이 비어있습니다.', context);
      return false;
    }
    else if(accidentEdit.spaceController.text.isEmpty)
    {
      PopUpDialog.dialog('사고 정보 입력','사고 장소 작성란이 비어있습니다.', context);
      return false;
    }
    else if(selectedGridData.weather!.isEmpty)
    {
      PopUpDialog.dialog('사고 정보 입력','사고 당시 날씨를 선택 해주세요.', context);
      return false;
    }
    else if(selectedGridData.direction!.isEmpty)
    {
      PopUpDialog.dialog('사고 정보 입력','상대방과 부딪힌 방향을 선택 해주세요.', context);
      return false;
    }
    else if(selectedGridData.admissionYN!.isEmpty)
    {
      PopUpDialog.dialog('사고 정보 입력','입원 여부를 선택 해주세요.', context);
      return false;
    }
    else if(selectedGridData.hurtHeadYN!.isEmpty){
      PopUpDialog.dialog('사고 정보 입력','머리다친 여부를 선택 해주세요.', context);
      return false;
    }
    else if(selectedGridData.memoryYN!.isEmpty)
    {
      PopUpDialog.dialog('사고 정보 입력','상황기억을 선택 해주세요.', context);
      return false;
    }
    else if(selectedGridData.legalMatterYN!.isEmpty)
    {
      PopUpDialog.dialog('사고 정보 입력','법적문제 여부를 선택 해주세요.', context);
      return false;
    }
    else{
      return true;
    }
  }
}