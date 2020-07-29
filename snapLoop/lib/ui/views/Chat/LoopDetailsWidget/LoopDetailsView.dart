import 'package:SnapLoop/Model/loop.dart';
import 'package:SnapLoop/Model/user.dart';
import 'package:SnapLoop/app/locator.dart';
import 'package:SnapLoop/services/LoopsDataService.dart';
import 'package:SnapLoop/services/UserDataService.dart';

import 'package:SnapLoop/ui/Widget/time/timer.dart';
import 'package:SnapLoop/app/router.gr.dart';
import 'package:SnapLoop/constants.dart';
import 'package:SnapLoop/ui/views/Home/LoopWidget/loopWidgetView.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:validators/validators.dart';

/// author: @sanchitmonga22
class LoopsDetailsView extends StatefulWidget {
  LoopsDetailsView(
      {Key key,
      this.loop,
      this.loopWidget,
      this.backgroundColor,
      this.chatWidget})
      : super(key: key);
  final LoopWidgetView loopWidget;
  final Loop loop;
  final Color backgroundColor;
  final Widget chatWidget;

  @override
  _LoopsDetailsViewState createState() => _LoopsDetailsViewState();
}

class _LoopsDetailsViewState extends State<LoopsDetailsView> {
  bool details = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          if (details) {
            setState(() {
              details = false;
            });
          } else if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop();
          } else {
            Navigator.of(context).pushReplacementNamed(Routes.navBarView);
          }
        },
        child: SafeArea(
          child: Scaffold(
            body: Stack(children: [
              Container(
                color: Colors.black.withOpacity(0.7),
              ),
              Container(
                  alignment: Alignment.topCenter,
                  decoration: BoxDecoration(
                      color: widget.backgroundColor.withOpacity(0.4)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: CupertinoButton(
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                if (details) {
                                  setState(() {
                                    details = false;
                                  });
                                } else {
                                  if (Navigator.of(context).canPop())
                                    Navigator.of(context).pop();
                                  else
                                    return;
                                  Navigator.pushReplacementNamed(
                                      context, Routes.navBarView);
                                }
                              },
                            ),
                          ),
                          // LOOP WIDGET here
                          widget.loopWidget,
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: CupertinoButton(
                              child: Icon(
                                CupertinoIcons.info,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                setState(() {
                                  details = !details;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            if (widget.loop != null &&
                                widget.loop.atTimeEnding != null &&
                                !kloopComplete(widget.loop.type))
                              LoopTimer(atTimeEnding: widget.loop.atTimeEnding),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Number of Member: ${widget.loop.numberOfMembers} ",
                              style: kTextFormFieldStyle,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AutoSizeText(
                                "Members",
                                style: kTextFormFieldStyle,
                                textAlign: TextAlign.left,
                                maxFontSize: 20,
                                minFontSize: 16,
                              ),
                              Container(
                                child: kloopComplete(widget.loop.type)
                                    ? Expanded(
                                        child: UserDetailsInLoopDetailsView(
                                          loop: widget.loop,
                                        ),
                                      )
                                    : Container(),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
              if (!details)
                Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.width / 5),
                    decoration: BoxDecoration(color: Colors.white),
                    child: widget.chatWidget)
            ]),
          ),
        ));
  }
}

class UserDetailsInLoopDetailsView extends StatefulWidget {
  const UserDetailsInLoopDetailsView({
    Key key,
    @required this.loop,
  }) : super(key: key);
  final Loop loop;

  @override
  _UserDetailsInLoopDetailsViewState createState() =>
      _UserDetailsInLoopDetailsViewState();
}

class _UserDetailsInLoopDetailsViewState
    extends State<UserDetailsInLoopDetailsView> {
  List<FriendsData> frnds = [];
  List<PublicUserData> users = [];
  List<DecorationImage> decImagesFrnds = [];
  List<DecorationImage> decImagesUsers = [];
  final _userDataService = locator<UserDataService>();
  Future future;
  DecorationImage myImage;
  Future myImageFuture;

  @override
  void initState() {
    super.initState();
    future = initializePublicData();
    myImageFuture = setMyImage();
  }

  Future<void> setMyImage() async {
    myImage = await getImage(
        widget.loop.avatars[_userDataService.userId], _userDataService.userId);
  }

  Future<DecorationImage> getImage(String imageUrl, String userId) async {
    DecorationImage image;
    // if the image is already numeric
    if (isNumeric(imageUrl)) {
      image = DecorationImage(
          fit: BoxFit.fitHeight,
          image: AssetImage("assets/memojis/m$imageUrl.jpg"));
      return image;
    }

    http.Response res = await http.get(imageUrl);
    if (res.statusCode >= 400) {
      int rand = kgetRandomImageNumber(17);
      final _loopDataService = locator<LoopsDataService>();
      _loopDataService.updateImageUrlToNumber(widget.loop.id, userId, rand);
      image = DecorationImage(
          fit: BoxFit.fitHeight,
          image: AssetImage("assets/memojis/m$rand.jpg"));
    } else {
      image =
          DecorationImage(fit: BoxFit.fitHeight, image: NetworkImage(imageUrl));
    }
    return image;
  }

  Future<void> initializePublicData() async {
    await _userDataService.updateFriends();
    for (int i = 0; i < widget.loop.userIDs.length; i++) {
      if (widget.loop.userIDs[i] == _userDataService.userId) {
        continue;
      }
      FriendsData frnd =
          _userDataService.getFriendsData(widget.loop.userIDs[i]);
      if (frnd == null) {
        users.add(
            await _userDataService.getUserDataById(widget.loop.userIDs[i]));
        decImagesUsers.add(await getImage(
            widget.loop.avatars[widget.loop.userIDs[i]],
            widget.loop.userIDs[i]));
      } else {
        frnds.add(frnd);
        decImagesFrnds.add(await getImage(
            widget.loop.avatars[widget.loop.userIDs[i]],
            widget.loop.userIDs[i]));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        return snapshot.connectionState == ConnectionState.waiting
            ? Center(
                child: Container(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(),
              ))
            : Column(
                children: [
                  FutureBuilder(
                    future: myImageFuture,
                    builder: (context, snapshot) {
                      return snapshot.connectionState == ConnectionState.waiting
                          ? CircularProgressIndicator()
                          : ListTile(
                              leading: CircleAvatar(
                                  child: Container(
                                      decoration: BoxDecoration(boxShadow: [
                                BoxShadow(blurRadius: 5, color: Colors.white)
                              ], shape: BoxShape.circle, image: myImage))),
                              title: AutoSizeText(
                                "ME",
                                style: kTextFormFieldStyle,
                              ),
                              trailing: AutoSizeText(
                                _userDataService.userScore.toString(),
                                style: kTextFormFieldStyle,
                              ),
                            );
                    },
                  ),
                  if (frnds.length != 0)
                    ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: CircleAvatar(
                                child: Container(
                                    decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(blurRadius: 5, color: Colors.white)
                              ],
                              shape: BoxShape.circle,
                              image: decImagesFrnds[index],
                            ))),
                            title: AutoSizeText(
                              frnds[index].username,
                              style: kTextFormFieldStyle,
                            ),
                            subtitle: AutoSizeText(
                              frnds[index].email,
                              style: kTextFormFieldStyle.copyWith(
                                  fontWeight: FontWeight.w400),
                            ),
                            trailing: AutoSizeText(
                              frnds[index].score.toString(),
                              style: kTextFormFieldStyle,
                            ),
                          );
                        },
                        itemCount: frnds.length),
                  if (users.length != 0)
                    ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: CircleAvatar(
                                child: Container(
                                    decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(blurRadius: 5, color: Colors.white)
                              ],
                              shape: BoxShape.circle,
                              image: decImagesUsers[index],
                            ))),
                            title: AutoSizeText(
                              users[index].username,
                              style: kTextFormFieldStyle,
                            ),
                            subtitle: AutoSizeText(
                              users[index].email,
                              style: kTextFormFieldStyle.copyWith(
                                  fontWeight: FontWeight.w400),
                            ),
                            trailing: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10)),
                                child: users[index].sentRequest ==
                                        RequestStatus.NOT_SENT
                                    ? RaisedButton(
                                        color: Colors.black.withOpacity(0.5),
                                        onPressed: () {},
                                        child: Text(
                                          "Add Friend",
                                          style: kTextFormFieldStyle.copyWith(
                                              fontWeight: FontWeight.w400),
                                        ))
                                    : RaisedButton(
                                        color: Colors.black.withOpacity(0.5),
                                        onPressed: null,
                                        child: Text(
                                          "Request Sent",
                                          style: kTextFormFieldStyle.copyWith(
                                              fontWeight: FontWeight.w400),
                                        ))),
                          );
                        },
                        itemCount: users.length),
                ],
              );
      },
    );
  }
}
