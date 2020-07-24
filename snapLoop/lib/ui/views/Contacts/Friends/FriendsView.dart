import 'package:SnapLoop/ui/views/Contacts/ContactsDialog/ContactsDialogView.dart';
import 'package:SnapLoop/constants.dart';
import 'package:SnapLoop/ui/views/Contacts/Friends/FriendsViewModel.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'FriendsList/FriendsListView.dart';
import 'FriendsRequestIcon/FriendsRequestIconView.dart';

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

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return ViewModelBuilder.reactive(
        viewModelBuilder: () => FriendsViewModel(),
        createNewModelOnInsert: true,
        fireOnModelReadyOnce: true,
        onModelReady: (model) =>
            model.initialize(widget.loopName, widget.loopForwarding),
        builder: (context, model, child) {
          return Material(
              child: model.isBusy
                  ? Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(right: 10.0, left: 5),
                      child: Stack(
                        children: [
                          model.newLoop
                              ? Container()
                              // FriendsRequest Icon
                              : FriendsRequestIconView(),
                          // Search Bar
                          SearchBar(
                              minimumChars: 3,
                              searchBarPadding: model.newLoop
                                  ? EdgeInsets.only(top: 50)
                                  : EdgeInsets.only(right: 35),
                              suffix: model.newLoop
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
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
                                        onPressed: () async => model
                                            .sendRequest(index, userData)));
                              },
                              loader: Center(
                                  child: Container(
                                      height: 30,
                                      width: 30,
                                      child: CircularProgressIndicator())),
                              emptyWidget: Text(
                                  "No items found, Please try searching with a different name"),
                              onError: (error) {
                                return Text("Error");
                              },
                              onSearch: (String email) =>
                                  model.getUsersByEmail(email),
                              placeHolder: model.friends.length == 0
                                  ? Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Center(
                                        child: Text(
                                          "You don't currently have any friends! please search users above to add them as friend",
                                          style: kTextFormFieldStyle.copyWith(
                                              color: Colors.black),
                                        ),
                                      ),
                                    )
                                  : FriendsListView()),
                        ],
                      )));
        });
  }
}
