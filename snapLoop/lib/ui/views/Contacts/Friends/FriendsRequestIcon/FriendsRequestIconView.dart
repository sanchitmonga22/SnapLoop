import 'package:SnapLoop/ui/views/Contacts/Friends/FriendsViewModel.dart';
import 'package:SnapLoop/ui/views/Contacts/FriendsRequestDialog/FriendRequestDialog.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class FriendsRequestIconView extends StatelessWidget {
  const FriendsRequestIconView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => FriendsViewModel(),
      builder: (context, model, child) => Align(
        alignment: Alignment(1.05, -0.95),
        child: GestureDetector(
          onTap: () {
            model.createADialog(context, FriendRequestsDialog());
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 0.5)),
              child: CircleAvatar(
                backgroundColor: Colors.white.withOpacity(0.3),
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
                        child: Text(model.getNumberOfRequestsReceived()),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
