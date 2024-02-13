
import 'package:vempire_app/data/rest_response.dart';

/// IES-R-K 결과 리스트 클래스
class IESRKResultList{
  String createDT;
  int hyper;
  int avoidance;
  int intrusion;
  int sleepNumbness;
  int total;


  IESRKResultList({
    required this.createDT,
      required this.hyper,
      required this.avoidance,
      required this.intrusion,
      required this.sleepNumbness,
      required this.total});

  factory IESRKResultList.fromJson(Map<String, dynamic> json) {
    return IESRKResultList(
      createDT      : json['createDT'],
      hyper         : int.parse(json['analysis_hyperarousal'].toString()),
      avoidance     : int.parse(json['analysis_avoidance'].toString()),
      intrusion     : int.parse(json['analysis_intrusion'].toString()),
      sleepNumbness : int.parse(json['analysis_sleepNumbness'].toString()),
      total         : int.parse(json['analysis_total'].toString()),
    );
  }

  static List<IESRKResultList> parse(RestResponseList responseBody) {
    return responseBody.data.map<IESRKResultList>((json) => IESRKResultList.fromJson(json)).toList();
  }
}

class PTSDResultList{
  String createDT;
  String type;

  PTSDResultList({required this.createDT, required this.type});

  factory PTSDResultList.fromJson(Map<String, dynamic> json) {
    return PTSDResultList(
      createDT  : json['createDT'] as String,
      type      : json['analysis_type'] as String,
    );
  }

  static List<PTSDResultList> parse(RestResponseList responseBody) {
    return responseBody.data.map<PTSDResultList>((json) => PTSDResultList.fromJson(json)).toList();
  }
}