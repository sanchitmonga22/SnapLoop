import 'dart:ui';

import 'package:SnapLoop/app/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:validators/validators.dart';

/// author: @sanchitmonga22

class MessageBubbleView extends StatelessWidget {
  final String message;
  final bool isMe;
  final Key key;
  final String userRandomMemoji;
  final DateTime sent;
  final bool repeat;
  final bool showMemoji;
  final Color messageColor;
  final String gifUrl;
  // will create a check later whether the loop has been successfully completed or not
  final String username;

  const MessageBubbleView({
    this.gifUrl = "",
    this.messageColor,
    this.repeat = false,
    this.sent,
    this.message,
    this.showMemoji = true,
    this.isMe = false,
    this.key,
    this.username,
    this.userRandomMemoji = "",
  });

  DecorationImage getImage() {
    if (isNumeric(userRandomMemoji)) {
      return DecorationImage(
          fit: BoxFit.fitHeight,
          image: AssetImage("assets/memojis/m$userRandomMemoji.jpg"));
    } else {
      return DecorationImage(
          fit: BoxFit.fitHeight,
          image: CachedNetworkImageProvider(userRandomMemoji));
    }
  }

  CachedNetworkImage getGif() {
    return CachedNetworkImage(
      progressIndicatorBuilder: (context, url, progress) {
        return CircularProgressIndicator();
      },
      imageUrl: gifUrl,
      fit: BoxFit.contain,
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        if (gifUrl != "") {
          showDialog(
            context: context,
            builder: (context) {
              return BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: ksigmaX, sigmaY: ksigmaY),
                  child: AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      backgroundColor: Colors.white.withOpacity(0.1),
                      content: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.white,
                                  style: BorderStyle.solid,
                                  width: 2)),
                          child: getGif())));
            },
          );
        }
      },
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
              padding: EdgeInsets.only(top: repeat ? 3 : 10),
              constraints: BoxConstraints(maxWidth: width / 2),
              child: Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                children: [
                  if (repeat == false && showMemoji)
                    Padding(
                      padding: isMe
                          ? const EdgeInsets.only(left: 10)
                          : const EdgeInsets.only(right: 10),
                      child: CircleAvatar(
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(blurRadius: 5, color: Colors.white)
                            ],
                            shape: BoxShape.circle,
                            image: getImage(),
                          ),
                        ),
                      ),
                    ),
                  if (gifUrl != "")
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Column(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: isMe
                                          ? kSystemPrimaryColor
                                          : messageColor,
                                      style: BorderStyle.solid,
                                      width: 1.5)),
                              child: getGif()),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 2, horizontal: 5),
                            color: isMe ? kSystemPrimaryColor : messageColor,
                            width: double.infinity,
                            child: Text(
                              "${DateFormat('kk:mm').format(sent)}",
                              style: kTextFormFieldStyle.copyWith(fontSize: 10),
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (message != "")
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          color: isMe ? kSystemPrimaryColor : messageColor,
                          borderRadius: isMe
                              ? BorderRadius.only(
                                  topRight: Radius.circular(15),
                                  topLeft: Radius.circular(15),
                                  bottomLeft: repeat
                                      ? Radius.circular(0)
                                      : Radius.circular(15),
                                  bottomRight: Radius.circular(0))
                              : BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15),
                                  bottomRight: repeat
                                      ? Radius.circular(0)
                                      : Radius.circular(15),
                                  bottomLeft: Radius.circular(0))),
                      child: Column(
                        crossAxisAlignment: gifUrl != ""
                            ? CrossAxisAlignment.stretch
                            : isMe
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
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
              )),
        ],
      ),
    );
  }
}
