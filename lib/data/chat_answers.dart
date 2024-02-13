import 'package:vempire_app/data/rest_response.dart';

/// IES-R-k Answer model class
class ChatAnswersIESRK{
  String answerNo;

  ChatAnswersIESRK({required this.answerNo});

  factory ChatAnswersIESRK.fromJson(Map<String, dynamic> json) {
    return ChatAnswersIESRK(
      answerNo      : json['answerNo'] as String ?? '-',
    );
  }

  static List<ChatAnswersIESRK> parse(RestResponseChat responseBody) {
    return responseBody.answers.map<ChatAnswersIESRK>((json) => ChatAnswersIESRK.fromJson(json)).toList();
  }
}

/// PTSD Answer Data class
class ChatAnswersPTSD{
  String answerNo;
  String answerMessage;

  ChatAnswersPTSD({required this.answerNo, required this.answerMessage});

  factory ChatAnswersPTSD.fromJson(Map<String, dynamic> json) {
    return ChatAnswersPTSD(
      answerNo      : json['answerNo'] as String ?? '-',
      answerMessage : json['answerMessage'] as String ?? '-',
    );
  }

  static List<ChatAnswersPTSD> parse(RestResponseChat responseBody) {
    return responseBody.answers.map<ChatAnswersPTSD>((json) => ChatAnswersPTSD.fromJson(json)).toList();
  }
}