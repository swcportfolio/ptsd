import 'package:vempire_app/data/rest_response.dart';

/// 교통사고 평가 model class
class Accident{
  String accidentIdx;
  String accidentDate;      // 사고 날짜
  String accidentTime;      // 사고 시간
  String place;             // 사고 장소
  String opponentCarType;   // 상대방 차 종류
  String opponentCarColor;  // 상대방 차 색상
  String direction;         // 부딪힌 방향
  String speed;             // 사고 당시 속도

  Accident({required this.accidentIdx, required this.accidentDate, required this.accidentTime, required this.place,
      required this.opponentCarType, required this.opponentCarColor, required this.direction, required this.speed});

  factory Accident.fromJson(Map<String, dynamic> json) {
    return Accident(
      accidentIdx       : json['accidentIdx'] as String ?? '-',
      accidentDate      : json['accidentDate'] as String ?? '-',
      accidentTime      : json['accidentTime'] as String ?? '-',
      place             : json['place'] as String ?? '-',
      opponentCarType   : json['opponentCarType'] as String ?? '-',
      opponentCarColor  : json['opponentCarColor'] as String ?? '-',
      direction         : json['direction'] as String ?? '-',
      speed             : json['speed'] as String ?? '-',
    );
  }

  static List<Accident> parse(RestResponseList responseBody) {
    return responseBody.data.map<Accident>((json) => Accident.fromJson(json)).toList();
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Accident &&
          runtimeType == other.runtimeType &&
          accidentIdx == other.accidentIdx &&
          accidentDate == other.accidentDate &&
          accidentTime == other.accidentTime &&
          place == other.place &&
          opponentCarType == other.opponentCarType &&
          opponentCarColor == other.opponentCarColor &&
          direction == other.direction &&
          speed == other.speed;

  @override
  int get hashCode =>
      accidentIdx.hashCode ^
      accidentDate.hashCode ^
      accidentTime.hashCode ^
      place.hashCode ^
      opponentCarType.hashCode ^
      opponentCarColor.hashCode ^
      direction.hashCode ^
      speed.hashCode;
}