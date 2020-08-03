import 'dart:ui';

import 'package:SnapLoop/app/locator.dart';
import 'package:SnapLoop/services/ChatDataService.dart';
import 'package:SnapLoop/ui/views/Chat/NewMessage/newMessageView.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../../app/constants.dart';

class GIFSelection extends StatefulWidget {
  final Function sendMessage;
  final Function cancel;
  GIFSelection({Key key, this.sendMessage, this.cancel}) : super(key: key);
  @override
  _GIFSelectionState createState() => _GIFSelectionState();
}

class _GIFSelectionState extends State<GIFSelection> {
  List<dynamic> results = [];
  String selectedFinalUrl = "";
  bool gifOptionSelected = true;
  final _chatDataService = locator<ChatDataService>();
  final controller = new TextEditingController();
  double width = 0;
  String search = "";
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
          width: double.infinity,
          color: Colors.white.withOpacity(0.9),
          constraints: BoxConstraints(maxHeight: 230),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: width / 2,
                      padding: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: Colors.black.withOpacity(0.8), width: 2),
                          color: Colors.black.withOpacity(0.7)),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxHeight: 35),
                        child: TextField(
                          textAlign: TextAlign.left,
                          keyboardType: TextInputType.text,
                          cursorColor: kSystemPrimaryColor,
                          controller: controller,
                          textCapitalization: TextCapitalization.sentences,
                          autocorrect: true,
                          enableSuggestions: true,
                          maxLines: 1,
                          style: kTextFormFieldStyle.copyWith(
                              fontSize: 14, fontWeight: FontWeight.normal),
                          decoration: InputDecoration(
                            suffixIcon: GestureDetector(
                              onTap: () async {
                                results = await _chatDataService.getGifs(
                                    search, !gifOptionSelected);
                                setState(() {});
                                //search with the entered search
                              },
                              child: Icon(
                                Icons.search,
                                color: Colors.white,
                              ),
                            ),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            border: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText:
                                controller.text == "" ? "Search here..." : "",
                            hintStyle: kTextFormFieldStyle.copyWith(
                                fontWeight: FontWeight.w100, fontSize: 14),
                          ),
                          onChanged: (value) {
                            setState(() {
                              search = value;
                            });
                          },
                        ),
                      ),
                    ),
                    GestureDetector(
                      child: CircleAvatar(
                        backgroundColor: gifOptionSelected
                            ? kSystemPrimaryColor
                            : Colors.grey,
                        child: Icon(
                          Icons.gif,
                          color: Colors.white,
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          gifOptionSelected = true;
                        });
                      },
                    ),
                    GestureDetector(
                      child: CircleAvatar(
                        backgroundColor: gifOptionSelected
                            ? Colors.grey
                            : kSystemPrimaryColor,
                        child: Icon(
                          Icons.add_photo_alternate,
                          color: Colors.white,
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          gifOptionSelected = false;
                        });
                      },
                    ),
                    FlatButton(
                      child: AutoSizeText(
                        'Cancel',
                        style:
                            kTextFormFieldStyle.copyWith(color: Colors.black),
                      ),
                      onPressed: () {
                        widget.cancel(true);
                      },
                    )
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    String url = results[index]['url'];
                    return Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.white,
                              style: BorderStyle.solid,
                              width: 2)),
                      child: Padding(
                        padding: const EdgeInsets.all(3),
                        child: GestureDetector(
                          onTap: () async {
                            selectedFinalUrl = results[index]['original'];
                            controller.clear();
                            FocusScope.of(context).unfocus();
                            showDialog(
                              context: context,
                              builder: (context) {
                                return BackdropFilter(
                                    filter: ImageFilter.blur(
                                        sigmaX: ksigmaX, sigmaY: ksigmaY),
                                    child: AlertDialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0)),
                                        backgroundColor: Colors.black45,
                                        content: SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              Container(
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.white,
                                                          style:
                                                              BorderStyle.solid,
                                                          width: 2)),
                                                  child: Image(
                                                      fit: BoxFit.contain,
                                                      image: NetworkImage(
                                                          results[index]
                                                              ['original']))),
                                              NewMessageView(
                                                sendMessage:
                                                    (enteredMessage) async {
                                                  await widget.sendMessage(
                                                      enteredMessage,
                                                      selectedFinalUrl);
                                                  Navigator.of(context).pop();
                                                },
                                                gifSelected: true,
                                              )
                                            ],
                                          ),
                                        )));
                              },
                            );
                          },
                          child: Container(
                            width: 200,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage('$url'),
                                    fit: BoxFit.cover)),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: results.length,
                ),
              )
            ],
          )),
    );
  }
}
