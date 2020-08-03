import 'package:SnapLoop/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// author: @sanchitmonga22
class NewMessageView extends StatefulWidget {
  final Function sendMessage;
  final Function gifSelection;
  final bool gifSelected;

  const NewMessageView(
      {Key key, this.sendMessage, this.gifSelection, this.gifSelected = false})
      : super(key: key);

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
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.3), width: 2),
          color: Colors.white.withOpacity(0.1)),
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(
                right: 40, left: controller.value.text != "" ? 10 : 45),
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
          if (controller.value.text != "" || widget.gifSelected)
            Align(
                alignment:
                    width > 500 ? Alignment(1.05, 0) : Alignment(1.15, 0),
                child: RaisedButton(
                  shape: CircleBorder(),
                  color: kSystemPrimaryColor,
                  child: Icon(
                    Icons.arrow_upward,
                    size: 25,
                    color: Colors.white,
                  ),
                  onPressed:
                      enteredMessage.trim().isEmpty && !widget.gifSelected
                          ? null
                          : () async {
                              FocusScope.of(context).unfocus();
                              await widget.sendMessage(enteredMessage);
                              controller.clear();
                            },
                ))
          else if (!widget.gifSelected)
            Padding(
              padding: const EdgeInsets.only(top: 4, left: 2, right: 2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      print('camera');
                    },
                    child: CircleAvatar(
                      radius: 20,
                      child: Icon(
                        CupertinoIcons.photo_camera_solid,
                        size: 25,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          print('photoLibrary');
                        },
                        child: CircleAvatar(
                          child: Icon(
                            Icons.photo_library,
                            size: 25,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      GestureDetector(
                        onTap: () {
                          widget.gifSelection(true);
                          FocusScope.of(context).unfocus();
                        },
                        child: CircleAvatar(
                          child: Icon(
                            Icons.gif,
                            size: 25,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
