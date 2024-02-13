/// 회원가입 선택지 데이터 클래스
class GridViewData{
  late String gender;        // 성별
  late String married;       // 결혼
  late String familyYN;      // 동거
  late String jobYN;         // 직업 유무
  late String religionYN;    // 종교 유무

  clean(){
    gender = '';
    married = '';
    familyYN = '';
    jobYN = '';
    religionYN = '';
  }
}