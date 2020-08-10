import 'package:SnapLoop/Model/user.dart';
import 'package:SnapLoop/ui/views/Contacts/ContactsDialog/ContactsDialogView.dart';
import 'package:SnapLoop/ui/views/Contacts/Friends/FriendsViewModel.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

import '../../../../../app/constants.dart';

class MutualFriendsExpView extends HookViewModelWidget<FriendsViewModel> {
  final FriendsData friend;
  MutualFriendsExpView({Key key, @required this.friend}) : super(key: key);
  @override
  Widget buildViewModelWidget(BuildContext context, FriendsViewModel model) {
    return ExpansionTile(
      title: Text(
        "Mutual Friends",
        style: kTextFormFieldStyle.copyWith(fontWeight: FontWeight.normal),
      ),
      children: [
        friend.mutualFriendsIDs.isEmpty
            ? Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 1),
                ),
                child: ListTile(
                  title: AutoSizeText(
                    "You don't currently have any mutual friends with ${friend.username}",
                    style: kTextFormFieldStyle.copyWith(
                        color: kSystemPrimaryColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w100),
                    maxLines: 3,
                  ),
                  subtitle: AutoSizeText(
                    "Click on the icon to add friends from your contacts",
                    style: kTextFormFieldStyle.copyWith(
                        fontWeight: FontWeight.w100),
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
            : ListView.builder(
                itemCount: friend.mutualFriendsIDs.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  List<FriendsData> mutualFriends =
                      model.getMutualFriendsData(friend.mutualFriendsIDs);
                  return ListTile(
                    dense: true,
                    title: AutoSizeText(mutualFriends[index].username,
                        style: kTextFormFieldStyle.copyWith(
                            fontSize: 15, fontWeight: FontWeight.normal)),
                    trailing: Text("Score ${mutualFriends[index].score}",
                        style: kTextFormFieldStyle.copyWith(
                            fontSize: 12, fontWeight: FontWeight.normal)),
                  );
                },
              ),
      ],
    );
  }
}
