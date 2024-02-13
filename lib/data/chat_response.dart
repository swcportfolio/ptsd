import 'package:vempire_app/data/rest_response.dart';

import 'chat_answers.dart';

/// chat Response model class
class ChatResponse{
  String? userIdx;
  String? questionNo;
  String? questionMessage;
  String? answerType;
  List<ChatAnswersIESRK>? chatAnswersListIESRK = [];
  List<ChatAnswersPTSD>? chatAnswersListPTSD = [];

  ChatResponse({this.userIdx, this.questionNo, this.questionMessage, this.answerType});

  factory ChatResponse.fromJson(RestResponseChat responseBody){
    return ChatResponse(
      userIdx          : responseBody.data['userIdx'] as String ?? '-',
      questionNo       : responseBody.data['questionNo'] as String ?? '-',
      questionMessage  : responseBody.data['questionMessage'] as String ?? '-',
      answerType       : responseBody.data['answerType'] as String ?? '-',
    );
  }
}