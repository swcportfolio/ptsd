import 'package:flutter/material.dart';
import 'package:vempire_app/page/checkup/iesrk_chat_page.dart';
import 'package:vempire_app/page/login/login_page.dart';
import 'package:vempire_app/page/checkup/checkup_main_page.dart';
import 'package:vempire_app/page/main/main_page.dart';
import 'package:vempire_app/utils/color.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/authorization.dart';


Future<void> main() async {
  String? userID;
  String? password;
  String? email;
  String? name;

  WidgetsFlutterBinding.ensureInitialized(); // 플랫폼 채널의 위젯 바인딩을 보장해야한다.

  var pref = await SharedPreferences.getInstance();
  userID = pref.getString('userID');

  if(userID != null) {
    password  = pref.getString('password');
    name      = pref.getString('name');
    email     = pref.getString('email');

    print( ' >>>> [userID] : '+userID+' >>>> [password] :'+ password!  );

    Authorization().userID = userID;
    Authorization().password = password;
    Authorization().name = name!;
    Authorization().email = email!;
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  final themeData = ThemeData();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme:Theme.of(context).copyWith(
        colorScheme: themeData.colorScheme.copyWith(primary: mainColor),
        primaryTextTheme: themeData.textTheme.apply(fontFamily: 'nanum_square')
      ),
      initialRoute: '/',
      routes: {
        '/'               :(context) => MainPage(),
        'login_page'      :(context) => LoginPage(),
        'Diagnosis_page'  :(context) => CheckUpMainPage(),
        'chat_page'       :(context) => IESRKChatPage(),
      },
    );
  }
}




