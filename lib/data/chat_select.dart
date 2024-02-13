import 'package:vempire_app/data/authorization.dart';

/// Chat Selected data class
class ChatSelect{

  String? userIdx;
  int? questionNo;
  String? answerNo;
  String? answerMessage;

  ChatSelect({this.userIdx, this.questionNo, this.answerNo, this.answerMessage});

  Map<String, dynamic> toIESRKMap(String userIdx){
    Map<String,dynamic> toMap ={
      'userIdx'       : userIdx,
      'userID'        : Authorization().userID,
      'questionNo'    : questionNo,
      'answerNo'      : answerNo,
    };
    return toMap;
  }

  Map<String, dynamic> toPTSDMap(String userIdx, int accidentIdx){
    Map<String,dynamic> toMap ={
      'accidentIdx'   : accidentIdx,
      'userIdx'       : userIdx,
      'userID'        : Authorization().userID,
      'questionNo'    : questionNo.toString(),
      'answerNo'      : answerNo,
      "answerMessage" : answerMessage,
    };
    return toMap;
  }


}