import 'package:SnapLoop/Model/user.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class MutualFriendsTile extends StatelessWidget {
  const MutualFriendsTile({Key key, this.friend, this.friends})
      : super(key: key);
  final FriendsData friend;
  final List<FriendsData> friends;

  List<FriendsData> getMutualFriendsData(
      List<FriendsData> allFriends, List<String> mutualFriendsIDs) {
    List<FriendsData> mutualFriendsData = [];
    mutualFriendsIDs.forEach((e) {
      allFriends.forEach((element) {
        if (element.userID == e) {
          mutualFriendsData.add(element);
        }
      });
    });
    return mutualFriendsData;
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        "Mutual Friends",
        style: kTextFormFieldStyle.copyWith(fontWeight: FontWeight.normal),
      ),
      children: [
        friend.mutualFriendsIDs.isEmpty
            ? Container(
                padding: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 1),
                ),
                child: AutoSizeText(
                  "You don't currently have any mutual friends with ${friend.username}",
                  maxLines: 2,
                  style: kTextFormFieldStyle.copyWith(
                      color: kSystemPrimaryColor,
                      fontWeight: FontWeight.normal),
                ),
              )
            : ListView.builder(
                itemCount: friend.mutualFriendsIDs.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  List<FriendsData> mutualFriends =
                      getMutualFriendsData(friends, friend.mutualFriendsIDs);
                  return ListTile(
                    dense: true,
                    title: AutoSizeText(mutualFriends[index].displayName,
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
