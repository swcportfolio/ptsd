import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vempire_app/data/authorization.dart';
import 'package:vempire_app/data/chat_data.dart';
import 'package:vempire_app/data/chat_response.dart';
import 'package:vempire_app/data/chat_select.dart';
import 'package:vempire_app/widgets/chat_message_item_iesrk.dart';
import 'package:vempire_app/utils/color.dart';
import 'package:vempire_app/utils/constants.dart';
import 'package:vempire_app/utils/dio_client.dart';
import 'package:vempire_app/utils/frame.dart';

/// 교통사고 IES-R-K 검사 화면
class  IESRKChatPage extends StatefulWidget {

  @override
  _IESRKChatPageState createState() => _IESRKChatPageState();
}

class _IESRKChatPageState extends State<IESRKChatPage> with TickerProviderStateMixin {

  final String title = '교통사고 IES-R-K 검사';

  final List<ChatMessageItemIESRK> _messageItemList = [];

  ChatResponse _chatResponse = ChatResponse();
  ChatSelect select = ChatSelect();

  var currentProgress = 0; // 진행 갯수
  var currentProgressValue = 0.0; // 진행 게이지

  final int lastNumber = 21; // 질문 수

  late String userIdx; // DB index

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _showGreetings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Frame.doAppBar(title),

        body: Stack(
          children: [
            Container(margin: EdgeInsets.only(top: 1),
              child: Column(
                children: [

                  // Chat List
                  Flexible(
                    child: ListView.builder(
                      padding: EdgeInsets.all(8.0),
                      reverse: true,
                      itemBuilder: (context, index) => _messageItemList[index],
                      itemCount: _messageItemList.length,
                    ),
                  ),

                  Divider(height: 1.0),
                ],
              ),
            ),

            // 진행률 Progress
            Container(height: 40, width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(2.0))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:
                        [
                          SizedBox(width: 80,
                              child: Text('진행률 $currentProgress/22', textScaleFactor: 0.95, style: TextStyle(fontWeight: FontWeight.bold))),

                          Container(margin: EdgeInsets.symmetric(vertical: 5),
                            height: 12,
                            width: MediaQuery.of(context).size.width - 100,
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              child: LinearProgressIndicator(value: currentProgressValue, backgroundColor: Colors.grey,
                                  valueColor: AlwaysStoppedAnimation<Color>(mainColor)),
                            ),
                          ),
                        ],
                      )
                  ),
                ],
              ),
            )

          ],
        )
    );
  }

  /// IES-R-K questionMessage 서버로부터 요청
  void _loadQuestion(ChatSelect select) async
  {
    _chatResponse = await client.dioIESRKChat(select.toIESRKMap(userIdx));
    print('>>>> [IES-R-K] questionMessage : ' + _chatResponse.questionMessage! + ' / userIdx : ' + userIdx);

    userIdx = _chatResponse.userIdx!; // 할당된 DB index
    _chatResponse.questionMessage = _chatResponse.questionMessage!.replaceAll('oo님', Authorization().name + '님');

    Future.delayed(const Duration(milliseconds: 800), () {
      if (_chatResponse.answerType == 'none') { //answerType 이 none 일때
        _loadQuestionNone(_chatResponse, true);
      }

      else if (_chatResponse.answerType == 'select') { // 선택지
        _loadQuestionSelect(_chatResponse);
      }
    }
    );
  }

  /// IES-R-K 질문 생성
  void _loadQuestionSelect(ChatResponse chatResponse)
  {
    print('>>>> [loadQuestionSelect execution]');

    List<bool>isSelectColor = [];
    for (int i = 0; i < chatResponse.chatAnswersListIESRK!.length; i++) {
      isSelectColor.add(false);
    }

    ChatData questionChatData = ChatData(
        questionNo: chatResponse.questionNo,
        message: chatResponse.questionMessage,
        answerType: chatResponse.answerType,
        messageType: 'RECEIVE',
        chatAnswersListIESRK: chatResponse.chatAnswersListIESRK
    );

    ChatMessageItemIESRK messageItem = createMessageItem(questionChatData);

    setState(() {
      _messageItemList.insert(0, messageItem);
    });
    messageItem.animationController.forward();

    if (questionChatData.message != '검사가 종료되었습니다 수고하셨습니다.') {
      Future.delayed(const Duration(milliseconds: 800), () {
        optionAnswer(questionChatData, isSelectColor); // 오른쪽에 선택지 생성
      });
    }
  }

  /// IES-R-K 응답지 생성
  void optionAnswer(ChatData questionChatData, List<bool>isSelectColor)
  {
    ChatData newQuestionChatData = ChatData(
        questionNo: questionChatData.questionNo,
        answerType: questionChatData.answerType,
        messageType: 'SEND',
        message: '',
        chatAnswersListIESRK: questionChatData.chatAnswersListIESRK
    );

    ChatMessageItemIESRK messageItem = ChatMessageItemIESRK(chatData: newQuestionChatData, isSelectColor: isSelectColor, runOnce: true,
        animationController: AnimationController(duration: Duration(milliseconds: 1000), vsync: this),
        callback: (select) => getAnswer(select));

    setState(() {
      _messageItemList.insert(0, messageItem);
    });
    messageItem.animationController.forward();
  }

  /// IES-R-K 추임새 생성
  void _loadQuestionNone(ChatResponse chatResponse, bool identifier)
  {
    print('>>>> [loadQuestionNone execution]');

    ChatData questionChatData = ChatData(
        questionNo: chatResponse.questionNo,
        message: chatResponse.questionMessage,
        answerType: chatResponse.answerType,
        messageType: 'RECEIVE',
        chatAnswersListIESRK: chatResponse.chatAnswersListIESRK
    );
    ChatMessageItemIESRK messageItem = createMessageItem(questionChatData);

    setState(() {
      _messageItemList.insert(0, messageItem);
    });

    messageItem.animationController.forward();

    if (identifier) { // 서버에서 온거 만
      ChatSelect select = ChatSelect();
      select.userIdx = userIdx;
      select.questionNo = int.parse(questionChatData.questionNo.toString());
      select.answerNo = '';
      select.answerMessage = '';

      _loadQuestion(select);
    }
  }

  /// IES-R-k 응답 - ChatSelect Callback Function
  void getAnswer(ChatSelect select)
  {
    addReactionMessage(select); // 메시지 추임

    Future.delayed(const Duration(milliseconds: 500), () {
      _loadQuestion(select);

      if (currentProgress == lastNumber) { // 검사 종료
        currentProgress++;
        currentProgressValue = 1;
      }
      else {
        currentProgress++;
        currentProgressValue += 0.045;
      }
    });
  }

  /// 응답자의 선택에 따라 리엑션 응답 추가 함수
  void addReactionMessage(ChatSelect select)
  {
    if (select.questionNo == 1 || select.questionNo == 9 ||
        select.questionNo == 13 || select.questionNo == 16 ||
        select.questionNo == 19 || select.questionNo == 22) {
      if (select.answerNo == '3' || select.answerNo == '4') {
        _loadQuestionNone(setReaction('이런, 아직도 많이 힘든 시간을 보내고 계시네요.'), false);
      }
      else {
        _loadQuestionNone(setReaction('다행이에요, 많이 좋아지고 계신 것 같아요.'), false);
      }
    }

    else if (select.questionNo == 2) {
      if (select.answerNo == '3' || select.answerNo == '4') {
        _loadQuestionNone(setReaction('아 그러시구나.'), false);
      }
    }

    else if (select.questionNo == 4) {
      if (select.answerNo == '3' || select.answerNo == '4') {
        _loadQuestionNone(setReaction('네, 괜찮습니다. 정상 반응이에요.'), false);
      }
      else {
        _loadQuestionNone(setReaction('점점 나아지고 계신 것 같은데요.'), false);
      }
    }

    else if (select.questionNo == 5) {
      if (select.answerNo == '3' || select.answerNo == '4') {
        _loadQuestionNone(
            setReaction('네, 괜찮습니다. 그럴 수 있어요, 정상적인 회피 반응이에요.'), false);
      }
      else {
        _loadQuestionNone(setReaction('좋습니다. 점점 극복해 나아가고 계신 것 같아요.'), false);
      }
    }

    else if (select.questionNo == 10) {
      if (select.answerNo == '3' || select.answerNo == '4') {
        _loadQuestionNone(setReaction('앗! 꽤 놀라셨겠어요?'), false);
      }
      else {
        _loadQuestionNone(setReaction('좋습니다. 점점 극복해 나아가고 계신 것 같아요.'), false);
      }
    }
  }

  /// IES-R-K 인사말 : initState 에서 첫 실행
  _showGreetings()
  {
    _delayMessage(COMMON_GREETINGS_HELLO , 10);
    _delayMessage(IESRK_GREETINGS_STEP_1 , 20);
    _delayMessage(IESRK_GREETINGS_STEP_2 , 100);
    _delayMessage(IESRK_GREETINGS_STEP_3 , 170);
    _delayMessage(COMMON_GREETINGS_START , 250);

    // 실제 질문 시작
    Future.delayed(const Duration(milliseconds: 28000), ()
    {
      userIdx = '-1'; // 초기 무조건 -1로 시작

      ChatSelect select = ChatSelect(userIdx: userIdx, questionNo: int.parse('0'), answerNo: '0');
      _loadQuestion(select);
    });
  }

  /// 인사 말 딜레이 Message
  _delayMessage(String msg, int durationCut)
  {
    Future.delayed(Duration(milliseconds: durationCut * 100), () {
      _loadQuestionNone(setReaction(msg), false); // 다음 요청이 없어 false
    });
  }


  /// IES-R-K 추임새 Message Item ChatResponse 생성
  ChatResponse setReaction(String msg)
  {
    ChatResponse _chatResponse = ChatResponse();
    _chatResponse.questionMessage = msg;
    _chatResponse.answerType = 'none';

    return _chatResponse;
  }

  /// IES-R-K Message Item 생성
  ChatMessageItemIESRK createMessageItem(ChatData questionChatData)
  {
    ChatMessageItemIESRK messageItem = ChatMessageItemIESRK(chatData: questionChatData,
        animationController: AnimationController(duration: Duration(milliseconds: 1000), vsync: this));
    return messageItem;
  }
}
