import 'package:SnapLoop/constants.dart';
import 'package:flutter/material.dart';

/// author: @sanchitmonga22
class NewMessageView extends StatefulWidget {
  final Function sendMessage;

  const NewMessageView({Key key, this.sendMessage}) : super(key: key);

  @override
  _NewMessageViewState createState() => _NewMessageViewState();
}

class _NewMessageViewState extends State<NewMessageView> {
  var enteredMessage = "";
  final controller = new TextEditingController();
  // void sendMessage() async {
  //If the loopID is not provided that means that the user is trying to create a new loop
  //entered message contains the message
  // make an API call and send the message
  //enteredMessage contains the actual message and it will be displayed after making the API call and
  // making sure that the message was delivered
  // }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      // height: 50,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white.withOpacity(0.2)),
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(right: 40, left: 10),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: 100.0,
              ),
              child: TextField(
                textAlign: TextAlign.left,
                keyboardType: TextInputType.multiline,
                cursorColor: kSystemPrimaryColor,
                controller: controller,
                textCapitalization: TextCapitalization.sentences,
                autocorrect: true,
                enableSuggestions: true,
                maxLines: null,
                style:
                    kTextFormFieldStyle.copyWith(fontWeight: FontWeight.normal),
                decoration: InputDecoration(
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  border: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintText: controller.text == "" ? "Type a message.." : "",
                  hintStyle: kTextFormFieldStyle.copyWith(
                    fontWeight: FontWeight.normal,
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    enteredMessage = value;
                  });
                },
              ),
            ),
          ),
          Align(
            alignment: width > 500 ? Alignment(1.05, 0) : Alignment(1.15, 0),
            child: controller.value.text != ""
                ? RaisedButton(
                    shape: CircleBorder(),
                    color: kSystemPrimaryColor,
                    child: Icon(
                      Icons.arrow_upward,
                      size: 25,
                      color: Colors.white,
                    ),
                    onPressed: enteredMessage.trim().isEmpty
                        ? null
                        : () async {
                            FocusScope.of(context).unfocus();
                            widget.sendMessage(enteredMessage);
                            controller.clear();
                          },
                  )
                : Container(
                    height: 0,
                    width: 0,
                  ),
          ),
        ],
      ),
    );
  }
}
