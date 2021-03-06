import 'package:SnapLoop/ui/views/Contacts/ContactsDialog/ContactsDialogView.dart';
import 'package:SnapLoop/app/constants.dart';
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
    double width = MediaQuery.of(context).size.width;
    super.build(context);

    return ViewModelBuilder.reactive(
        viewModelBuilder: () => FriendsViewModel(),
        onModelReady: (model) =>
            model.initialize(widget.loopName, widget.loopForwarding),
        builder: (context, model, child) {
          return Material(
              color: Colors.black,
              child: model.isBusy
                  ? Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : Padding(
                      padding: width > 500
                          ? const EdgeInsets.only(right: 30, left: 15)
                          : const EdgeInsets.only(right: 10.0, left: 5),
                      child: Stack(
                        children: [
                          model.newLoop
                              ? Container()
                              // FriendsRequest Icon
                              : FriendsRequestIconView(),
                          // Search Bar
                          SearchBar(
                              shrinkWrap: true,
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
                              cancellationWidget: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      width: 1,
                                      color: Colors.white.withOpacity(0.5)),
                                  color: Colors.white.withOpacity(0.1),
                                ),
                                padding: EdgeInsets.all(5),
                                child: Text(
                                  'Cancel',
                                  style: kTextFormFieldStyle,
                                ),
                              ),
                              onItemFound: (userData, int index) {
                                return Container(
                                    color: Colors.blue,
                                    child: ContactWidget(
                                        c: userData,
                                        isLoading: model.activeIndex == index,
                                        key: ValueKey(index),
                                        onPressed: () async {
                                          await model.sendRequest(
                                              index, userData);
                                          setState(() {});
                                        }));
                              },
                              loader: Center(
                                  child: Container(
                                      height: 30,
                                      width: 30,
                                      child: CircularProgressIndicator())),
                              emptyWidget: Text(
                                "No items found, Please try searching with a different name",
                                style: kTextFormFieldStyle,
                              ),
                              onError: (error) {
                                print(error.toString());
                                return Text("Error");
                              },
                              onSearch: (String email) =>
                                  model.getUsersByEmail(email),
                              placeHolder: model.friends.length == 0
                                  ? Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Center(
                                        child: Text(
                                          "Please search users above to add them as friend",
                                          style: kTextFormFieldStyle.copyWith(
                                              color: Colors.white),
                                        ),
                                      ),
                                    )
                                  : FriendsListView()),
                        ],
                      )));
        });
  }
}
