
/// GridView 최종 데이터
class SelectedGridData{
  String? accidentType = '';     // 사고 유형
  String? carType = '';          // 본인 차량 유형
  String? opponentCarType = '';  // 상대방 차량 유형
  String? weather = '';          // 날씨
  String? direction = '';        // 사고 방향
  String? admissionYN = '';      // 입원
  String? hurtHeadYN = '';       // 머리
  String? memoryYN = '';         // 상황
  String? legalMatterYN = '';    // 법적

  SelectedGridData(
      { this.accidentType,
       this.carType,
       this.opponentCarType,
       this.weather,
       this.direction,
       this.admissionYN,
       this.hurtHeadYN,
       this.memoryYN,
       this.legalMatterYN});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SelectedGridData &&
          runtimeType == other.runtimeType &&
          accidentType == other.accidentType &&
          carType == other.carType &&
          opponentCarType == other.opponentCarType &&
          weather == other.weather &&
          direction == other.direction &&
          admissionYN == other.admissionYN &&
          hurtHeadYN == other.hurtHeadYN &&
          memoryYN == other.memoryYN &&
          legalMatterYN == other.legalMatterYN;

  @override
  int get hashCode =>
      accidentType.hashCode ^
      carType.hashCode ^
      opponentCarType.hashCode ^
      weather.hashCode ^
      direction.hashCode ^
      admissionYN.hashCode ^
      hurtHeadYN.hashCode ^
      memoryYN.hashCode ^
      legalMatterYN.hashCode;
}