import 'package:flutter/material.dart';
import 'package:vempire_app/data/grid_view_property.dart';
import 'package:vempire_app/data/sign_grid_data.dart';
import 'package:vempire_app/utils/color.dart';
import 'package:vempire_app/utils/constants.dart';
import 'package:vempire_app/utils/dio_client.dart';
import 'package:vempire_app/utils/edit_controller.dart';
import 'package:vempire_app/utils/etc.dart';
import 'package:vempire_app/utils/frame.dart';
import 'package:vempire_app/validates/validate.dart';
import 'package:vempire_app/widgets/button.dart';
import 'package:vempire_app/widgets/grid_view_%20item.dart';
import 'package:vempire_app/widgets/edit.dart';
import 'package:flutter/cupertino.dart';
import 'package:vempire_app/widgets/popup_dialog.dart';


/// 회원가입 화면
class SignUpPage extends StatefulWidget {

  final VoidCallback signResultMsg; // 회원가입 완료 CallBack Function
  SignUpPage({required this.signResultMsg});

  @override
  SignUpPageState createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {

  final String title = '회원 가입';

  final editSignCnt = SignEdit();
  GridViewData gridViewData = GridViewData();
  GridViewSignProperty _gridViewProperty = GridViewSignProperty();

  List <bool> commonTrue = [false, false, false]; // 0.동거 형태, 1.직업, 2.종교

  bool isPossibleID = false; // 사용가능한 아이디
  var alreadyCheckedID;      // 중복체크 2번이상

  late IconData errorIcon = Icons.error_outline_sharp;              // password error icon
  late Color errorColor = Colors.white;                // password  error 색상
  late double errorPassContainerHeight = 0; // password  오류 text 높이
  late String errorText = '';           // password  error text



  // 화면 사이즈
  var size;
  late double itemHeight, itemWidth;

  @override
  Widget build(BuildContext context) {

    size = MediaQuery.of(context).size;
    itemHeight = size.height < 700 ? ((size.height+30) - kToolbarHeight) : (size.height - kToolbarHeight);
    itemWidth = size.width > 500 ?  size.width/4 : size.width/1.9;

          return WillPopScope(
            onWillPop: () async {
              /// AppBar 왼쪽 상단 뒤로가기 버튼 클릭 시
              /// 회원가입 절차중 아이디 중복검사 이후 뒤로 가기 했을때 서버 데이터 삭제
              if (editSignCnt.idController.text.isNotEmpty)
              {
                Map<String, dynamic> data = {
                  'userID': editSignCnt.idController.text
                };

                String meg = await client.deleteTempUser(data);
                print('>>>> [deleteTempUser] : ' + meg.toString());
              }
              return Future(() => true);
            },
            child: Scaffold(
              backgroundColor: Colors.white,
                appBar: Frame.doAppBar(title),

                body: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus(); // 키보드 내리기
                  },
                  child: Center(
                    child: Scrollbar(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(30, 1, 30, 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children:
                            [
                              Row(
                                children:
                                [
                                  Expanded(child: SignInputEdit(controller: editSignCnt.idController, iconData: Icons.account_box, headText: '아이디 (*필수)', hint: '아이디 6자 이상 입력해주세요.', type: 'id')),

                                  Padding(padding: const EdgeInsets.only(left: 10, top: 28),
                                    child: SizedBox(height: 45, width: 70,
                                        child: TextButton(
                                            style: TextButton.styleFrom(backgroundColor: mainColor, elevation: 1),
                                            onPressed: () async
                                            {
                                              _canUseID(); // 입력한 ID 중복 체크
                                            },
                                            child: Text('중복확인', textScaleFactor: 0.8, style: TextStyle(color: Colors.white)))),
                                  )
                                ],
                              ),
                              _buildPassInputEdit('비밀번호 (*필수)', Icons.vpn_key, '특수, 대소문자, 숫자 포함 8자~15자 입력하세요.', false, editSignCnt.passController),
                              _buildPassInputEdit('비밀번호 확인 (*필수)', Icons.vpn_key, '비밀번호를 재 입력해주세요.', true, editSignCnt.pass2Controller),

                              SignInputEdit(controller: editSignCnt.nameController, iconData: Icons.assignment_outlined, headText: '이름 (*필수)', hint: '이름를 입력해주세요.', type: 'name'),
                              SignInputEdit(controller: editSignCnt.emailController, iconData: Icons.mail, headText: '이메일 (*필수)', hint: '이메일을 입력해주세요.', type: 'email'),
                              SizedBox(height: 30),

                              SignSelectInputEdit(controller: editSignCnt.ageController, iconData: Icons.contact_page, headText: '나이', hint: '나이를 입력해주세요.', type: 'number'),
                              SignSelectInputEdit(controller: editSignCnt.educationController, iconData: Icons.school, headText: '교육정도', hint: '교육정도(년수)를 입력해주세요.', type: 'number'),
                              SizedBox(height: 20),

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

                              /// 회원가입 버튼
                              SignButton(text: '회원 가입', signEdit: editSignCnt, signResultMsg: () => widget.signResultMsg(), isPossibleID: isPossibleID, gridViewData:gridViewData),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
            ),
          );
  }

  /// 아이디 중복 체크
  _canUseID() {
    if (editSignCnt.idController.text.isEmpty) {
      PopUpDialog.dialog('아이디 확인', '아이디가 비어 있습니다.', context);
    }
    else if (alreadyCheckedID != editSignCnt.idController.text) {
      CheckValidate().validateID(editSignCnt.idController.text, context).then((value) =>
      {
        setState(() {
          print('>>> [isPossibleID] : '+value.toString());
          isPossibleID = value;
          alreadyCheckedID = editSignCnt.idController.text;
        })
      });
    }
    else {
      PopUpDialog.dialog('아이디 확인', '이미 중복체크한 아이디입니다.', context);
    }
  }

  /// 비밀번호 자동 일치 체크 method
  _buildPassInputEdit(String headText, IconData iconData, String hint, bool isViewPoint, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Padding(
          padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
          child: Text(headText, textScaleFactor: 1.0, style: TextStyle(fontWeight: FontWeight.bold)),
        ),

        Container(
            alignment: Alignment.centerLeft,
            height: 60.0,
            child: MediaQuery(
              data: Etc.getScaleFontSize(context, fontSize: 0.7),
              child: TextField(autofocus: false, obscureText: true, controller: controller, keyboardType: TextInputType.text, style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    border:  OutlineInputBorder(borderRadius: const BorderRadius.all(const Radius.circular(3.0))),
                    contentPadding: EdgeInsets.only(top: 0.0),
                    fillColor: Colors.red,
                    hoverColor: mainColor,
                    prefixIcon: Icon(iconData, color: mainColor),
                    hintText: hint,
                    hintStyle: TextStyle(color: Colors.grey)),
                onChanged: (text)
                {
                  if (editSignCnt.passController.text.isNotEmpty && editSignCnt.pass2Controller.text.isNotEmpty) {
                    if (editSignCnt.passController.text != editSignCnt.pass2Controller.text) {
                      setState(() {
                        errorPassContainerHeight = 35.0;
                        errorIcon = Icons.error_outline_sharp;
                        errorText = '위 비밀번호와 다릅니다.';
                        errorColor = Colors.red;
                      });
                    } else {
                      setState(() {
                        errorPassContainerHeight = 35.0;
                        errorIcon = Icons.check_circle_outline;
                        errorText = '비밀번호가 일치합니다.';
                        errorColor = Colors.lightBlue;
                      });
                    }
                  }}
                  ))
        ),

        Visibility(
            visible: isViewPoint,
          child: Container(
              height: errorPassContainerHeight,
              child: Row(
                children:
                [
                  Icon(errorIcon, size: 20.0, color: errorColor),
                  Padding(padding: EdgeInsets.only(left: 5.0),
                      child: Text(errorText, textScaleFactor: 0.8, style: TextStyle(color: errorColor)))
                ]
              ))
        ),

      ],
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

  /// GridView widget method
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
}