import 'package:flutter/material.dart';
import 'package:vempire_app/data/tab_bar.dart';
import 'package:vempire_app/page/main/psychological_page.dart';
import 'package:vempire_app/utils/color.dart';
import 'package:vempire_app/utils/frame.dart';
import 'learn_page.dart';

/// 교통사고 PTSD 바로알기 메인화면
/// sub menu [심리교육, PTSD 알아보기]
class FindOutPage extends StatefulWidget {

  @override
  _FindOutPageState createState() => _FindOutPageState();
}

class _FindOutPageState extends State<FindOutPage> {

  final String title = '교통사고 PTSD 바로알기';
  final choices = [ChoiceTapBar(text:'심리교육'), ChoiceTapBar(text:'PTSD 알아보기')];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
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
                      Tab(child: Text('심리교육',textScaleFactor: 1.0)),

                      Tab(child:Text('PTSD 알아보기',textScaleFactor: 1.0)),
                    ]
                ),
              ),

              Expanded(
                child: Container(
                  child: TabBarView(
                      children:
                      [
                        PsychologicalPage(), // 심리교육 화면

                        LearnPage(), // PTSD 알아보기
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
