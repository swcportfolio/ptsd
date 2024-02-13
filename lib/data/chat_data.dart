import 'chat_answers.dart';

/// chat message item data class
class ChatData {
  String? questionNo;      // 질문 문항
  String? message;         // 질문
  String? answerType;      // 응답타입
  String? messageType;     // 질문 메시지 타입
  List<ChatAnswersIESRK>? chatAnswersListIESRK = []; // IES-R-K 응답지 리스트
  List<ChatAnswersPTSD>? chatAnswersListPTSD = [];   // PTSD 응답지 리스트

  ChatData({this.questionNo, this.message, this.answerType, this.messageType, this.chatAnswersListIESRK, this.chatAnswersListPTSD});

  @override
  String toString() {
    return 'ChatData{questionNo: $questionNo, message: $message, answerType: $answerType, messageType: '
        '$messageType, chatAnswersListIESRK: $chatAnswersListIESRK, chatAnswersListPTSD: $chatAnswersListPTSD}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChatData &&
          runtimeType == other.runtimeType &&
          questionNo == other.questionNo &&
          message == other.message &&
          answerType == other.answerType &&
          messageType == other.messageType &&
          chatAnswersListIESRK == other.chatAnswersListIESRK &&
          chatAnswersListPTSD == other.chatAnswersListPTSD;

  @override
  int get hashCode =>
      questionNo.hashCode ^
      message.hashCode ^
      answerType.hashCode ^
      messageType.hashCode ^
      chatAnswersListIESRK.hashCode ^
      chatAnswersListPTSD.hashCode;
}
