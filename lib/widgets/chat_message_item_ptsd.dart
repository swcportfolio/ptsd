
import 'package:flutter/material.dart';
import 'package:vempire_app/data/chat_select.dart';
import 'package:vempire_app/utils/color.dart';
import 'package:vempire_app/widgets/grid_view_%20item.dart';
import '../data/chat_data.dart';

/// PTSD Message Item Widget
// ignore: must_be_immutable
class ChatMessageItemPTSD extends StatefulWidget {

  final ChatData chatData;
  final AnimationController animationController;
  final Function(ChatSelect)? callback;
  final List<bool>? isSelectColor;
  bool? runOnce;
  ChatMessageItemPTSD({required this.chatData,required this.animationController,  this.callback,  this.isSelectColor,  this.runOnce});

  @override
  _ChatMessageItemPTSDState createState() => _ChatMessageItemPTSDState();
}

class _ChatMessageItemPTSDState extends State<ChatMessageItemPTSD> {

  @override
  Widget build(BuildContext context) {
    return widget.animationController != null ? _animationContainer(context) : _normalContainer(context);
  }

  Widget _normalContainer(context) {
      return widget.chatData.messageType == 'RECEIVE'
            ?
        Container(
          margin: EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Container(child: SizedBox(width: 45.0, height: 45.0,
                   child: Image.asset('images/user.png', fit: BoxFit.fill))),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 8.0, right: 15.0, bottom: 8.0, left: 15.0),
                    margin: EdgeInsets.only(top: 7, left: 8, right: 8),
                    decoration: BoxDecoration(
                        color: mainColor,
                        borderRadius:  BorderRadius.only(
                            topLeft: Radius.zero, topRight: Radius.circular(15.0), bottomLeft: Radius.circular(15.0), bottomRight: Radius.circular(15.0)
                        )
                    ),
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width / 1.6,
                        minHeight: 30,

                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                      [
                        Text(widget.chatData.message.toString(), textScaleFactor: 0.9, style: TextStyle(color: Colors.white)), // Color(0xFF363636)

                        Visibility(
                          visible: isEndByMessage(),
                          child: Container(
                              padding: EdgeInsets.only(top: 10),
                              width:MediaQuery.of(context).size.width / 1.8,
                              height: 55,
                              child: Padding(padding: EdgeInsets.all(4.0),
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(elevation: 2,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2.0)),
                                        primary: Colors.white),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('검사 종료', textScaleFactor: 1.1, style: TextStyle(color: mainColor, letterSpacing: 1.5, fontWeight: FontWeight.bold))),
                              )),
                        )
                      ],
                    ),
                  ),

                ],
              ),
            ],
          )
      )
          :
      widget.chatData.messageType == 'SEND' && widget.chatData.answerType == 'input' ?

      Container(
          margin: EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            mainAxisAlignment:  MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children:
                [
                  Container(
                    padding: EdgeInsets.only(top: 8.0, right: 15.0, bottom: 8.0, left: 15.0),
                    margin: EdgeInsets.only(top: 7, left: 8, right: 8),
                    decoration: BoxDecoration(
                        color: Color(0xFFEEEEEE), // Color(0xFF56CA8F1),
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.zero, bottomLeft: Radius.circular(15.0), bottomRight: Radius.circular(15.0))
                    ),
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width / 1.6,
                        minHeight: 30
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.chatData.message.toString(), textScaleFactor: 1.0, style:TextStyle(color: Colors.black))
                      ],
                    ),
                  ),
                ],
              ),
            ],
          )
      )
          :
        Container(
            margin: EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              mainAxisAlignment:  MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               Container(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [

                    Container(
                      padding: EdgeInsets.only(top: 8.0, right: 15.0, bottom: 8.0, left: 15.0),
                      margin: EdgeInsets.only(top: 7, left: 8, right: 8),
                      decoration: BoxDecoration(
                          color: Color(0xFFEEEEEE), // Color(0xFF56CA8F1),
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.zero, bottomLeft: Radius.circular(15.0), bottomRight: Radius.circular(15.0)
                          )
                      ),
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width / 1.6,
                          minHeight: 30
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:
                        [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              FittedBox(
                                child: Container(
                                    padding: const EdgeInsets.only(top:10.0),
                                    child: SizedBox(
                                        width: MediaQuery.of(context).size.width / 1.6 - 30.0,
                                        height:
                                        widget.chatData.chatAnswersListPTSD!.length == 5 ? 260 :
                                        widget.chatData.chatAnswersListPTSD!.length == 3 ? 210 : 110,
                                        child: GridView.builder(
                                            shrinkWrap: true,
                                            physics: const NeverScrollableScrollPhysics(),
                                            itemCount: widget.chatData.chatAnswersListPTSD!.length,
                                            itemBuilder: (BuildContext context, int index){
                                              return buildGridViewSelect(index);
                                            },
                                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(mainAxisExtent:50.0,crossAxisCount: 1, crossAxisSpacing: 0.0, mainAxisSpacing: 0, childAspectRatio: 2.9)))
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            )
        );
  }

  /// Chat Item Animation widget
  Widget _animationContainer(context)
  {
    return SizeTransition(
        sizeFactor: CurvedAnimation(
            parent: widget.animationController,
            curve: Curves.fastOutSlowIn
        ),
        axisAlignment: -1.0,
        child: _normalContainer(context)
    );
  }

  /// PTSD Gridview 선택지
  Widget buildGridViewSelect (int index)
  {
    return GestureDetector(
        onTap: () {
          ChatSelect select = ChatSelect(
              questionNo:int.parse(widget.chatData.questionNo!),
              answerNo: widget.chatData.chatAnswersListPTSD![index].answerNo,
              answerMessage: widget.chatData.chatAnswersListPTSD![index].answerMessage
          );

          setState(() {
            if(widget.runOnce!) {
              widget.isSelectColor![index] = true;
              widget.runOnce = false;
              widget.callback!(select); // ChatPage 로 넘어가는 값
            }

          });
        },
        child:GridViewItem.buildChatGridViewItem(widget.chatData.chatAnswersListPTSD![index].answerMessage, widget.isSelectColor![index])
    );
  }

  /// PTSD 종료 메시지인지 확인
  isEndByMessage() {
    return  widget.chatData.message == '검사가 종료되었습니다 수고하셨습니다.' || widget.chatData.message == '검사를 종료합니다. 결과를 생성하고 있습니다. 잠시만 기다려 주세요'||
        widget.chatData.message == '검사를 종료합니다.' ? true : false;
  }
}
