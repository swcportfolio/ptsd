import 'package:flutter/material.dart';
import 'package:vempire_app/data/tab_bar.dart';
import 'package:vempire_app/page/main/purpose_page.dart';
import 'package:vempire_app/page/main/technique_page.dart';
import 'package:vempire_app/page/main/stress_bucket_page.dart';
import 'package:vempire_app/utils/color.dart';
import 'package:vempire_app/utils/frame.dart';

/// 안정화 기법 화면
class HealingPage extends StatefulWidget {

  @override
  _HealingPageState createState() => _HealingPageState();
}

class _HealingPageState extends State<HealingPage> {

  final String title = '교통사고 PTSD 치료';
  final choices = [ChoiceTapBar(text: '목적'), ChoiceTapBar(text: '안정화 기법'), ChoiceTapBar(text: '스트레스 버킷 모델')];

  @override
  Widget build(BuildContext context) {
    return
      DefaultTabController(
        length: choices.length,
        child: Scaffold(
          appBar: Frame.doAppBar(title),

          body: DefaultTabController(
            length: choices.length,
            child: Column(
              children:
              [
                Container(
                  constraints: BoxConstraints.expand(height: 50),
                  child: TabBar(
                      indicatorColor: subTitleColor,
                      unselectedLabelColor: Colors.grey,
                      labelColor: subTitleColor,
                      tabs:
                      [
                        Tab(child: Text('목적', textScaleFactor: 1.0)),

                        Tab(child: Text('안정화 기법', textScaleFactor: 1.0)),

                        Tab(child: Text('스트레스 버킷\n모델', textScaleFactor: 1.0, textAlign: TextAlign.center,)),
                      ]
                  ),
                ),

                Expanded(
                  child: Container(
                    child: TabBarView(
                        children:
                        [
                          PurposePage(), // 목적 화면

                          StabilizeTechniquePage(),  // 안정화 기법 화면

                          StressBucketPage(),        // 스트레스 버킷 모델 화면
                        ]),
                  ),
                )
              ],
            ),
          ),
        ),
      );
  }
}
