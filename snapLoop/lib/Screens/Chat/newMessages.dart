import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  final String loopID;

  const NewMessage({Key key, this.loopID = ""}) : super(key: key);

  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  var enteredMessage = "";
  final controller = new TextEditingController();
  void sendMessage() async {
    FocusScope.of(context).unfocus();
    //If the loopID is not provided that means that the user is trying to create a new loop
    //entered message contains the message
    // make an API call and send the message
    //enteredMessage contains the actual message and it will be displayed after making the API call and
    // making sure that the message was delivered
    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(children: [
        Expanded(
            child: TextField(
          controller: controller,
          textCapitalization: TextCapitalization.sentences,
          autocorrect: true,
          enableSuggestions: true,
          decoration: InputDecoration(labelText: "Type a message.."),
          onChanged: (value) {
            setState(() {
              enteredMessage = value;
            });
          },
        )),
        IconButton(
          color: Theme.of(context).primaryColor,
          icon: Icon(Icons.send),
          onPressed: enteredMessage.trim().isEmpty ? null : sendMessage,
        ),
      ]),
    );
  }
}
