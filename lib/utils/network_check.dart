// import 'package:connectivity/connectivity.dart';
// import 'package:flutter/material.dart';
// import 'etc.dart';
//
// /// 네트워크 연결 상태 확인
// class CheckNetworkConnection{
//
//   Future<ConnectivityResult> checkConnectionStatus() async
//   {
//     var result = await (Connectivity().checkConnectivity());
//     return result;
//   }
//
//   /// 연결된 네트워크 체크
//   void checkNetWork(BuildContext context) async
//   {
//     var result = await checkConnectionStatus();
//
//     if (result == ConnectivityResult.mobile) {
//       print('>>>> [NetWork] : '+'Mobile Network');
//     }
//
//     else if (result == ConnectivityResult.wifi) {
//       print('>>>> [NetWork] : '+'Wifi Network');
//     }
//
//     else{
//       print('>>>> [NetWork] : '+'네트워크 연결 필요');
//       Etc.showSnackBar('네트워크를 확인해 주세요.', context);
//     }
//
//   }
// }