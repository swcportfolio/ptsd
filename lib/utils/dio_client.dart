import 'package:dio/dio.dart';
import 'package:vempire_app/data/accident_data.dart';
import 'package:vempire_app/data/chat_answers.dart';
import 'package:vempire_app/data/chat_response.dart';
import 'package:vempire_app/data/body_default.dart';
import 'package:vempire_app/data/profile.dart';
import 'package:vempire_app/data/rest_response.dart';
import 'package:vempire_app/data/result_list.dart';
import 'package:vempire_app/utils/constants.dart';
import 'custom_log_interceptor.dart';

Client client = Client();

class Client {

  Dio _createDio() {
    Dio dio = Dio();

    //dio.interceptors.add(CustomLogInterceptor());
    dio.options.connectTimeout = Duration(seconds: 7);
    dio.options.receiveTimeout = Duration(seconds: 7);

    dio.options.headers = {
      'Content-Type': 'application/json',
     //'Authorization': authorizationToken
    };

    return dio;
  }


  /// 로그인 dio
  Future<DefaultStatus> dioLogin(Map<String, dynamic> data) async
  {
    DefaultStatus defaultStatus = DefaultStatus();
    late Response response;
    try {
      response = await _createDio().post(API_URL_LOGIN, data: data);

      if (response.statusCode == 200)
      {
        defaultStatus = DefaultStatus.fromJson(RestResponseStatus.fromJson(response.data));

        if(defaultStatus.code == '200' || defaultStatus.code == 'ERR_LOGIN')
        {
         return defaultStatus;
        }
        else{ // 그 외 error code
          print(' >>> [Status Error Code & Message] :  ${defaultStatus.code} / ${defaultStatus.message}');
        }
      }
      else {
        print(' >>> [Login Response statusCode] : ' + response.statusCode.toString());
        print(' >>> [Login Response statusMessage] : ' + response.statusMessage.toString());

        if (response.statusCode == 500) throw Exception(MESSAGE_SERVER_ERROR_DEFAULT);
        else throw Exception(MESSAGE_ERROR_CONNECT_SERVER);
      }
    } on DioError catch (e) { print(e.toString());
    throw Exception(MESSAGE_ERROR_CONNECT_SERVER);
    } catch (e) { print(e.toString()); }

    return DefaultStatus(code: response.statusCode.toString(), message: defaultStatus.message ?? response.statusMessage.toString());
  }


  /// 특정 유저 정보 dio
  Future<Profile> getUserData(String userID) async
  {
    Profile profile = Profile();
    late Response response;

    try {
      response = await _createDio().get(API_URL_USER_GET, queryParameters: {'userID': userID});

      if (response.statusCode == 200)
      {
        profile = Profile.fromJson(RestResponseDefault.fromJson(response.data));

        if(profile.code == '200' || profile.code == 'ERR_MS_4003')
        {
          return profile;
        }
        else{ // 그 외 error code
          print(' >>> [profile Error Code & Message] :  ${profile.code} /  ${profile.message}');
        }
      }
      else {
        print(' >>> [Login Response statusCode] : ' + response.statusCode.toString());
        print(' >>> [Login Response statusMessage] : ' + response.statusMessage.toString());

        if (response.statusCode == 500) throw Exception(MESSAGE_SERVER_ERROR_DEFAULT);
        else throw Exception(MESSAGE_ERROR_CONNECT_SERVER);
      }
    } on DioError catch (e) {print(e.toString());
      throw Exception(MESSAGE_ERROR_CONNECT_SERVER);
    } catch (e) {
      print(e.toString());
    }
    return Profile(code: response.statusCode.toString(), message: profile.message ?? response.statusMessage.toString());
  }


  /// 회원가입 dio
  Future<DefaultStatus> dioSign(Map<String, dynamic> data) async
  {
    DefaultStatus defaultStatus = DefaultStatus();
    late Response response;


    try {
      response = await _createDio().post(API_URL_USER_INSERT, data: data);

      if (response.statusCode == 200)
      {
        defaultStatus = DefaultStatus.fromJson(RestResponseStatus.fromJson(response.data));

        if(defaultStatus.code == '200' || defaultStatus.code == 'ERR_DUPLICATED_ID')
        {
          return defaultStatus;
        }
        else{ // 그 외 error code
          print(' >>> [Status Error Code & Message] :  ${defaultStatus.code} / ${defaultStatus.message}');
        }
      }
      else {
        print(' >>> [Sign Response statusCode] : ' + response.statusCode.toString());
        print(' >>> [Sign Response statusMessage] : ' + response.statusMessage.toString());

        if (response.statusCode == 500) throw Exception(MESSAGE_SERVER_ERROR_DEFAULT);
        else throw Exception(MESSAGE_ERROR_CONNECT_SERVER);
      }
    } on DioError catch (e) { print(e.toString());
    throw Exception(MESSAGE_ERROR_CONNECT_SERVER);
    } catch (e) { print(e.toString()); }

    return DefaultStatus(code: response.statusCode.toString(), message: defaultStatus.message ?? response.statusMessage.toString());
  }


  /// 아이디 중복 체크 dio
  Future<DefaultStatus> duplicatedId(String  userID) async
  {
    late Response response;
    DefaultStatus defaultStatus = DefaultStatus();

    try {
      response = await _createDio().get(API_URL_USER_DUPLICATE, queryParameters: {'userID': userID});

      if (response.statusCode == 200)
      {
        defaultStatus = DefaultStatus.fromJson(RestResponseStatus.fromJson(response.data));

        if(defaultStatus.code == '200' || defaultStatus.code == 'ERR_DUPLICATED_ID')
        {
          return defaultStatus;
        }
        else{ // 그 외 error code
          print(' >>> [Status Error Code & Message] :  ${defaultStatus.code} / ${defaultStatus.message}');
        }
      }
      else {
        print(' >>> [Sign Response statusCode] : ' + response.statusCode.toString());
        print(' >>> [Sign Response statusMessage] : ' + response.statusMessage.toString());

        if (response.statusCode == 500) throw Exception(MESSAGE_SERVER_ERROR_DEFAULT);
        else throw Exception(MESSAGE_ERROR_CONNECT_SERVER);
      }
    } on DioError catch (e) { print(e.toString());
    throw Exception(MESSAGE_ERROR_CONNECT_SERVER);
    } catch (e) { print(e.toString()); }

    return DefaultStatus(code: response.statusCode.toString(), message: defaultStatus.message ?? response.statusMessage.toString());
  }


  /// 아이디 찾기 dio
  Future<DefaultStatus> findIDDio(String name, String mail) async
  {
    late Response response;
    DefaultStatus defaultStatus = DefaultStatus();

    try {
      response = await _createDio().get(API_URL_USER_FIND_ID, queryParameters: {'name': name, 'mail': mail});

      if (response.statusCode == 200)
      {
        defaultStatus = DefaultStatus.fromJson(RestResponseStatus.fromJson(response.data));

        if(defaultStatus.code == 'INFO_FIND_ID' || defaultStatus.code == 'INFO_NOT_FIND_ID')
        {
          return defaultStatus;
        }
        else{ // 그 외 error code
          print(' >>> [Status Error Code & Message] :  ${defaultStatus.code} / ${defaultStatus.message}');
        }
      }
      else {
        print(' >>> [findID Response statusCode] : ' + response.statusCode.toString());
        print(' >>> [findID Response statusMessage] : ' + response.statusMessage.toString());

        if (response.statusCode == 500) throw Exception(MESSAGE_SERVER_ERROR_DEFAULT);
        else throw Exception(MESSAGE_ERROR_CONNECT_SERVER);
      }
    } on DioError catch (e) { print(e.toString());
    throw Exception(MESSAGE_ERROR_CONNECT_SERVER);
    } catch (e) { print(e.toString()); }

    return DefaultStatus(code: response.statusCode.toString(), message: defaultStatus.message ?? response.statusMessage.toString());
  }


  /// 비밀번호 찾기 dio
  Future<DefaultStatus> findPassDio(String userID, String name, String mail) async
  {
    late Response response;
    DefaultStatus defaultStatus = DefaultStatus();

    try {
       response = await _createDio().get(API_URL_USER_FIND_PASS, queryParameters: {'userID': userID, 'name': name, 'mail': mail});

      if (response.statusCode == 200)
      {
        defaultStatus = DefaultStatus.fromJson(RestResponseStatus.fromJson(response.data));

        if(defaultStatus.code == '201' || defaultStatus.code == 'INFO_NOT_FIND_ID')
        {
          return defaultStatus;
        }
        else{ // 그 외 error code
          print(' >>> [Status Error Code & Message] :  ${defaultStatus.code} / ${defaultStatus.message}');
        }
      }
      else {
        print(' >>> [findPwd Response statusCode] : ' + response.statusCode.toString());
        print(' >>> [findPwd Response statusMessage] : ' + response.statusMessage.toString());

        if (response.statusCode == 500) throw Exception(MESSAGE_SERVER_ERROR_DEFAULT);
        else throw Exception(MESSAGE_ERROR_CONNECT_SERVER);
      }
    } on DioError catch (e) { print(e.toString());
    throw Exception(MESSAGE_ERROR_CONNECT_SERVER);
    } catch (e) { print(e.toString()); }

    return DefaultStatus(code: response.statusCode.toString(), message: defaultStatus.message ?? response.statusMessage.toString());
  }


  /// 교통사고 정보 이력 조회 dio
  Future<List<Accident>> getAccidentData(String userID) async
  {
    List<Accident> resultList = [];

    try {
      Response response = await _createDio().get(API_URL_ACCIDENT_GET, queryParameters: {'userID': userID});

      if (response.statusCode == 200){
        if (response.data['status']['code'] == '200') {
          resultList = Accident.parse(RestResponseList.fromJson(response.data));
          return resultList;
        }
        else{ // 그 외 error code
          print(' >>> [Accident Error Code & Message] :  '
              '${response.data['status']['code']} /  ${response.data['status']['message']}');
        }
      }
      else{
        print(' >>> [Accident List Response statusCode] : ' + response.statusCode.toString());
        print(' >>> [Accident List Response statusMessage] : ' + response.statusMessage.toString());

        if (response.statusCode == 500) throw Exception(MESSAGE_SERVER_ERROR_DEFAULT);
        else throw Exception(MESSAGE_ERROR_CONNECT_SERVER);
      }

    } on DioError catch (e) {
      print(e.toString());
      throw Exception(MESSAGE_ERROR_CONNECT_SERVER);
    } catch (e) { print(e.toString()); }
    return resultList;
  }


  /// 교통사고 사고 평가 정보  dio
  Future<int> dioEvaluation(Map<String, dynamic> data) async
  {
    late Response response;
    try {
      response = await _createDio().post(API_URL_ACCIDENT_INFO, data: data);

      if (response.statusCode == 200) {
        if (response.data['status']['code'] == '200') {
          if (response.data['status']['message'] == 'Success') {
            return response.data['data'];
          }
        }
        else {
          return -1;
        }
      }
      else{
        print(' >>> [findPwd Response statusCode] : ' + response.statusCode.toString());
        print(' >>> [findPwd Response statusMessage] : ' + response.statusMessage.toString());

        if (response.statusCode == 500) throw Exception(MESSAGE_SERVER_ERROR_DEFAULT);
        else throw Exception(MESSAGE_ERROR_CONNECT_SERVER);
      }
    } on DioError catch (e) { print(e.toString());
    throw Exception(MESSAGE_ERROR_CONNECT_SERVER);
    } catch (e) { print(e.toString()); }
    return -1;
  }


  /// IES-R-K Chat Data dio
  Future<ChatResponse> dioIESRKChat(Map<String, dynamic> data) async
  {
    ChatResponse chatResponse = ChatResponse();

    try {
      Response response = await Dio().post(API_URL_CHAT_IESRK_TEST, data: data);

      if (response.statusCode == 200) {

        if (response.data['status']['code'] == '200')
        {
          List<ChatAnswersIESRK> chatAnswersData = ChatAnswersIESRK.parse(RestResponseChat.fromJson(response.data)); // answers list data 파싱
          chatResponse = ChatResponse.fromJson(RestResponseChat.fromJson(response.data));                            // data body 파싱
          chatResponse.chatAnswersListIESRK = chatAnswersData;

          return chatResponse;
        }
        else{ // 그 외 error code
          print(' >>> [IESRK Error Code & Message] :  '
              '${response.data['status']['code']} /  ${response.data['status']['message']}');
        }

      } else{
        print(' >>> [ISERK Response statusCode] : ' + response.statusCode.toString());
        print(' >>> [ISERK Response statusMessage] : ' + response.statusMessage.toString());

        if (response.statusCode == 500) throw Exception(MESSAGE_SERVER_ERROR_DEFAULT);
        else throw Exception(MESSAGE_ERROR_CONNECT_SERVER);
      }
    } on DioError catch (e) { print(e.toString());
    throw Exception(MESSAGE_ERROR_CONNECT_SERVER);
    } catch (e) {
      print(e.toString());
    }

    return chatResponse;
  }


  ///  PTSD chat data dio
  Future<ChatResponse> dioPTSDChat(Map<String, dynamic> data) async
  {
    List<ChatAnswersPTSD> chatAnswersData = [];
    ChatResponse chatResponse = ChatResponse();
    try {
      Response response = await _createDio().post(API_URL_CHAT_PTSD_TEST, data: data);

      if (response.statusCode == 200) {

        if (response.data['status']['code'] == '200')
        {
          chatAnswersData = ChatAnswersPTSD.parse(RestResponseChat.fromJson(response.data));  // answers 파싱값
          chatResponse = ChatResponse.fromJson(RestResponseChat.fromJson(response.data));     // data 파싱값
          chatResponse.chatAnswersListPTSD = chatAnswersData;

          return chatResponse;
        }
        else{ // 그 외 error code
          print(' >>> [PTSD Error Code & Message] :  '
              '${response.data['status']['code']} /  ${response.data['status']['message']}');
        }
      }
      else{
        print(' >>> [PTSD Response statusCode] : ' + response.statusCode.toString());
        print(' >>> [PTSD Response statusMessage] : ' + response.statusMessage.toString());

        if (response.statusCode == 500) throw Exception(MESSAGE_SERVER_ERROR_DEFAULT);
        else throw Exception(MESSAGE_ERROR_CONNECT_SERVER);
        }
      } on DioError catch (e) { print(e.toString());
      throw Exception(MESSAGE_ERROR_CONNECT_SERVER);
    } catch (e) {
      print(e.toString());
    }

    return chatResponse;
  }

  /// IES-R-K  결과 리스트 dio
  Future<List<IESRKResultList>> getIESRKResultList(String userID) async
  {
    List<IESRKResultList> resultList = [];

    try {
      Response response = await _createDio().get(API_URL_IESRK_LIST, queryParameters: {'userID': userID});

      if (response.statusCode == 200) {

        if (response.data['status']['code'] == '200') {
          resultList = IESRKResultList.parse(RestResponseList.fromJson(response.data));
          return resultList;
        }
        else{ // 그 외 error code
          print(' >>> [IESRK List Error Code & Message] :  '
              '${response.data['status']['code']} /  ${response.data['status']['message']}');
        }
      }
      else{
        print(' >>> [IESRK Response statusCode] : ' + response.statusCode.toString());
        print(' >>> [IESRK Response statusMessage] : ' + response.statusMessage.toString());

        if (response.statusCode == 500) throw Exception(MESSAGE_SERVER_ERROR_DEFAULT);
        else throw Exception(MESSAGE_ERROR_CONNECT_SERVER);
      }
    } on DioError catch (e) { print(e.toString());
    throw Exception(MESSAGE_ERROR_CONNECT_SERVER);
    } catch (e) {
      print(e.toString());
    }
    return resultList;
  }

  /// PTSD 결과 리스트 dio
  Future<List<PTSDResultList>> getPTSDResultList(String userID) async
  {
    List<PTSDResultList> resultList = [];

    try {
      Response response = await _createDio().get(API_URL_PTSD_LIST, queryParameters: {'userID': userID});

      if (response.statusCode == 200) {

        if (response.data['status']['code'] == '200') {
          resultList = PTSDResultList.parse(RestResponseList.fromJson(response.data));
          return resultList;
        }
        else{ // 그 외 error code
          print(' >>> [PTSD List Error Code & Message] :  '
              '${response.data['status']['code']} /  ${response.data['status']['message']}');
        }
      }
      else{
        print(' >>> [PTSD Response statusCode] : ' + response.statusCode.toString());
        print(' >>> [PTSD Response statusMessage] : ' + response.statusMessage.toString());

        if (response.statusCode == 500) throw Exception(MESSAGE_SERVER_ERROR_DEFAULT);
        else throw Exception(MESSAGE_ERROR_CONNECT_SERVER);
      }
    } on DioError catch (e) { print(e.toString());
    throw Exception(MESSAGE_ERROR_CONNECT_SERVER);
    } catch (e) {
      print(e.toString());
    }
    return resultList;
  }

  /// 회원 개인정보 업데이트
  Future<DefaultStatus> dioUpdate(Map<String, dynamic> data) async {

    DefaultStatus defaultStatus = DefaultStatus();
    late Response response;

    try {
      response = await Dio().post(API_URL_USER_UPDATE, data: data);
      if (response.statusCode == 200)
      {
        defaultStatus = DefaultStatus.fromJson(RestResponseStatus.fromJson(response.data));

        if (defaultStatus.code == '200' || defaultStatus.code == 'ERR_MS_6002') {
          return defaultStatus;
        }
        else{ // 그 외 error code
          print(' >>> [Status Error Code & Message] :  ${defaultStatus.code} / ${defaultStatus.message}');
        }
      }
      else {
        print(' >>> [Update Response statusCode] : ' + response.statusCode.toString());
        print(' >>> [Update Response statusMessage] : ' + response.statusMessage.toString());

        if (response.statusCode == 500) throw Exception(MESSAGE_SERVER_ERROR_DEFAULT);
        else throw Exception(MESSAGE_ERROR_CONNECT_SERVER);
      }
    } on DioError catch (e) { print(e.toString());
    throw Exception(MESSAGE_ERROR_CONNECT_SERVER);
    } catch (e) {
      print(e.toString());
    }

    return DefaultStatus(code: response.statusCode.toString(), message: defaultStatus.message ?? response.statusMessage.toString());
  }

  /// 패스워드 변경 dio
  Future<DefaultStatus> passUpdateDio(Map<String, dynamic> data) async {
    DefaultStatus defaultStatus = DefaultStatus();
    late Response response;

    try {
      Response response = await Dio().post('$API_PREFIX/private/user/updatepwd', data: data);

      if (response.statusCode == 200) {
        defaultStatus = DefaultStatus.fromJson(RestResponseStatus.fromJson(response.data));

        if (defaultStatus.code == '200' || defaultStatus.code == 'ERR_MS_6002') {
          return defaultStatus;
        }
        else{ // 그 외 error code
          print(' >>> [Status Error Code & Message] :  ${defaultStatus.code} / ${defaultStatus.message}');
        }
      }
      else {
        print(' >>> [Update Response statusCode] : ' + response.statusCode.toString());
        print(' >>> [Update Response statusMessage] : ' + response.statusMessage.toString());

        if (response.statusCode == 500) throw Exception(MESSAGE_SERVER_ERROR_DEFAULT);
        else throw Exception(MESSAGE_ERROR_CONNECT_SERVER);
      }
    } on DioError catch (e) { print(e.toString());
    throw Exception(MESSAGE_ERROR_CONNECT_SERVER);
    } catch (e) {
      print(e.toString());
    }

    return DefaultStatus(code: 'error', message: 'error');
  }

  // 회원 탈퇴 dio
  Future<String> deleteUser(Map<String, dynamic> data) async {

    try {
      Response response = await Dio().post(API_URL_USER_DELETE, data: data);

      if (response.statusCode == 200) {
        print(response.statusCode);
        print('Data Check'+response.data['status']['code'].toString());

        if (response.data['status']['code'] == '200') {
          print(response.data['status']['message']);

          return response.data['status']['message'];
        } else {
          print('response data error');
        }
      } else {
        print('checkSign Response statusCode ::' +
            response.statusCode.toString());
        print('checkSign Response statusMessage ::' +
            response.statusMessage.toString());
      }
    } on DioError catch (e) {
      print(e.toString());
      throw Exception('서버 연결 오류');
    } catch (e) {
      print(e.toString());
    }
    return '';
  }

  /// 회원가입 중복 선택 DB 삭제 dio
  Future<String> deleteTempUser(Map<String, dynamic> data) async {
    try {

      Response response = await Dio().post(API_URL_USER_DELETE_TEMP, data: data);

      if (response.statusCode == 200) {
        print(response.statusCode);
        print('Data Check'+response.data['status']['code'].toString());

        if (response.data['status']['code'] == '200') {
          print(response.data['status']['message']);

          return response.data['status']['message'];
        } else {
          print('response data error');
        }
      } else {
        print('checkSign Response statusCode ::' +
            response.statusCode.toString());
        print('checkSign Response statusMessage ::' +
            response.statusMessage.toString());
      }
    } on DioError catch (e) {
      print(e.toString());
      throw Exception('서버 연결 오류');
    } catch (e) {
      print(e.toString());
    }
    return '';
  }

}