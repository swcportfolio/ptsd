import 'package:flutter/material.dart';
import 'package:vempire_app/data/tab_bar.dart';
import 'package:vempire_app/page/result/iesrk_list_page.dart';
import 'package:vempire_app/page/result/ptsd_list_page.dart';
import 'package:vempire_app/utils/color.dart';
import 'package:vempire_app/utils/frame.dart';

/// 결과 리스트 화면 [IES-R-K, PTSD]
class ResultListPage extends StatefulWidget {

  @override
  _ResultListPageState createState() => _ResultListPageState();
}

class _ResultListPageState extends State<ResultListPage> {

  final String title = '결과 리스트';
  final choices = [ChoiceTapBar(text:'IES-R-K 결과'), ChoiceTapBar(text:'PTSD 결과')];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: choices.length,
      child: Scaffold(
        appBar: Frame.doAppBar(title),

        body: DefaultTabController(
          length: choices.length,
          child: Column(
            children: [

              Container(
                constraints: BoxConstraints.expand(height: 50),
                child: TabBar(
                    indicator: UnderlineTabIndicator(borderSide: BorderSide(width: 1.6), insets: EdgeInsets.symmetric(horizontal: 20.0)),
                    indicatorColor: subTitleColor,
                    unselectedLabelColor: Colors.grey,
                    labelColor: subTitleColor,
                    tabs: [
                      Tab(child: Text('IES-R-K 결과', textScaleFactor: 1.0)),

                      Tab(child:Text('PTSD 결과', textScaleFactor: 1.0)),
                    ]
                ),
              ),

              Expanded(
                child: Container(
                  child: TabBarView(
                      children: [
                        IESRKResultListPage(),

                        PTSDResultListPage()
                      ]
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
