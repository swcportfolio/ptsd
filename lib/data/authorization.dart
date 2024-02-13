
/// 권한 계정 클래스
class Authorization{
  late String userID;
  late String password;
  late String email;
  late String name;

 static final Authorization _authInstance = Authorization.internal();

  factory Authorization() {
    return _authInstance;
  }

  Authorization.internal(){
     userID  = '';
     password = '';
     email = '';
     name = '';
  }

  /// clean method
  clean(){
    userID = '';
    password = '';
    email = '';
    name = '';
  }

}