import 'package:flutter/material.dart';
import 'package:flutterhackathon/models/message.dart';
import 'package:flutterhackathon/models/user.dart';

class ChatDetails extends StatefulWidget {
   final User targetUser;
   final User currentUser;

   ChatDetails({required this.targetUser, required this.currentUser});
  @override
  _ChatDetailsState createState() => _ChatDetailsState();
}

 List<String> messages = [];
  TextEditingController textEditingController = TextEditingController();
  bool sendButton = false;
  String message = "";

class _ChatDetailsState extends State<ChatDetails> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black, onPressed: (){
            if(!widget.currentUser.contactPeople.contains(widget.targetUser)){
              widget.currentUser.contactPeople.add(widget.targetUser);
            }
            Navigator.pop(context);
        },),
        elevation: 0.4,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Row(
          children: <Widget>[
            Container(
              width: 40,
              height: 40,
              margin: const EdgeInsets.fromLTRB(0, 5, 10, 0),
              child: CircleAvatar(
                backgroundImage:  NetworkImage(widget.targetUser.photoUrl),
                backgroundColor: Colors.grey[200],
                minRadius: 30,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.targetUser.name,
                  style: TextStyle(color: Colors.black),
                ),
                Text(
                  widget.targetUser.isActive!?
                  'Online Now': "Offline",
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 12,
                  ),
                )
              ],
            )
          ],
        ),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Flexible(
                  child: ListView.builder(
                    itemCount: 1,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: <Widget>[
                           const  Text(
                              'Today',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12),
                            ),                           
                            for (int i=0; i<widget.currentUser.messages.length; i++)
                              if(widget.currentUser.messages[i].sentTo == widget.targetUser)
                                Bubble(message: widget.currentUser.messages[i].text, isMe: true)
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            width: MediaQuery.of(context).size.width,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(-2, 0),
                  blurRadius: 5,
                ),
              ]),
              child: Row(
                children: <Widget>[
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.camera,
                      color: Color(0xff3E8DF3),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.image,
                      color: Color(0xff3E8DF3),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 15),
                  ),
                  Expanded(
                    child: TextFormField(
                     
                     onChanged: (value){
                           message = value;  
                         },
                       
                    
                      onFieldSubmitted: (value){
                        
                        widget.currentUser.messages.add(Message(text:value, sentTo:widget.targetUser));
                        textEditingController.clear();
                       
                      },
                      
                      textInputAction: TextInputAction.send,
                      controller: textEditingController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        hintText: 'Enter Message',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      
                      setState(() {
                        messages.add(message);
                        textEditingController.clear();
                      });
                    },
                    icon: const Icon(
                      Icons.send,
                      color: Color(0xff3E8DF3),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Bubble extends StatelessWidget {
  final bool isMe;
  final String message;

  Bubble({required this.message, required this.isMe});

  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: isMe ? const EdgeInsets.only(left: 40) : const EdgeInsets.only(right: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            mainAxisAlignment:
                isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  gradient: isMe
                      ? const LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          stops: [
                              0.1,
                              1
                            ],
                          colors: [
                              Color(0xFFF6D365),
                              Color(0xFFFDA085),
                            ])
                      : const LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          stops: [
                              0.1,
                              1
                            ],
                          colors: [
                              Color(0xFFEBF5FC),
                              Color(0xFFEBF5FC),
                            ]),
                  borderRadius: isMe
                      ? const BorderRadius.only(
                          topRight: Radius.circular(15),
                          topLeft: Radius.circular(15),
                          bottomRight: Radius.circular(0),
                          bottomLeft: Radius.circular(15),
                        )
                      : const BorderRadius.only(
                          topRight: Radius.circular(15),
                          topLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                          bottomLeft: Radius.circular(0),
                        ),
                ),
                child: Column(
                  crossAxisAlignment:
                      isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      message,
                      textAlign: isMe ? TextAlign.end : TextAlign.start,
                      style: TextStyle(
                        color: isMe ? Colors.white : Colors.grey,
                      ),
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}