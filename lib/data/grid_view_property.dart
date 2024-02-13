
/// 회원가입 GirdView property class
class GridViewSignProperty{
  // 성별
  List<String> genderNames = [ '남자', '여자' ];
  List<bool> isGender  = [ false, false ];

  // 결혼 상태
  List<String> marriageNames   = [ '기혼', '미혼', '배우자 사망', '별거', '이혼', '재혼' ];
  List<bool> isMarriage  = [ false, false, false, false, false, false ];

  // 동거형태
  List<String> familyYNNames = [ '독거', '동거' ];
  List<bool> isFamilyYN = [ false, false, ];

  //직업
  List<String> jobNames = [ '무', '유' ];
  List<bool> isJob     = [ false, false ];

  //종교
  List<String> religionNames = [ '무', '유' ];
  List<bool> isReligion  = [ false, false ];

}

/// 교통사고 평가 GridView property class
class GridViewEvaluation{

  // 사고유형
  List<String> accidentTypeNames  = [ '운전자', '동승자' ];
  List<bool> isAccidentType     = [ false, false ];

  // 자동차 종류 및 색상
  List<String> colorAndTypeNames  = [ '승용차', '트럭', '경운기' ];
  List<bool> isColorAndType     = [ false, false, false ];

  //상대방 차량 종류 및 색상
  List<String> opponentColorAndTypeNames  = [ '승용차', '트럭', '경운기', '오토바이'];
  List<bool> isOpponentColorAndType     = [ false, false, false, false ];

  // 사고 당시 날씨
  List<String> weatherNames  = [ '맑음', '흐림', '비', '눈'];
  List<bool> isWeather     = [ false, false, false, false ];

  // 상대방과 부딪친 방향
  List<String> directionNames = [ '정면', '후면', '상대방 후면', '왼쪽', '오른쪽'];
  List<bool> isDirection    = [ false, false, false, false, false];

  // 입원
  List<String> admissionNames = [ '예', '아니요'];
  List<bool> isAdmission    = [ false, false];

  // 머리 다쳤는지?
  List<String> hurtTheHeadNames = [ '예', '아니요'];
  List<bool> isHurtTheHea     = [ false, false];

  // 사고 당시 상황 기억
  List<String> situationMemoryNames  = [ '예', '아니요'];
  List<bool> isSituationMemory     = [ false, false];

  // 법적문제가 남아있는가?
  List<String> legalMatterNames  = [ '예', '아니요'];
  List<bool> isLegalMatter     = [ false, false];

}
