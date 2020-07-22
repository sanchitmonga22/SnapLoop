import 'dart:ui';
import 'package:SnapLoop/Model/user.dart';
import 'package:SnapLoop/Provider/LoopsProvider.dart';
import 'package:SnapLoop/app/locator.dart';
import 'package:SnapLoop/app/router.gr.dart';
import 'package:SnapLoop/services/UserDataService.dart';
import 'package:SnapLoop/ui/views/chat/ExistingLoopChat/ExistingLoopChatView.dart';
import 'package:SnapLoop/ui/views/Contacts/ContactsDialog/ContactsDialogView.dart';
import 'package:SnapLoop/ui/views/Contacts/FriendsRequestDialog/FriendRequestDialog.dart';
import 'package:SnapLoop/Widget/CreateANewLoopDialog/createLoopDialog.dart';
import 'package:SnapLoop/constants.dart';
import 'package:SnapLoop/ui/views/Contacts/Contacts/ContactsViewModel.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

class FriendsView extends StatefulWidget {
  final String loopName;
  final bool loopForwarding;
  FriendsView({Key key, this.loopName = "", this.loopForwarding = false})
      : super(key: key);

  @override
  _FriendsViewState createState() => _FriendsViewState();
}

class _FriendsViewState extends State<FriendsView>
    with AutomaticKeepAliveClientMixin<FriendsView> {
  @override
  bool get wantKeepAlive => true;

  Future future;
  List<FriendsData> friends = [];
  bool newLoop = false;
  final _userData = locator<UserDataService>();

  @override
  void initState() {
    super.initState();
    future = initializeScreen();
  }

  Future<void> initializeScreen() async {
    await _userData.updateFriends();
    await _userData.updateRequests();
    friends = _userData.friends;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (widget.loopName != "") newLoop = true;

    return ViewModelBuilder.reactive(
        viewModelBuilder: () => ContactsViewModel(),
        builder: (context, model, child) {
          return Material(
              child: Padding(
                  padding: const EdgeInsets.only(right: 10.0, left: 5),
                  child: Stack(
                    children: [
                      newLoop
                          ? Container()
                          : Align(
                              alignment: Alignment(1.05, -0.95),
                              child: GestureDetector(
                                onTap: () {
                                  model.createADialog(
                                      context, FriendRequestsDialog());
                                },
                                child: Container(
                                  padding: EdgeInsets.only(top: 10),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.black,
                                    child: Stack(
                                      children: [
                                        Align(
                                          alignment: Alignment(0, 0),
                                          child: Icon(
                                            Icons.person,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment(1, -1.5),
                                          child: CircleAvatar(
                                            radius: 11,
                                            // add the number of current requests received
                                            child: Text(model
                                                .getNumberOfRequestsReceived(
                                                    context)),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                      SearchBar(
                          minimumChars: 3,
                          searchBarPadding: newLoop
                              ? EdgeInsets.only(top: 50)
                              : EdgeInsets.only(right: 35),
                          suffix: newLoop
                              ? Row(
                                  mainAxisSize: MainAxisSize.min,
                                )
                              : GestureDetector(
                                  onTap: () {
                                    model.createADialog(
                                        context, ContactsDialogView());
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(right: 10),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Icon(
                                          Icons.add,
                                          color: Colors.white,
                                        ),
                                        Icon(
                                          Icons.people,
                                          color: Colors.white,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                          cursorColor: Colors.white,
                          searchBarStyle: SearchBarStyle(
                            padding: EdgeInsets.only(left: 25),
                            backgroundColor: kSystemPrimaryColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          icon: Icon(Icons.search),
                          hintStyle: kTextFormFieldStyle.copyWith(
                              color: Colors.white70),
                          textStyle: kTextFormFieldStyle,
                          searchBarController: model.controller,
                          //searchBarPadding: EdgeInsets.all(10),
                          hintText: "Enter here",
                          iconActiveColor: Colors.white,
                          // check this
                          buildSuggestion: (item, index) {
                            return Container(
                              color: Colors.blue,
                              child: ListTile(
                                key: ValueKey(index),
                                title: item.username,
                              ),
                            );
                          },
                          onItemFound: (userData, int index) {
                            return Container(
                                color: Colors.blue,
                                child: ContactWidget(
                                    c: userData,
                                    isLoading: model.activeIndex == index,
                                    // FIXME: requestSentIndex causes to show the request sent at the same index
                                    requestSent:
                                        model.requestSentIndex == index,
                                    key: ValueKey(index),
                                    onPressed: () async => model.sendRequest(
                                        index, context, userData)));
                          },
                          loader: Center(
                              child: Container(
                                  height: 30,
                                  width: 30,
                                  child: CircularProgressIndicator())),
                          emptyWidget: Text(
                              "No items found, Please try searching with a different name"),
                          onError: (error) {
                            print(error);
                            return Text("Error");
                          },
                          onSearch: (String email) =>
                              model.getUsersByEmail(email, context),
                          placeHolder: FutureBuilder(
                              future: future,
                              builder: (context, snapshot) {
                                return snapshot.connectionState ==
                                        ConnectionState.waiting
                                    ? Material(
                                        child: Center(
                                          child: Container(
                                            height: 30,
                                            width: 30,
                                            child: CircularProgressIndicator(),
                                          ),
                                        ),
                                      )
                                    : friends.length == 0
                                        ? Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: Center(
                                              child: Text(
                                                "You don't currently have any friends! please search users above to add them as friend",
                                                style: kTextFormFieldStyle
                                                    .copyWith(
                                                        color: Colors.black),
                                              ),
                                            ),
                                          )
                                        : ListView.builder(
                                            itemCount: friends.length,
                                            itemBuilder: (context, index) {
                                              FriendsData friend =
                                                  friends[index];
                                              final friendsLoops =
                                                  Provider.of<LoopsProvider>(
                                                          context,
                                                          listen: false)
                                                      .getLoopInforByIds(
                                                          friend.commonLoops);
                                              return Slidable(
                                                actionPane:
                                                    SlidableDrawerActionPane(),
                                                actions: <Widget>[
                                                  IconSlideAction(
                                                    caption: 'Start new',
                                                    color: Colors.black,
                                                    icon: CupertinoIcons.loop,
                                                    onTap: () {
                                                      showDialog(
                                                          context: context,
                                                          barrierDismissible:
                                                              false,
                                                          builder: (context) {
                                                            return CreateALoopDialog(
                                                              friend: friend,
                                                            );
                                                          });
                                                    },
                                                  ),
                                                ],
                                                child: ExpansionTile(
                                                  onExpansionChanged: (value) {
                                                    if (value && newLoop) {
                                                      if (!widget
                                                          .loopForwarding)
                                                        Navigator
                                                            .pushReplacementNamed(
                                                          context,
                                                          Routes
                                                              .newLoopChatScreen,
                                                          arguments:
                                                              NewLoopChatScreenArguments(
                                                                  loopName: widget
                                                                      .loopName,
                                                                  userData:
                                                                      friend),
                                                        );
                                                      else
                                                        Navigator.of(context)
                                                            .pop(friend);
                                                    }
                                                  },
                                                  backgroundColor: Colors.black,
                                                  maintainState: true,
                                                  title: Text(
                                                    friend.displayName,
                                                    style: kTextFormFieldStyle
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                kSystemPrimaryColor),
                                                  ),
                                                  leading: CircleAvatar(
                                                    child: friend.avatar ??
                                                        Icon(Icons.person),
                                                    backgroundColor:
                                                        kSystemPrimaryColor,
                                                  ),
                                                  trailing: Text(
                                                    "Score: ${friend.score}",
                                                    style: kTextFormFieldStyle
                                                        .copyWith(
                                                            color:
                                                                kSystemPrimaryColor),
                                                  ),
                                                  subtitle: AutoSizeText(
                                                    friend.email,
                                                    style: kTextFormFieldStyle
                                                        .copyWith(
                                                            color:
                                                                kSystemPrimaryColor),
                                                  ),
                                                  children: [
                                                    newLoop
                                                        ? Container()
                                                        : Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(15.0),
                                                            child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Text(
                                                                    "Status: ${friend.status}",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style: kTextFormFieldStyle.copyWith(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        fontSize:
                                                                            15),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 5,
                                                                  ),
                                                                  Text(
                                                                    "User ID: ${friend.userID}",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style: kTextFormFieldStyle
                                                                        .copyWith(),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 5,
                                                                  ),
                                                                  ExpansionTile(
                                                                    title: Text(
                                                                      "Common Loops",
                                                                      style: kTextFormFieldStyle.copyWith(
                                                                          fontWeight:
                                                                              FontWeight.normal),
                                                                    ),
                                                                    children: [
                                                                      friendsLoops
                                                                              .isEmpty
                                                                          ? Container(
                                                                              decoration: BoxDecoration(
                                                                                border: Border.all(color: Colors.white, width: 1),
                                                                              ),
                                                                              child: ListTile(
                                                                                title: AutoSizeText(
                                                                                  "You don't have any loops in common with ${friend.username}.",
                                                                                  style: kTextFormFieldStyle.copyWith(color: kSystemPrimaryColor, fontSize: 15, fontWeight: FontWeight.w100),
                                                                                  maxLines: 3,
                                                                                ),
                                                                                subtitle: AutoSizeText(
                                                                                  "Click on the icon to start a new loop with the user!",
                                                                                  style: kTextFormFieldStyle.copyWith(fontWeight: FontWeight.w100),
                                                                                ),
                                                                                trailing: GestureDetector(
                                                                                  onTap: () {
                                                                                    showDialog(
                                                                                      context: context,
                                                                                      barrierDismissible: false,
                                                                                      builder: (context) {
                                                                                        return CreateALoopDialog(
                                                                                          friend: friend,
                                                                                        );
                                                                                      },
                                                                                    );
                                                                                  },
                                                                                  child: Row(
                                                                                    mainAxisSize: MainAxisSize.min,
                                                                                    children: [
                                                                                      Icon(
                                                                                        CupertinoIcons.loop,
                                                                                        color: Colors.white,
                                                                                      ),
                                                                                      Icon(CupertinoIcons.add, color: Colors.white, size: 15)
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            )
                                                                          : ListView
                                                                              .builder(
                                                                              itemCount: friendsLoops.length,
                                                                              scrollDirection: Axis.vertical,
                                                                              shrinkWrap: true,
                                                                              itemBuilder: (context, index) {
                                                                                return Container(
                                                                                  decoration: BoxDecoration(color: determineLoopColor(friendsLoops[index].type).withOpacity(0.7)),
                                                                                  child: ListTile(
                                                                                      onTap: () {
                                                                                        Navigator.pushReplacement(
                                                                                            context,
                                                                                            new MaterialPageRoute(
                                                                                                builder: (context) => ExistingLoopChatView(
                                                                                                      key: ValueKey(index),
                                                                                                      loop: friendsLoops[index],
                                                                                                      radius: kradiusCalculator(friendsLoops[index].numberOfMembers, MediaQuery.of(context).size.width * 0.25),
                                                                                                    )));
                                                                                      },
                                                                                      dense: true,
                                                                                      title: Text(friendsLoops[index].name, style: kTextFormFieldStyle)),
                                                                                );
                                                                              },
                                                                            ),
                                                                    ],
                                                                  ),
                                                                  ExpansionTile(
                                                                    title: Text(
                                                                      "Mutual Friends",
                                                                      style: kTextFormFieldStyle.copyWith(
                                                                          fontWeight:
                                                                              FontWeight.normal),
                                                                    ),
                                                                    children: [
                                                                      friend.mutualFriendsIDs
                                                                              .isEmpty
                                                                          ? Container(
                                                                              //     padding: const EdgeInsets.all(12.0),
                                                                              decoration: BoxDecoration(
                                                                                border: Border.all(color: Colors.white, width: 1),
                                                                              ),
                                                                              child: ListTile(
                                                                                title: AutoSizeText(
                                                                                  "You don't currently have any mutual friends with ${friend.username}",
                                                                                  style: kTextFormFieldStyle.copyWith(color: kSystemPrimaryColor, fontSize: 15, fontWeight: FontWeight.w100),
                                                                                  maxLines: 3,
                                                                                ),
                                                                                subtitle: AutoSizeText(
                                                                                  "Click on the icon to add friends from your contacts",
                                                                                  style: kTextFormFieldStyle.copyWith(fontWeight: FontWeight.w100),
                                                                                ),
                                                                                trailing: GestureDetector(
                                                                                  onTap: () {
                                                                                    model.createADialog(context, ContactsDialogView());
                                                                                  },
                                                                                  child: Row(
                                                                                    mainAxisSize: MainAxisSize.min,
                                                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                                                    children: [
                                                                                      Icon(
                                                                                        Icons.add,
                                                                                        color: Colors.white,
                                                                                      ),
                                                                                      Icon(
                                                                                        Icons.people,
                                                                                        color: Colors.white,
                                                                                      )
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            )
                                                                          : ListView
                                                                              .builder(
                                                                              itemCount: friend.mutualFriendsIDs.length,
                                                                              scrollDirection: Axis.vertical,
                                                                              shrinkWrap: true,
                                                                              itemBuilder: (context, index) {
                                                                                List<FriendsData> mutualFriends = model.getMutualFriendsData(friends, friend.mutualFriendsIDs);
                                                                                return ListTile(
                                                                                  dense: true,
                                                                                  title: AutoSizeText(mutualFriends[index].displayName, style: kTextFormFieldStyle.copyWith(fontSize: 15, fontWeight: FontWeight.normal)),
                                                                                  trailing: Text("Score ${mutualFriends[index].score}", style: kTextFormFieldStyle.copyWith(fontSize: 12, fontWeight: FontWeight.normal)),
                                                                                );
                                                                              },
                                                                            ),
                                                                    ],
                                                                  ),
                                                                ]),
                                                          )
                                                  ],
                                                ),
                                              );
                                            },
                                          );
                              })),
                    ],
                  )));
        });
  }
}
