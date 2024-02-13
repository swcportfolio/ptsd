
import 'constants.dart';

/// GridView item Resize class
class GridChildAspectRatio{

  /// 사고 평가 화면 : GridView Widget Column
  /// 2행 이상 (날씨, 상대방과 부딪힌 방향) && (itemCount >= 4)에서 사용
  /// @request _column2ndRowGridView()
 static double convertAccident2ndRow(String gridName, var size, double itemHeight, double itemWidth)
 {   /// 상대방과 부딪힌 방향 gridview Screen width(1.800이상, 2.500이상 , 3. 500 미만)
    return
      gridName == GridName.direction ? ( size.width > 800? ((itemHeight-300)/ (itemWidth-100)) : size.width > 700 ? ((itemHeight-210)/ (itemWidth)) : size.width > 500 ? ((itemHeight-300)/itemWidth) : ((itemHeight-300)/itemWidth)) :
      gridName == GridName.weather ?  size.width > 800? (itemHeight/(itemWidth-120)) : size.width > 700 ? ((itemHeight)/ (itemWidth-30)) : (itemHeight/itemWidth): (itemHeight/itemWidth);
  }

 /// 사고 평가 화면 : GridView Widget Column
 /// convertAccident2ndRow 이외
 static double convertAccident1ndRow(String gridName, var size, double itemHeight, double itemWidth)
 {    /// Screen width(1.800이상, 2.500이상 , 3. 500 미만)
   return (size.width > 900? ((itemHeight-300)/ (itemWidth-140)) : size.width > 700 ? ((itemHeight)/ (itemWidth-20)) : size.width > 500 ? ((itemHeight-100)/ (itemWidth)) : ((itemHeight+100)/ (itemWidth+30)));
 }


}