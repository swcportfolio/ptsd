import 'package:flutter/material.dart';
import 'package:vempire_app/data/vertical_bar_chart.dart';
import 'package:vempire_app/data/result_list.dart';
import 'package:vempire_app/utils/color.dart';
import 'package:vempire_app/utils/constants.dart';
import 'package:vempire_app/utils/etc.dart';
import 'package:vempire_app/utils/frame.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

/// IESRK 결과 화면(차트 포함)
class IESRKResultPage extends StatefulWidget {

  final IESRKResultList resultListData;
  IESRKResultPage(this.resultListData);

  @override
  _IESRKResultPageState createState() => _IESRKResultPageState();
}

class _IESRKResultPageState extends State<IESRKResultPage> {

  final String title = 'IES-R-K 검사결과';

  late double hyperarousalValue;
  late double avoidanceValue;
  late double intrusionValue;
  late double sleepNumbnessValue;

  double totalValue = 0.0;  // 환산 후 총점

  late List<VerticalBarChart> _chartData;  // chart data

  late String resultImage;     // 최상단 이미지
  late Color resultColor;      // 결과 내용 컬러
  late String descriptionData; // 하단 설명

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _setChartData(); // 차트 데이터 계산 및 파싱

     _chartData = [
       VerticalBarChart(
           yAxis: '수면 및 미비감\n($sleepNumbnessValue /100점)',
           score: sleepNumbnessValue.toInt(),
           barColor: barGraph
       ),
       VerticalBarChart(
           yAxis: '침투\n($intrusionValue /100점)',
           score: intrusionValue.toInt(),
           barColor: mainColor
       ),
       VerticalBarChart(
           yAxis: '회피\n($avoidanceValue /100점)',
           score: avoidanceValue.toInt(),
           barColor: barGraph
       ),
      VerticalBarChart(
          yAxis: '과각성\n($hyperarousalValue /100점)',
          score: hyperarousalValue.toInt(),
          barColor: mainColor
      ),
     ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Frame.doAppBar(title),

      body: SingleChildScrollView(
        child: Padding(padding: const EdgeInsets.all(10),
          child: Column(
            children:
            [
              Card(
                elevation: 1,
                child: Padding(padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children:
                    [
                      Image.asset('images/${resultImage}'),

                      Text('진단 평점', softWrap: true, textScaleFactor: 1.2),

                      SizedBox(height: 5),

                      Row(mainAxisAlignment: MainAxisAlignment.center,
                        children:
                        [
                          Text('$totalValue/100점', softWrap: true, textScaleFactor: 1.4, style: TextStyle(color: resultColor, fontWeight: FontWeight.bold))
                        ],
                      )
                    ],
                  ),
                ),
              ),

              Container(height: 280,
                child: Card(
                  elevation: 2,
                  child: Padding(padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: MediaQuery(
                            data: Etc.getScaleFontSize(context, fontSize: 0.85),
                            child: SfCartesianChart(
                                primaryXAxis: CategoryAxis(
                                  maximumLabelWidth: 80,
                                ),
                                primaryYAxis: NumericAxis(
                                  minimum: 0,
                                  maximum: 100,
                                ),

                                series: <ChartSeries<VerticalBarChart, String>>[
                                  BarSeries<VerticalBarChart, String>(
                                      dataSource: _chartData,
                                      xValueMapper: (VerticalBarChart barChart, _) => barChart.yAxis,
                                      yValueMapper: (VerticalBarChart barChart, _) => barChart.score,
                                      pointColorMapper: (VerticalBarChart barChart, _) => barChart.barColor,

                                  ),
                                ]
                            )
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),

              Card(
                elevation: 2,
                child: Padding(padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children:
                    [
                      Text(descriptionData+'\n\n$RESULT_COMMON', textScaleFactor: 0.9, style: TextStyle(height: 1.2)),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  /// IES-R-K result data set
  void _setChartData()
  {
    hyperarousalValue  = _setExchange(widget.resultListData.hyper, 24);
    avoidanceValue     = _setExchange(widget.resultListData.avoidance, 24);
    intrusionValue     = _setExchange(widget.resultListData.intrusion, 20);
    sleepNumbnessValue = _setExchange(widget.resultListData.sleepNumbness, 20);
    totalValue         = _setExchange(widget.resultListData.total, 88);

    _setDiagnosis(totalValue);
  }

  /// 환산된 totalValue 를 통해 진단내역 설정
  _setDiagnosis(double totalValue){

    if(totalValue<=19.3)
      {
        descriptionData = RESULT_IESRK_GOOD;
        resultColor = resultGreenColor;
        resultImage ='ptsd_good.png';
      }
    else if(totalValue<=27.2)
      {
        descriptionData = RESULT_IESRK_BAD;
        resultColor = resultYellowColor;
        resultImage ='ptsd_bad.png';
      }
    else
      {
      descriptionData = RESULT_IESRK_VERY_BAD;
      resultColor = resultRedColor;
      resultImage ='ptsd_very_bad.png';
      }

  }

  /// 100분율 환산
 double _setExchange(int realData, int totalScore)
 {
   double exchangeData = (realData*100) / totalScore;
    return double.parse(exchangeData.toStringAsFixed(1)); // 소수점 1번째자리 까지 유효
 }
}

class SalesData {
  SalesData(this.year, this.sales, this.color);
  final String year;
  final double sales;
  final Color color;
}


