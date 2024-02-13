
import 'package:vempire_app/data/rest_response.dart';

/// member profile model class
class Profile{
  String? code;
  String? message;
  String? userID;
  String? name;
  int? age;
  String? gender;
  String? married;
  String? familyYN;
  String? familiesCnt;
  String? jobName;
  String? jobYN;
  String? education;
  String? monthlyIncome;
  String? religionYN;
  String? religionName;
  String? mail;

  Profile({ this.code,  this.message,  this.userID,  this.name,  this.age,  this.gender,  this.married,  this.familyYN,
     this.familiesCnt,  this.jobName,  this.jobYN,  this.education,  this.monthlyIncome,  this.religionYN,  this.religionName,  this.mail});

  factory Profile.fromJson(RestResponseDefault responseBody) {
    return Profile(
      code             : responseBody.status['code'] ,
      message          : responseBody.status['message'] ,
      userID           : responseBody.data['userID'] ,
      name             : responseBody.data['name'] ,
      age              : int.parse(responseBody.data['age'].toString()),
      gender           : responseBody.data['gender'] ,
      married          : responseBody.data['married'],
      familyYN         : responseBody.data['familyYN'] ,
      familiesCnt      : responseBody.data['familiesCnt'] ,
      jobName          : responseBody.data['jobName'] ,
      jobYN            : responseBody.data['jobYN'] ,
      education        : responseBody.data['education'] ,
      monthlyIncome    : responseBody.data['monthlyIncome'] ,
      religionYN       : responseBody.data['religionYN'] ,
      religionName     : responseBody.data['religionName'] ,
      mail             : responseBody.data['mail']

    );
  }

  @override
  String toString() {
    return 'Profile{status: $code, message: $message, userID: $userID, name: $name, age: $age, gender: $gender, married: $married, familyYN: $familyYN, familiesCnt: $familiesCnt, jobName: $jobName, jobYN: $jobYN, education: $education, monthlyIncome: $monthlyIncome, religionYN: $religionYN, religionName: $religionName, mail: $mail}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Profile &&
          runtimeType == other.runtimeType &&
          code == other.code &&
          message == other.message &&
          userID == other.userID &&
          name == other.name &&
          age == other.age &&
          gender == other.gender &&
          married == other.married &&
          familyYN == other.familyYN &&
          familiesCnt == other.familiesCnt &&
          jobName == other.jobName &&
          jobYN == other.jobYN &&
          education == other.education &&
          monthlyIncome == other.monthlyIncome &&
          religionYN == other.religionYN &&
          religionName == other.religionName &&
          mail == other.mail;

  @override
  int get hashCode =>
      code.hashCode ^
      message.hashCode ^
      userID.hashCode ^
      name.hashCode ^
      age.hashCode ^
      gender.hashCode ^
      married.hashCode ^
      familyYN.hashCode ^
      familiesCnt.hashCode ^
      jobName.hashCode ^
      jobYN.hashCode ^
      education.hashCode ^
      monthlyIncome.hashCode ^
      religionYN.hashCode ^
      religionName.hashCode ^
      mail.hashCode;
}