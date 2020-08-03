import 'package:SnapLoop/Model/loop.dart';
import 'package:SnapLoop/Model/user.dart';
import 'package:SnapLoop/app/locator.dart';
import 'package:SnapLoop/services/LoopsDataService.dart';
import 'package:SnapLoop/services/UserDataService.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:validators/validators.dart';

import '../../../../app/constants.dart';
import 'package:http/http.dart' as http;

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
      image = DecorationImage(
          fit: BoxFit.fitHeight, image: CachedNetworkImageProvider(imageUrl));
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
    return Expanded(
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
            Expanded(
              child: FutureBuilder(
                future: future,
                builder: (context, snapshot) {
                  return snapshot.connectionState == ConnectionState.waiting
                      ? Center(
                          child: Container(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(),
                        ))
                      : SingleChildScrollView(
                          child: Column(
                            children: [
                              FutureBuilder(
                                future: myImageFuture,
                                builder: (context, snapshot) {
                                  return snapshot.connectionState ==
                                          ConnectionState.waiting
                                      ? CircularProgressIndicator()
                                      : ListTile(
                                          leading: CircleAvatar(
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                      boxShadow: [
                                                BoxShadow(
                                                    blurRadius: 5,
                                                    color: Colors.white)
                                              ],
                                                      shape: BoxShape.circle,
                                                      image: myImage))),
                                          title: AutoSizeText(
                                            "ME",
                                            style: kTextFormFieldStyle,
                                          ),
                                          trailing: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              if (_userDataService.userId ==
                                                  widget.loop.creatorId)
                                                AutoSizeText("Creator",
                                                    style: kTextFormFieldStyle),
                                              AutoSizeText(
                                                _userDataService.userScore
                                                    .toString(),
                                                style: kTextFormFieldStyle,
                                              ),
                                            ],
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
                                            BoxShadow(
                                                blurRadius: 5,
                                                color: Colors.white)
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
                                        trailing: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            if (frnds[index].userID ==
                                                widget.loop.creatorId)
                                              AutoSizeText("Creator",
                                                  style: kTextFormFieldStyle),
                                            AutoSizeText(
                                              frnds[index].score.toString(),
                                              style: kTextFormFieldStyle,
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    itemCount: frnds.length),
                              //NOTE:
                              // will not show members other than their friends in the loop
                              if (users.length != 0 &&
                                  widget.loop.type !=
                                      LoopType.INACTIVE_LOOP_FAILED)
                                ListView.builder(
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        leading: CircleAvatar(
                                            child: Container(
                                                decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                                blurRadius: 5,
                                                color: Colors.white)
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
                                        trailing: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            if (users[index].userID ==
                                                widget.loop.creatorId)
                                              AutoSizeText("Creator",
                                                  style: kTextFormFieldStyle),
                                            Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: users[index]
                                                            .sentRequest ==
                                                        RequestStatus.NOT_SENT
                                                    ? RaisedButton(
                                                        color: Colors.black
                                                            .withOpacity(0.5),
                                                        onPressed: () async {
                                                          await _userDataService
                                                              .sendFriendRequest(
                                                                  users[index]
                                                                      .userID);
                                                          setState(() {});
                                                        },
                                                        child: Text(
                                                          "Add Friend",
                                                          style: kTextFormFieldStyle
                                                              .copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                        ))
                                                    : RaisedButton(
                                                        color: Colors.black
                                                            .withOpacity(0.5),
                                                        onPressed: null,
                                                        child: Text(
                                                          users[index].sentRequest ==
                                                                  RequestStatus
                                                                      .REQUEST_RECEIVED
                                                              ? "Request Received"
                                                              : "Request Sent",
                                                          style: kTextFormFieldStyle
                                                              .copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                        ))),
                                          ],
                                        ),
                                      );
                                    },
                                    itemCount: users.length),
                            ],
                          ),
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
