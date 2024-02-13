
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vempire_app/data/authorization.dart';
import 'package:vempire_app/data/grid_view_property.dart';
import 'package:vempire_app/data/profile.dart';
import 'package:vempire_app/data/sign_grid_data.dart';
import 'package:vempire_app/utils/constants.dart';
import 'package:vempire_app/utils/dio_client.dart';
import 'package:vempire_app/utils/edit_controller.dart';
import 'package:vempire_app/utils/etc.dart';
import 'package:vempire_app/utils/frame.dart';
import 'package:vempire_app/widgets/button.dart';
import 'package:vempire_app/widgets/grid_view_%20item.dart';
import 'package:vempire_app/widgets/edit.dart';

/// 개인정보 수정 화면
class PersonalInfoChangePage extends StatefulWidget {

  PersonalInfoChangePage();

  @override
  _PersonalInfoChangePageState createState() => _PersonalInfoChangePageState();
}

class _PersonalInfoChangePageState extends State<PersonalInfoChangePage> {

  final String title = '개인정보 변경';

  Profile _profile = Profile();
  final  editSignCnt  = SignEdit();  // 개인정보 수정 입력 edit

  bool jobTrue = false;
  bool religionTrue = false;
  bool cohabitationTrue = false;

  List <bool> commonTrue = [false, false, false]; // 0.동거 형태, 1.직업, 2.종교

  GridViewData gridViewData = GridViewData();
  GridViewSignProperty _gridViewProperty = GridViewSignProperty();

  // 화면 사이즈
  var size;
  late double itemHeight, itemWidth;
  bool isNotState = true;

  @override
  Widget build(BuildContext context) {

    size = MediaQuery.of(context).size;
    itemHeight = size.height<700? ((size.height+30) - kToolbarHeight) : (size.height - kToolbarHeight);
    itemWidth = size.width > 500 ?  size.width/4 : size.width/1.9;

    return Scaffold(
      appBar: Frame.doAppBar(title),
      body:  FutureBuilder(
          future: client.getUserData(Authorization().userID) ,
          builder: (context, snapshot){

            if(snapshot.hasError) {
              return Container(
                  child: Center(
                      child: Text(snapshot.error.toString().replaceFirst('Exception: ', ''),
                          style: TextStyle(color: Colors.black, fontSize: 15.0))));
            }

            if(!snapshot.hasData) {
              return Container(
                  child: Center(
                      child: SizedBox(height: 40.0, width: 40.0,
                          child: CircularProgressIndicator(strokeWidth: 5))));
            }

            if (snapshot.connectionState == ConnectionState.done) {
              if(isNotState) {
                _profile = snapshot.data!;

                if(_profile.code == '200')
                {
                  loadProfileData();
                }
                else if(_profile.message == MESSAGE_NOT_EXIST_RESULT)
                {
                  Etc.showSnackBar(MESSAGE_NOT_EXIST_RESULT, context);
                }
                else{
                  Etc.showSnackBar(MESSAGE_SERVER_ERROR_DEFAULT, context);
                }
              }
              isNotState = false;
            }

            return  GestureDetector(
              onTap: (){
                FocusScope.of(context).unfocus();
              },
              child: Scrollbar(
                child: Center(
                  child: Scrollbar(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(30, 1, 30, 30),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:
                          [
                            SignInputEdit(controller: editSignCnt.emailController, iconData: Icons.mail, headText: '이메일 (*필수)', hint: '이메일을 입력해주세요.', type: 'email'),

                            SignInputEdit(controller: editSignCnt.nameController, iconData: Icons.assignment_outlined, headText: '이름', hint: '이름를 입력해주세요.', type: 'name'),

                            SizedBox(height: 30),

                            SignSelectInputEdit(controller: editSignCnt.ageController, iconData: Icons.contact_page, headText: '나이', hint: '나이를 입력해주세요.', type: 'number'),

                            SignSelectInputEdit(controller: editSignCnt.educationController, iconData: Icons.school, headText: '교육정도', hint: '교육정도(년수)를 입력해주세요.', type: 'number'),

                            SizedBox(height: 30),

                            /// 성별
                            _gridViewOneLess(GridName.gender, _gridViewProperty.genderNames, _gridViewProperty.isGender),
                            SizedBox(height: 20),

                            /// 결혼
                            _gridViewOneLess(GridName.married, _gridViewProperty.marriageNames, _gridViewProperty.isMarriage),
                            SizedBox(height: 20),

                            /// 동거
                            _gridViewOneLess(GridName.familyYN, _gridViewProperty.familyYNNames, _gridViewProperty.isFamilyYN),
                            Visibility(visible: commonTrue[0], // 동거 형태
                                child: Padding(padding: const EdgeInsets.fromLTRB(7, 0, 7, 30),
                                    child: InputEdit(controller: editSignCnt.familiesCntController, iconData: Icons.wc_outlined, hint: '같이 사는 가족의 수를 입력해주세요.', type: 'familiesCnt'))
                            ),
                            SizedBox(height: 27),

                            /// 직업
                            _gridViewOneLess(GridName.jobYN, _gridViewProperty.jobNames, _gridViewProperty.isJob),
                            Visibility(visible: commonTrue[1], // 직업
                              child: Padding(padding: const EdgeInsets.fromLTRB(7, 0, 7, 30),
                                  child: InputEdit(controller: editSignCnt.jobController, iconData: Icons.account_balance, hint: '직업을 선택해 주세요.', type: 'job')),
                            ),
                            SizedBox(height: 20),

                            /// 종교
                            _gridViewOneLess(GridName.religionYN, _gridViewProperty.religionNames, _gridViewProperty.isReligion),
                            Visibility(visible: commonTrue[2], // 종교
                                child: Padding(padding: const EdgeInsets.fromLTRB(7, 0, 7, 30),
                                    child: InputEdit(controller: editSignCnt.religionController, iconData: Icons.album_outlined, hint: '종교를 입력해주세요.', type: 'religion'))
                            ),

                            UpdateButton(text: '회원정보 수정', signGrid: gridViewData, signEdit: editSignCnt),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          })
      );
  }

  /// headText/crossAxisCount/itemCount
  /// (성별/2/2), (결혼상태/3/6), (동거/2/2), (직업/2/2), (종교/2/2)에 사용된다.
  /// Visibility inputText widget : 동거, 직업, 종교 (유) 선택 시에만 활성화 된다.
  /// @param headText : 제목 및 식별자
  /// @param gridCardNameList : gridview item 에 들어가는 이름 리스트
  /// @param isList : gridview item 상태값 리스트(bool)
  _gridViewOneLess(String headText, List<String> gridCardNameList, List<bool> isList){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(headText, textScaleFactor:1.0, style: TextStyle(fontWeight: FontWeight.bold)),
        Container(
            padding: const EdgeInsets.fromLTRB(0, 7, 0, 10),
            child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: headText == '결혼' ? 110 : 50, // 결혼상태의 경우 행이 2개, 나머지 1개
                child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: gridCardNameList.length,
                    itemBuilder: (BuildContext context, int index)
                    {
                      String name = gridCardNameList[index];

                      return GestureDetector(
                          onTap: () {
                            setState(() {
                              FocusScope.of(context).unfocus();

                              if (isList[index]) {  // 클릭 후 활성화된 gridview -> 비 활성화로 전환
                                isList[index] = false;
                                classifySelectDataByHeadText(headText, '');
                              }
                              else { // gridview 활성화로 전환
                                for(int i=0 ; i<isList.length ; i++){
                                  if(index != i){
                                    isList[i] = false;
                                  }
                                }

                                isList[index] = true;
                                classifySelectDataByHeadText(headText, gridCardNameList[index]);

                                if(headText == '동거' || headText == '직업' || headText == '종교'){
                                  if(name == gridCardNameList[1]){
                                    _visActivation(headText, true);
                                  }
                                  else{
                                    _visActivation(headText, false);
                                  }
                                }
                              }

                            });
                          },
                          child: _classifyViewItem(headText, name, isList, index)
                      );
                    },
                    gridDelegate: headText == '결혼' ? SliverGridDelegateWithFixedCrossAxisCount( // width 500 이 넘어가면 Tap 으로 인식
                        crossAxisCount: 3, crossAxisSpacing: 0.0, childAspectRatio: size.width > 800? ((itemHeight-300)/ (itemWidth-90)) : size.width > 500 ? ((itemHeight-300)/ (itemWidth)) : ((itemHeight-230)/ (itemWidth+50))) :
                    SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2)))
        ),
      ],
    );
  }

  /// GridView widget
  _classifyViewItem(String headText, String name, List<bool> isList, int index){
    switch(headText){
      case GridName.gender     : return GridViewItem.buildGenderGridViewItem(name, isList[index]); break;
      case GridName.married    : return GridViewItem.buildGridViewItem(name, isList[index]); break;
      case GridName.familyYN   : return GridViewItem.buildGridViewItem(name, isList[index]); break;
      case GridName.jobYN      : return GridViewItem.buildGridViewItem(name, isList[index]); break;
      case GridName.religionYN : return GridViewItem.buildGridViewItem(name, isList[index]); break;
    }
  }

  /// headText 기준으로 선핵한 데이터 set
  void classifySelectDataByHeadText(String headText, String selectData) {
    switch(headText){
      case GridName.gender     : gridViewData.gender = selectData; break;
      case GridName.married    : gridViewData.married = selectData; break;
      case GridName.familyYN   : gridViewData.familyYN = selectData; break;
      case GridName.jobYN      : gridViewData.jobYN = selectData; break;
      case GridName.religionYN : gridViewData.religionYN = selectData; break;
    }
  }

  /// Visibility 활성화 및 비활성화 method
  /// 동거, 직업, 종교
  void _visActivation(String headText, bool value) {
    switch(headText){
      case GridName.familyYN: {
        if(value){
          commonTrue[0] = value;
        }
        else{
          commonTrue[0] = value;
          editSignCnt.familiesCntController.text = ''; // false 일때 입력했던 familiesCnt 값을 초기회 해준다.
        }
        break;
      }
      case GridName.jobYN: {
        if(value){
          commonTrue[1] = value;
        }
        else{
          commonTrue[1] = value;
          editSignCnt.jobController.text = ''; // false 일때 입력했던 job 값을 초기회 해준다.
        }
        break;
      }
      case GridName.religionYN: {
          if(value){
            commonTrue[2] = value;
          }
          else{
            commonTrue[2] = value;
            editSignCnt.religionController.text = ''; // false 일때 입력했던 religion 값을 초기회 해준다.
          }
          break;
        }
    }
  }

  /// 개인 정보 불러오기
  void loadProfileData() {
    editSignCnt.nameController.text       = _profile.name!;
    editSignCnt.ageController.text        = _profile.age.toString();
    editSignCnt.educationController.text  = _profile.education!;
    editSignCnt.emailController.text      = _profile.mail!;

    setAuth();
    setGender();
    setMarriage();
    setFamilyYN();
    setJob();
    setReligion();
  }

  /// 성별 결정
  void setGender()
  {
    if(_profile.gender == '남자'){
      _gridViewProperty.isGender[0] = true;
      gridViewData.gender = _gridViewProperty.genderNames[0];
    }
    else if(_profile.gender == '여자'){
      _gridViewProperty.isGender[1] = true;
      gridViewData.gender = _gridViewProperty.genderNames[1];
    }
  }

  /// 결혼 상태 결정
  void setMarriage()
  {
    if(_profile.married == '기혼') {
      _gridViewProperty.isMarriage[0] = true;
      gridViewData.married = _gridViewProperty.marriageNames[0];
    }
    else if(_profile.married == '미혼'){
      _gridViewProperty.isMarriage[1] = true;
      gridViewData.married =  _gridViewProperty.marriageNames[1];
    }
    else if(_profile.married == '배우자 사망'){
      _gridViewProperty.isMarriage[2] = true;
      gridViewData.married =  _gridViewProperty.marriageNames[2];
    }
    else if(_profile.married == '별거'){
      _gridViewProperty.isMarriage[3] = true;
      gridViewData.married =  _gridViewProperty.marriageNames[3];
    }
    else if(_profile.married == '이혼'){
      _gridViewProperty.isMarriage[4] = true;
      gridViewData.married =  _gridViewProperty.marriageNames[4];
    }
    else if(_profile.married == '재혼'){
      _gridViewProperty.isMarriage[5] = true;
      gridViewData.married =  _gridViewProperty.marriageNames[5];
    }
  }

  /// 동거 결정
  void setFamilyYN()
  {
    if(_profile.familyYN == '독거'){
      _gridViewProperty.isFamilyYN[0] = true;
      gridViewData.familyYN = _gridViewProperty.familyYNNames[0];
    }
    else if(_profile.familyYN == '동거'){
      _gridViewProperty.isFamilyYN[1] = true;
      gridViewData.familyYN = _gridViewProperty.familyYNNames[1];
      commonTrue[0] = true;

      editSignCnt.familiesCntController.text = _profile.familiesCnt!;
    }
  }

  void setJob() {
    if(_profile.jobYN == '무'){
      _gridViewProperty.isJob[0] = true;
      gridViewData.jobYN = _gridViewProperty.jobNames[0];
    }
    else if(_profile.jobYN == '유'){
      _gridViewProperty.isJob[1] = true;
      gridViewData.jobYN = _gridViewProperty.jobNames[1];
      commonTrue[1] = true;

      editSignCnt.jobController.text = _profile.jobName!;
    }
  }

  /// 종교 결정
  void setReligion(){
    if(_profile.religionYN == '무'){
      _gridViewProperty.isReligion[0] = true;
      gridViewData.religionYN = _gridViewProperty.religionNames[0];
    }
    else if(_profile.religionYN == '유'){
      _gridViewProperty.isReligion[1] = true;
      gridViewData.religionYN = _gridViewProperty.religionNames[1];
      commonTrue[2] = true;

      editSignCnt.religionController.text = _profile.religionName!;
    }
  }

  void setAuth(){
    editSignCnt.idController.text   = Authorization().userID;
    editSignCnt.passController.text = Authorization().password;
  }
}

