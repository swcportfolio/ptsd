import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vempire_app/data/authorization.dart';
import 'package:vempire_app/data/chat_data.dart';
import 'package:vempire_app/data/chat_response.dart';
import 'package:vempire_app/data/chat_select.dart';
import 'package:vempire_app/widgets/chat_message_item_ptsd.dart';
import 'package:vempire_app/utils/color.dart';
import 'package:vempire_app/utils/constants.dart';
import 'package:vempire_app/utils/dio_client.dart';
import 'package:vempire_app/utils/frame.dart';

/// PTSD 채팅 검사화면
class PTSDChatPage extends StatefulWidget {

  final int accidentIdx;    // 사고 평가 DB index
  PTSDChatPage({required this.accidentIdx});

  @override
  _PTSDChatPageState createState() => _PTSDChatPageState();
}

class _PTSDChatPageState extends State<PTSDChatPage> with TickerProviderStateMixin {

  final String title = '교통사고 PTSD 검사';

  ChatSelect select = ChatSelect();
  FocusNode _focusNodeInputType = FocusNode(); // 입력란 활성
  ChatResponse _chatResponse = ChatResponse();

  final List<ChatMessageItemPTSD> _messageItemList = [];
  final _numberItemList = List.generate(101, (i) => i);

  var currentProgress = 0;                    // 진행 갯수
  var currentProgressValue = 0.0;             // 진행 게이지
  final int lastNumber = 34;                  // 34개 문항
  final double progressIncreaseVal = 0.02857; // 프로그래스바 증가값

  late String globalQuestionNo; // input questionNO
  late String userIdx;          // DB index

  bool isShowComposer = false; // 입력란 비\활성화

  int numberData = 0;
  int initializationToZero = 0; // 0 으로 초기화

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
            Container(
              margin: EdgeInsets.only(top: 1),
              child: Column(
                children:
                [
                  Flexible(
                    child: ListView.builder(
                      padding: EdgeInsets.all(8.0),
                      reverse: true,
                      itemBuilder: (context, index) => _messageItemList[index],
                      itemCount: _messageItemList.length,
                    ),
                  ),

                  SizedBox(height: 1.0),

                  /// CupertinoPicker : answerType = if)input
                  Visibility(
                    visible: isShowComposer,
                    child: Container(
                      decoration: BoxDecoration(color: Theme.of(context).cardColor),
                      child: Container(
                        height: 250,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children:
                          [
                            // 상단 확인 버튼
                            Padding(padding: const EdgeInsets.all(12.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children:
                                [
                                  TextButton(
                                    child: Text("확인", textScaleFactor: 1.0, style: TextStyle(color: mainColor, fontWeight: FontWeight.bold)),
                                    onPressed: () {
                                      _handleSubmittedExtend(numberData.toString());
                                    })
                                ]),
                            ),

                            // 하단 picker
                            Expanded(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      height: 160,
                                      child: CupertinoPicker(
                                        itemExtent: 30,
                                        onSelectedItemChanged: (int index) {
                                          numberData = index;
                                        },
                                        children:_numberItemList.map((e) => Text('$e', textScaleFactor: 0.93)).toList(),

                                      )))])
                            ),
                          ],
                        ),
                      )
                      //_buildTextComposer(),
                    ),
                  ),
                ],
              ),
            ),

            // 채팅 검사 진행률 UI
            Container(
              height: 40,
              width: MediaQuery.of(context).size.width,
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
                          SizedBox(width:80,
                              child: Text('진행률 $currentProgress/35', textScaleFactor: 0.95, style: TextStyle(fontWeight: FontWeight.bold))),

                          Container(
                            height: 12,
                            width: MediaQuery.of(context).size.width - 100,
                            margin: EdgeInsets.symmetric(vertical: 5),
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

  /// PTSD questionMessage 서버로부터 요청
  void _loadQuestion(ChatSelect select) async
  {
    _chatResponse = await client.dioPTSDChat(select.toPTSDMap(userIdx, widget.accidentIdx));
    print('>>>> [PTSD] questionMessage : '+ _chatResponse.questionMessage!+' / userIdx : '+userIdx);

    userIdx = _chatResponse.userIdx!; // 할당된 DB index
    _chatResponse.questionMessage = _chatResponse.questionMessage!.replaceAll('oo님', Authorization().name+'님');
    currentProgress = int.parse(_chatResponse.questionNo.toString());

    Future.delayed(const Duration(milliseconds: 800), () {

      if (_chatResponse.answerType == 'none' || _chatResponse.answerType == 'final' ||
          _chatResponse.questionMessage == '검사를 종료합니다.' // 첫 질문에서 "아니오" 경우
          || _chatResponse.questionMessage == '검사를 종료합니다. 결과를 생성하고 있습니다. 잠시만 기다려 주세요') // 최종적인 검사 종료 시
      {
        isShowComposer = false;
        _loadQuestionNone(_chatResponse, true);
      }

      else if (_chatResponse.answerType == 'select') {
        isShowComposer = false;
        _loadQuestionSelect(_chatResponse);
      }

      else if(_chatResponse.answerType == 'input') {
        isShowComposer = true;
        _loadQuestionInput(_chatResponse);
      }

    });
  }

  /// PTSD 질문 및 선택지 생성
  void _loadQuestionSelect(ChatResponse chatResponse) {
    print('>>>> [PTSD] loadQuestionSelect execution');
    List<bool>isSelectColor = [];

    for(int i = 0; i<chatResponse.chatAnswersListPTSD!.length ; i++){
      isSelectColor.add(false) ;
    }

    ChatData questionChatData = ChatData(
      questionNo  : chatResponse.questionNo,
      message     : chatResponse.questionMessage,
      answerType  : chatResponse.answerType,
      messageType : 'RECEIVE',
      chatAnswersListPTSD : chatResponse.chatAnswersListPTSD
    );

    ChatMessageItemPTSD messageItem = createMessageItem(questionChatData);

    setState(() {
      _messageItemList.insert(0, messageItem);

    });
    messageItem.animationController.forward();

    Future.delayed(const Duration(milliseconds: 1000), (){ // 오른쪽에 선택지 생성
        optionAnswer(questionChatData, chatResponse, isSelectColor);
    });

  }

  /// PTSD 추임새 생성
  void _loadQuestionNone(ChatResponse chatResponse, bool identifier) {
    print('>>>> [PTSD] loadQuestionNone execution');

    ChatData questionChatData = ChatData(
      questionNo  : chatResponse.questionNo,
      message     : chatResponse.questionMessage,
      answerType  : chatResponse.answerType,
      messageType : 'RECEIVE',
      chatAnswersListPTSD : chatResponse.chatAnswersListPTSD
    );

    ChatMessageItemPTSD messageItem = createMessageItem(questionChatData);

    setState(() {
      _messageItemList.insert(0, messageItem);
    });

    messageItem.animationController.forward();

    if(identifier){ // 서버에서 온거 만
      ChatSelect select = ChatSelect();
      select.questionNo = int.parse(questionChatData.questionNo!);
      select.answerNo ='';
      select.answerMessage ='';

      if(_chatResponse.answerType == 'input'){
        _loadQuestion(select);
      }

      // 검사 종료 ( progressBar : 35/35 )
      if(_chatResponse.questionMessage == '검사를 종료합니다.'
          || _chatResponse.questionMessage == '검사를 종료합니다. 결과를 생성하고 있습니다. 잠시만 기다려 주세요')
      {
        currentProgressValue = 1;
        currentProgress = 35;
      }
    }
  }

  /// PTSD 질문 및 입력 란(picker) 생성
  void _loadQuestionInput(ChatResponse chatResponse) {
    print('>>>> [PTSD] loadQuestionInput execution');
    globalQuestionNo  = chatResponse.questionNo!; // input 질문 번호 전역변수로

    ChatData questionChatData = ChatData(
        questionNo  : chatResponse.questionNo,
        message     : chatResponse.questionMessage,
        answerType  : chatResponse.answerType,
        messageType : 'RECEIVE',
        chatAnswersListPTSD : chatResponse.chatAnswersListPTSD
    );

    ChatMessageItemPTSD messageItem = createMessageItem(questionChatData);

    setState(() {
      _messageItemList.insert(0, messageItem);
    });

    messageItem.animationController.forward();
    _focusNodeInputType.requestFocus();
  }

  /// PTSD 응답지 생성
  void optionAnswer(ChatData questionChatData, ChatResponse chatResponse, List<bool>isSelectColor){

    ChatData newQuestionChatData = ChatData(
        questionNo  : questionChatData.questionNo,
        answerType  : questionChatData.answerType,
        messageType : 'SEND',
        message     : '',
        chatAnswersListPTSD : questionChatData.chatAnswersListPTSD
    );

    ChatMessageItemPTSD messageItem = ChatMessageItemPTSD(chatData: newQuestionChatData, isSelectColor:isSelectColor, runOnce:true,
        animationController:AnimationController(duration: Duration(milliseconds:1000), vsync: this), callback:(select)=>getAnswer(select));

    setState(() {
      _messageItemList.insert(0, messageItem);
    });
    messageItem.animationController.forward();
  }

  /// PTSD 응답 - ChatSelect Callback Function
  void getAnswer(ChatSelect select)
  {
    _loadQuestion(select);

    if(currentProgress == lastNumber){ // 검사 종료
      currentProgressValue = 1;
    }
    else{
      currentProgressValue += progressIncreaseVal;
    }
  }

  /// Send Message Composer
  void _handleSubmittedExtend(String text)
  {
      isShowComposer = false; // picker 비활성화

      ChatData questionChatData = ChatData(
          messageType : 'SEND',
          message     : text,
          answerType  : 'input'
      );

      ChatMessageItemPTSD message = createMessageItem(questionChatData);

      setState(() {
        _messageItemList.insert(0, message);
      });

      ChatSelect select = ChatSelect( // 다음 질문 요청
          questionNo    : int.parse(globalQuestionNo),
          answerNo      : '',
          answerMessage : text
      );

      _loadQuestion(select);

      currentProgressValue += progressIncreaseVal;

      numberData = initializationToZero; // picker numberData 0 으로 초기화

      message.animationController.forward();
  }

  /// PTSD 인사말 : initState 에서 첫 실행
  void _showGreetings()
  {
    _delayMessage(COMMON_GREETINGS_HELLO , 10);
    _delayMessage(PTSD_GREETINGS_STEP_1  , 20);
    _delayMessage(PTSD_GREETINGS_STEP_2  , 100);
    _delayMessage(PTSD_GREETINGS_STEP_3  , 170);
    _delayMessage(COMMON_GREETINGS_START , 250);

    Future.delayed(const Duration(milliseconds: 28000), ()
    {
      userIdx = '-1'; // 초기 무조건 -1로 시작

      ChatSelect select = ChatSelect(questionNo: int.parse('0'), answerNo:'0', answerMessage: '');
      _loadQuestion(select);
    });
  }

  /// 인사 말 딜레이
  _delayMessage(String  msg, int durationCut){
    Future.delayed(Duration(milliseconds: durationCut * 100), (){
      _loadQuestionNone(setReaction(msg), false); // 다음 요청이 없어 false
    });
  }

  /// PTSD 추임새 Message Item ChatResponse 생성
  ChatResponse setReaction(String msg)
  {
    ChatResponse _chatResponse = ChatResponse();
    _chatResponse.questionMessage = msg;
    _chatResponse.answerType = 'none';

    return _chatResponse;
  }

  /// PTSD Message Item 생성
  ChatMessageItemPTSD createMessageItem(ChatData questionChatData)
  {
    ChatMessageItemPTSD messageItem = ChatMessageItemPTSD(chatData: questionChatData,
        animationController: AnimationController(duration: Duration(milliseconds: 1000), vsync: this));
    return messageItem;
  }
}
