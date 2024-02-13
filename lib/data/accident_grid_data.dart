
/// 교통사고 평가 데이터 클래스
class AccidentGridData{
  String headText;            // 제목
  double height;              // 높이
  List<String> girdNameList;
  List<bool> isGrid;
  String typeName;
  int crossAxisCount;

  AccidentGridData(this.headText, this.height,
      this.girdNameList, this.isGrid, this.typeName, this.crossAxisCount);
}