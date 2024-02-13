
/// Default Rest Response class
class RestResponseDefault {
  Map<String, dynamic> status;
  Map<String, dynamic> data;

  RestResponseDefault({required this.status, required this.data});

  factory RestResponseDefault.fromJson(Map<String, dynamic> json) {
    return RestResponseDefault(
        status: json['status'] as Map<String, dynamic>,
        data: json['data'] as Map<String, dynamic>
    );
  }
}

/// Default Rest Response class
/// only status
class RestResponseStatus {

  Map<String, dynamic> status;
  RestResponseStatus({required this.status});

  factory RestResponseStatus.fromJson(Map<String, dynamic> json) {
    return RestResponseStatus(
      status: json['status'] as Map<String, dynamic>,
    );
  }
}

/// IES-R-k, PTSD Chat RestResponse class
class RestResponseChat {

  Map<String, dynamic> data;
  List<dynamic> answers;

  RestResponseChat({required this.data, required this.answers});

  factory RestResponseChat.fromJson(Map<String, dynamic> json) {
    return RestResponseChat(
        data     : json['data'] as Map<String, dynamic>,
        answers  : json['data']['answers'] as List<dynamic>
    );
  }
}

/// List Rest Response class
class RestResponseList {
  Map<String, dynamic> status;
  List<dynamic> data;

  RestResponseList({required this.status, required this.data});

  factory RestResponseList.fromJson(Map<String, dynamic> json) {
    return RestResponseList(
        status: json['status'] as Map<String, dynamic>,
        data: json['data'] as List<dynamic>
    );
  }
}



