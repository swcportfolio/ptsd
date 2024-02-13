import 'package:flutter/material.dart';
import 'package:vempire_app/data/authorization.dart';
import 'package:vempire_app/data/result_list.dart';
import 'package:vempire_app/utils/dio_client.dart';
import 'package:vempire_app/widgets/list_item.dart';

/// IES-R-K 결과 리스트 화면
class IESRKResultListPage extends StatefulWidget {

  @override
  _IESRKResultListPageState createState() => _IESRKResultListPageState();
}

class _IESRKResultListPageState extends State<IESRKResultListPage> {

  final _scrollController = ScrollController();
  List<IESRKResultList> _resultListData = []; // 서버로부터 가져온 IES-R-K List

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: client.getIESRKResultList(Authorization().userID),
          builder: (context, snapshot)
          {
            if(snapshot.hasError){
              return Container(
                  child: Center(
                      child: Text(snapshot.error.toString().replaceFirst('Exception: ', ''),
                          style: TextStyle(color: Colors.black, fontSize: 10.0))));
            }

            if (!snapshot.hasData) {
              return Container(
                  child: Center(
                      child: SizedBox(height: 40.0, width: 40.0,
                          child: CircularProgressIndicator(strokeWidth: 5))));
            }

            if (snapshot.connectionState == ConnectionState.done) {
              _resultListData = snapshot.data!;
            }

            if (_resultListData.isEmpty) {
              return Center(child: Text('결과 내역이 없습니다.', textScaleFactor: 0.96));
            }
            else {
              return Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: ListView.builder(
                      controller: _scrollController,
                      itemCount: _resultListData.length,
                      itemBuilder: (BuildContext context, int index) {
                        return IESRKResultItem(_resultListData[index]);
                      }
                      ));
            }
          }
      )
    );
  }
}


