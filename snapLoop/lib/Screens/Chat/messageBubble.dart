import 'package:SnapLoop/Model/loop.dart';
import 'package:SnapLoop/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// author: @sanchitmonga22

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isMe;
  final Key key;
  final String userRandomMemoji;
  final DateTime sent;
  // will create a check later whether the loop has been successfully completed or not
  final String username;

  const MessageBubble({
    this.sent,
    this.message,
    this.isMe = false,
    this.key,
    this.username,
    this.userRandomMemoji = "",
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
            padding: EdgeInsets.only(top: 10),
            constraints:
                BoxConstraints(maxWidth: MediaQuery.of(context).size.width / 2),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment:
                      isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: isMe
                          ? const EdgeInsets.only(left: 10)
                          : const EdgeInsets.only(right: 10),
                      child: CircleAvatar(
                          child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 5,
                                color: determineLoopColor(LoopType.NEW_LOOP))
                          ],
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.fitHeight,
                              image: NetworkImage(userRandomMemoji)),
                        ),
                      )),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          color: isMe
                              ? kSystemPrimaryColor
                              : Colors.black.withOpacity(0.7),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                              bottomLeft: !isMe
                                  ? Radius.circular(0)
                                  : Radius.circular(15),
                              bottomRight: isMe
                                  ? Radius.circular(0)
                                  : Radius.circular(15))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            message,
                            style: kTextFormFieldStyle,
                          ),
                          Text(
                            "${DateFormat('kk:mm').format(sent)}",
                            style: kTextFormFieldStyle.copyWith(fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            )),
      ],
    );
  }
}
