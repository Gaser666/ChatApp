import 'package:chat_app/constants.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/widgets/chat_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key});
  static String id = 'ChatPage';
  final ScrollController _controller = ScrollController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference message =
      FirebaseFirestore.instance.collection(kMessagesCollection);
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder(
        stream: message.orderBy(kCreatedAt, descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<MessageModel> messageList = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              messageList.add(MessageModel.fromJson(snapshot.data!.docs[i]));
            }
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                automaticallyImplyLeading: false,
                backgroundColor: kPrimaryColor,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/logo(1).png',
                      height: 30,
                      // fit: BoxFit.scaleDown,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Chatty',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'PlaywriteDKUloopet',
                      ),
                    ),
                  ],
                ),
              ),
              body: Column(children: [
                Expanded(
                  child: ListView.builder(
                      reverse: true,
                      controller: _controller,
                      itemCount: messageList.length,
                      itemBuilder: (context, index) {
                        return messageList[index].id == email ? ChatBubble(
                          message: messageList[index],
                        ) : ChatBubbleFreind(message: messageList[index]);
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    controller: controller,
                    onSubmitted: (data) {
                      controller.clear();
                      _controller.jumpTo(
                        0,
                      );
                      message.add({
                        'messages': data,
                        kCreatedAt: DateTime.now(),
                        'id': email,
                      });
                    },
                    decoration: InputDecoration(
                        hintText: 'Message',
                        suffixIcon: Icon(
                          Icons.send,
                          color: kPrimaryColor,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                              color: kPrimaryColor,
                            ))),
                  ),
                ),
              ]),
            );
          } else
            return Text('');
        });
  }
}
