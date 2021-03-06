import 'package:SnapLoop/Model/user.dart';
import 'package:SnapLoop/app/router.gr.dart';
import 'package:SnapLoop/ui/Widget/CreateANewLoopDialog/createLoopDialog.dart';
import 'package:SnapLoop/ui/views/Contacts/Friends/CommonLoopsExpansionTile/CommonLoopsExpansionTileView.dart';
import 'package:SnapLoop/ui/views/Contacts/Friends/FriendsViewModel.dart';
import 'package:SnapLoop/ui/views/Contacts/Friends/MutualFriendsExpansionTileView/MutualFriendsExpTileView.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../../../../app/constants.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

class FriendsListView extends HookViewModelWidget<FriendsViewModel> {
  @override
  Widget buildViewModelWidget(BuildContext context, FriendsViewModel model) {
    return ListView.builder(
        itemCount: model.friends.length,
        itemBuilder: (context, index) {
          FriendsData friend = model.friends[index];
          final friendsLoops = model.getLoopInfoByIds(friend.commonLoops);
          return Slidable(
            actionPane: SlidableDrawerActionPane(),
            actions: <Widget>[
              if (model.newLoop == false)
                IconSlideAction(
                  caption: 'Start new',
                  color: Colors.black,
                  icon: CupertinoIcons.loop_thick,
                  closeOnTap: true,
                  onTap: () {
                    showDialog(
                        context: context,
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
                if (value && model.newLoop) {
                  if (!model.loopForwarding)
                    Navigator.pushReplacementNamed(
                      context,
                      Routes.newLoopChatView,
                      arguments: NewLoopChatViewArguments(
                          loopName: model.loopName, friend: friend),
                    );
                  else
                    Navigator.of(context).pop(friend);
                }
              },
              maintainState: true,
              title: Text(
                friend.username,
                style:
                    kTextFormFieldStyle.copyWith(fontWeight: FontWeight.bold),
              ),
              leading: CircleAvatar(
                child: friend.avatar == null
                    ? AutoSizeText(
                        friend.username[0].toUpperCase(),
                        style: kTextFormFieldStyle,
                      )
                    : ClipOval(
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: MemoryImage(
                                  friend.avatar,
                                )),
                          ),
                        ),
                      ),
                backgroundColor: kSystemPrimaryColor,
              ),
              trailing: Text(
                "Score: ${friend.score}",
                style: kTextFormFieldStyle,
              ),
              subtitle: AutoSizeText(
                friend.email,
                style: kTextFormFieldStyle,
              ),
              children: [
                model.newLoop
                    ? Container()
                    : Container(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Status: ${friend.status}",
                                textAlign: TextAlign.left,
                                style: kTextFormFieldStyle.copyWith(
                                    fontWeight: FontWeight.w600, fontSize: 15),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "User ID: ${friend.userID}",
                                textAlign: TextAlign.left,
                                style: kTextFormFieldStyle.copyWith(),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              CommonLoopsExpansionTileView(
                                  friendsLoops: friendsLoops,
                                  friend: friend,
                                  key: ValueKey(index)),
                              MutualFriendsExpView(
                                  friend: friend, key: ValueKey(index))
                            ]),
                      )
              ],
            ),
          );
        });
  }
}
