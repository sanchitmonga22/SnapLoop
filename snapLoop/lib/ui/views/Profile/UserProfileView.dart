import 'package:SnapLoop/ui/views/Profile/UserProfileViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

///author: @sanchitmonga22
class UserProfile extends StatefulWidget {
  const UserProfile({Key key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile>
    with AutomaticKeepAliveClientMixin<UserProfile> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => UserProfileViewModel(),
      builder: (context, model, child) {
        return Container(
            child: ListView(children: [
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            title: CircleAvatar(
              radius: 40,
              child: Icon(Icons.person, size: 50),
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            title: Text(
              "Username: ${model.user.username}",
              textAlign: TextAlign.left,
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            title: Text(
              "Email address: ${model.user.email}",
              textAlign: TextAlign.left,
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            title: Text(
              "DisplayName: ${model.user.displayName}",
              textAlign: TextAlign.left,
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            title: Text(
              "Score: ${model.user.score}",
              textAlign: TextAlign.left,
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            title: Text(
              "UserID: ${model.user.userID}",
              textAlign: TextAlign.left,
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.all(10),
            leading: Icon(Icons.exit_to_app),
            onTap: () async {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed('/');
              model.logout();
            },
            title: Text("Logout"),
          )
        ]));
      },
    );
  }
}
