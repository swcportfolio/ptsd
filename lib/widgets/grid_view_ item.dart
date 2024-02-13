
import 'package:flutter/material.dart';
import 'package:vempire_app/utils/color.dart';

class GridViewItem{

  static buildGridViewItem(String name, bool isGender){
    return  Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(1),
          child: Card(
            color:  Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0), side:BorderSide(width: 2, color: isGender ? mainColor : grayColorCustom)),
            child: Container(height: 40,
              child: Center(child: Text(name, textScaleFactor:0.8, style: TextStyle(color: isGender ? mainColor : grayColorCustom))),
            ),
          ),
        ),
      ],
    );
  }

  static buildGridViewItemCommon(String name, bool isGender){
    return  Container(
      child: Card(
        color:  Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0),side:BorderSide(width: 2, color: isGender ? mainColor : grayColorCustom)),
        child: Center(child: Text(name, textScaleFactor: 0.8, style: TextStyle(color: isGender ? mainColor : grayColorCustom))),
      ),
    );
  }

  // 성별
  static buildGenderGridViewItem(String name, bool isGender){
    return  Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(1),
          child: Card(
            color:  Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0),side:BorderSide(width:2, color: isGender ? mainColor : grayColorCustom)),
            child: Container(height: 40,
              child: Center(child: Image.asset(name == '남자'? 'images/icon_man.png' : 'images/icon_woman.png', color: isGender ? mainColor : grayColorCustom,height: 30,width: 30,)

              ),
            ),
          ),
        ),
      ],
    );
  }

  /// 날씨
  static buildWeatherGridViewItem(String name, bool isGender){
    return  Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(1),
          child: Card(
            color:  Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0),side:BorderSide(width:2, color: isGender ? mainColor : grayColorCustom)),
            child: Container(height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:
                [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Image.asset('images/${setWeather(name)}', color: isGender ? mainColor : grayColorCustom),
                  ),
                  SizedBox(width: 5),
                  Text(name, textScaleFactor:0.8, style: TextStyle(color: isGender ? mainColor : grayColorCustom)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  // 채팅 선택지
  static buildChatGridViewItem(String name, bool isSelectColor){
    return  Card(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5),side:BorderSide(
          width: 1.5,
          color: isSelectColor? mainColor: Colors.grey,
        )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(name, textScaleFactor: 0.86, style: TextStyle(color: isSelectColor? mainColor: Colors.grey, fontWeight: FontWeight.bold)),
          ],
        )
    );
  }

  static String setWeather(String name) {
    if(name == '맑음') return 'sunny.png';
    else if(name == '흐림') return 'cloudy.png';
    else if(name == '비') return 'rain.png';
    else if(name == '눈') return 'snow.png';
    else if(name == '안개') return 'fog.png';
    else return 'uu.png';
  }
}