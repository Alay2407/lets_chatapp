import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lets_chatapp/domain/bloc/message/send_message_cubit.dart';

import '../../core/colors/colors.dart';
import '../../constants/strings.dart';
import '../../data/Model/chat/get_single_chat_data.dart';
import '../../data/Model/message/send_message_body.dart';
import '../../data/Model/message/send_msg_data.dart';
import '../../domain/bloc/chat/getAllChat/get_all_chat_cubit.dart';
import '../../getit_injector.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatScreen extends StatefulWidget {
  ChatScreen({
    super.key /*,this.name*/,
    /*this.searchUserData*/ this.name,
    this.emailId,
    this.receiverId,
    this.messagess,
    this.chatId,
  });

  // SearchUserData? searchUserData;
  String? name;
  String? emailId;
  String? receiverId;
  String? chatId;
  List<GetSingleChatData>? messagess;

  // GetSingleChat? getSingleChat;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  SendMessageCubit sendMessageCubit = locator<SendMessageCubit>();
  TextEditingController message = TextEditingController();
  GetAllChatCubit getAllChatCubit = locator<GetAllChatCubit>();

  // late IO.Socket socket;

  @override
  void initState() {
    super.initState();
    // connectToServer();
    messages = widget.messagess!;
  }

  // void connectToServer() {
  //   // Connect to the Socket.IO server
  //   socket = IO.io('https://stage-ultro-chat-node.onrender.com', <String, dynamic>{
  //     'transports': ['websocket'],
  //     'autoConnect': false,
  //   });
  //   socket.connect();
  //   print(socket.connected);
  //   print(socket.active);
  //   // Listen for incoming chat messages
  //   socket.on('chat_message', (data) {
  //     setState(() {
  //       messages.add(data);
  //     });
  //   });
  // }

  List<GetSingleChatData> messages = [];

  // List<ChatMessage> messages = [
  //   ChatMessage(messageContent: "Hello, Will", messageType: "receiver"),
  //   ChatMessage(messageContent: "How have you been?", messageType: "receiver"),
  //   ChatMessage(messageContent: "Hey Kriss, I am doing fine dude. wbu?", messageType: "sender"),
  //   ChatMessage(messageContent: "ehhhh, doing OK.", messageType: "receiver"),
  //   ChatMessage(messageContent: "Is there any thing wrong?", messageType: "sender"),
  //   ChatMessage(messageContent: "Hello, Will", messageType: "receiver"),
  //   ChatMessage(messageContent: "How have you been?", messageType: "receiver"),
  //   ChatMessage(messageContent: "Hey Kriss, I am doing fine dude. wbu?", messageType: "sender"),
  //   ChatMessage(messageContent: "ehhhh, doing OK.", messageType: "receiver"),
  //   ChatMessage(messageContent: "Is there any thing wrong?", messageType: "sender"),
  //   ChatMessage(messageContent: "Hello, Will", messageType: "receiver"),
  //   ChatMessage(messageContent: "How have you been?", messageType: "receiver"),
  //   ChatMessage(messageContent: "Hey Kriss, I am doing fine dude. wbu?", messageType: "sender"),
  //   ChatMessage(messageContent: "ehhhh, doing OK.", messageType: "receiver"),
  //   ChatMessage(messageContent: "Is there any thing wrong?", messageType: "sender"),
  //   ChatMessage(messageContent: "Hello, Will", messageType: "receiver"),
  //   ChatMessage(messageContent: "How have you been?", messageType: "receiver"),
  //   ChatMessage(messageContent: "Hey Kriss, I am doing fine dude. wbu?", messageType: "sender"),
  //   ChatMessage(messageContent: "ehhhh, doing OK.", messageType: "receiver"),
  //   ChatMessage(messageContent: "Is there any thing wrong?", messageType: "sender"),
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: SvgPicture.asset(
                    SvgString.Back,
                    color: ColorManager.dark,
                  )),
              Expanded(
                child: ListTile(
                  leading: Stack(
                    children: [
                      CircleAvatar(
                        radius: 22,
                        child: Image.asset(SvgString.img3),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 9,
                          height: 9,
                          decoration: const BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                  title: Text(
                    widget.name.toString(),
                    style: const TextStyle(
                      color: ColorManager.chatName,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    'Active User',
                    style: TextStyle(
                      color: ColorManager.subTitle.withOpacity(0.50),
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: SvgPicture.asset(SvgString.directCall),
                      ),
                      SvgPicture.asset(SvgString.videoCall),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      body: Stack(
        children: <Widget>[
          ListView.builder(
            // reverse: true,
            itemCount: messages.length,
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            // physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              print('Chat id  is===>   ${widget.chatId}');
              return Container(
                padding: const EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 70),
                child: Align(
                  alignment: (messages[index].sender_id == widget.receiverId ? Alignment.topLeft : Alignment.topRight),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: messages[index].sender_id == widget.receiverId
                          ? const BorderRadius.only(
                              topRight: Radius.circular(20),
                              topLeft: Radius.circular(0),
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            )
                          : const BorderRadius.only(
                              topRight: Radius.circular(0),
                              topLeft: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                      color: (messages[index].sender_id == widget.receiverId ? ColorManager.senderColor : ColorManager.reciverColor),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      messages[index].message.toString(),
                      style: TextStyle(
                        fontSize: 15,
                        color: (messages[index].sender_id == widget.receiverId ? ColorManager.dark : ColorManager.white),
                      ),
                    ),
                  ),
                ),
              );

              // return ListView.builder(
              //   itemCount: messages.length,
              //   shrinkWrap: true,
              //   padding: EdgeInsets.only(top: 10, bottom: 10),
              //   // physics: NeverScrollableScrollPhysics(),
              //   itemBuilder: (context, index) {
              //     return Container(
              //       padding: EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
              //       child: Align(
              //         alignment: (messages[index].messageType == "receiver" ? Alignment.topLeft : Alignment.topRight),
              //         child: Container(
              //           decoration: BoxDecoration(
              //             borderRadius: messages[index].messageType == "receiver"
              //                 ? const BorderRadius.only(
              //                     topRight: Radius.circular(20),
              //                     topLeft: Radius.circular(0),
              //                     bottomLeft: Radius.circular(20),
              //                     bottomRight: Radius.circular(20),
              //                   )
              //                 : const BorderRadius.only(
              //                     topRight: Radius.circular(0),
              //                     topLeft: Radius.circular(20),
              //                     bottomLeft: Radius.circular(20),
              //                     bottomRight: Radius.circular(20),
              //                   ),
              //             color: (messages[index].messageType == "receiver" ? ColorManager.senderColor : ColorManager.reciverColor),
              //           ),
              //           padding: const EdgeInsets.all(16),
              //           child: Text(
              //             messages[index].messageContent,
              //             style: TextStyle(
              //               fontSize: 15,
              //               color: (messages[index].messageType == "receiver" ? ColorManager.dark : ColorManager.white),
              //             ),
              //           ),
              //         ),
              //       ),
              //     );
              //   },
              // );
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.only(bottom: 10, top: 10),
              height: 80,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 24,
                      width: 24,
                      child: SvgPicture.asset(
                        SvgString.attachment,
                        color: ColorManager.dark,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 216,
                    child: Container(
                      decoration: BoxDecoration(
                        color: ColorManager.lightGray,
                        borderRadius: BorderRadius.circular(10.0),
                        // border: Border.all(color: ColorManager.dark)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: TextField(
                          decoration: const InputDecoration(
                            hintText: "Write message...",
                            hintStyle: TextStyle(color: Colors.black54),
                            border: InputBorder.none,
                          ),
                          controller: message,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 24,
                    width: 24,
                    child: SvgPicture.asset(
                      SvgString.camera,
                      color: ColorManager.dark,
                    ),
                  ),
                  GestureDetector(
                    child: const SizedBox(
                        height: 24,
                        width: 24,
                        child: Icon(
                          Icons.send,
                        )),
                    onTap: () {
                      sendMessageCubit.sendMessage(
                        widget.receiverId!,
                        SendMessageBody(message.text.toString()),
                      );

                      // setState(() {
                      //   messages.add(SendMsgData(message: message.text));
                      //   message.clear();
                      // });
                      //
                      setState(() {
                        messages.add(GetSingleChatData(message: message.text));
                        message.clear();
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      // body: Stack(
      //   children: <Widget>[
      //     BlocBuilder(
      //       bloc: getAllChatCubit,
      //       builder: (context, state) {
      //          if(state is GetSingleChatFinishedState){
      //            var data = state.getSingleChat!.data;
      //            print('data is ${data![0].id}');
      //            return ListView.builder(
      //              itemCount: state.getSingleChat!.data!.length,
      //              shrinkWrap: true,
      //              padding: const EdgeInsets.only(top: 10, bottom: 10),
      //              // physics: NeverScrollableScrollPhysics(),
      //              itemBuilder: (context, index) {
      //                return Container(
      //                  padding: const EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 70),
      //                  child: Align(
      //                    alignment: (data[index].receiver_id == widget.receiverId ? Alignment.topLeft : Alignment.topRight),
      //                    child: Container(
      //                      decoration: BoxDecoration(
      //                        borderRadius:data[index].receiver_id == widget.receiverId
      //                            ? const BorderRadius.only(
      //                          topRight: Radius.circular(20),
      //                          topLeft: Radius.circular(0),
      //                          bottomLeft: Radius.circular(20),
      //                          bottomRight: Radius.circular(20),
      //                        )
      //                            : const BorderRadius.only(
      //                          topRight: Radius.circular(0),
      //                          topLeft: Radius.circular(20),
      //                          bottomLeft: Radius.circular(20),
      //                          bottomRight: Radius.circular(20),
      //                        ),
      //                        color: (data[index].receiver_id == widget.receiverId ? ColorManager.senderColor : ColorManager.reciverColor),
      //                      ),
      //                      padding: const EdgeInsets.all(16),
      //                      child: Text(
      //                        data[index].message.toString(),
      //                        style: TextStyle(
      //                          fontSize: 15,
      //                          color: (data[index].receiver_id == widget.receiverId ? ColorManager.dark : ColorManager.white),
      //
      //                        ),
      //                      ),
      //                    ),
      //                  ),
      //                );
      //              },
      //            );
      //
      //          }else{
      //            return Container();
      //          }
      //       },
      //     ),
      //     Align(
      //       alignment: Alignment.bottomCenter,
      //       child: Container(
      //         padding: const EdgeInsets.only(bottom: 10, top: 10),
      //         height: 80,
      //         width: double.infinity,
      //         color: Colors.white,
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //           mainAxisSize: MainAxisSize.min,
      //           children: <Widget>[
      //             GestureDetector(
      //               onTap: () {},
      //               child: Container(
      //                 height: 24,
      //                 width: 24,
      //                 child: SvgPicture.asset(
      //                   SvgString.attachment,
      //                   color: ColorManager.dark,
      //                 ),
      //               ),
      //             ),
      //             SizedBox(
      //               width: 216,
      //               child: Container(
      //                 decoration: BoxDecoration(
      //                   color: ColorManager.lightGray,
      //                   borderRadius: BorderRadius.circular(10.0),
      //                   // border: Border.all(color: ColorManager.dark)
      //                 ),
      //                 child: Padding(
      //                   padding: const EdgeInsets.symmetric(horizontal: 15),
      //                   child: TextField(
      //                     decoration: const InputDecoration(
      //                       hintText: "Write message...",
      //                       hintStyle: TextStyle(color: Colors.black54),
      //                       border: InputBorder.none,
      //                     ),
      //                     controller: message,
      //                   ),
      //                 ),
      //               ),
      //             ),
      //             SizedBox(
      //               height: 24,
      //               width: 24,
      //               child: SvgPicture.asset(
      //                 SvgString.camera,
      //                 color: ColorManager.dark,
      //               ),
      //             ),
      //             GestureDetector(
      //               child: const SizedBox(
      //                   height: 24,
      //                   width: 24,
      //                   child: Icon(
      //                     Icons.send,
      //                   )),
      //               onTap: () {
      //                 // sendMessageCubit.sendMessage(
      //                 //   widget.receiverId.toString(),
      //                 //   SendMessageBody(message.text.toString()),
      //                 // );
      //                 //
      //                 // setState(() {
      //                 //   messages.add(GetSingleChatData(message: message.text));
      //                 //   message.clear();
      //                 // });
      //               },
      //             ),
      //           ],
      //         ),
      //       ),
      //     ),
      //
      //   ],
      // ),
    );
  }
}
