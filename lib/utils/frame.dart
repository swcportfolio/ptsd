import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'color.dart';

/// 프레임 클래스
class Frame {

  /// 공통 Appbar
  static  doAppBar(String title) {
    return AppBar(
      iconTheme: IconThemeData(color: Colors.white),
      backgroundColor: mainColor,
      title: Text(title, textScaleFactor: 0.9, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      centerTitle: true,
      elevation: 0.0,
    );
  }

  /// 가로 줄
  static solidLine(BuildContext context){
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: Container(
        width: MediaQuery.of(context).size.width-20,
        height: 1.0,
        color: Colors.grey,
      ),
    );
  }

  /// 큰 사이즈 로고
  static doLogo(BuildContext context, double height){
    return
      Container(
        width: MediaQuery.of(context).size.width,
        child: Center(
            child: Image.asset('images/bi.png', height: 100, width: height/1.5)),
      );
  }

  /// Navigator 화면 이동
  static doPagePush(BuildContext context, Widget page){
    return Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  /// Navigator 화면 이동, 바로 이전 화면 1개는 스택에서 없앰.
  static doPagePushReplace(context, Widget page) {
      return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => page));
  }

  /// Navigator 화면 이동, 이전 화면 모두 삭제후 이동
  static doPageAndRemoveUntil(context, Widget page) {
      return Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context) => page), (route) => false);
  }

  /// Universal 화면이동
  static Future<void> doLaunchUniversalLink(String url, BuildContext context) async {
    final bool nativeAppLaunchSucceeded = await launch(
      url,
      forceSafariVC: false,
      universalLinksOnly: false);

    print(' >>>> [nativeAppLaunchSucceeded] : '+nativeAppLaunchSucceeded.toString());

    if (!nativeAppLaunchSucceeded) {
      await launch(url, forceSafariVC: true,);
    }
  }

}