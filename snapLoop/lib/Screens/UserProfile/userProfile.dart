import 'package:SnapLoop/Model/user.dart';
import 'package:SnapLoop/Provider/Auth.dart';
import 'package:SnapLoop/Provider/UserDataProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

///author: @sanchitmonga22
class UserProfile extends StatefulWidget {
  static const routeName = './UserProfile';

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
    User user = Provider.of<UserDataProvider>(context, listen: false).user;

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
          "Username: ${user.username}",
          textAlign: TextAlign.left,
        ),
      ),
      ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
        title: Text(
          "Email address: ${user.email}",
          textAlign: TextAlign.left,
        ),
      ),
      ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
        title: Text(
          "DisplayName: ${user.displayName}",
          textAlign: TextAlign.left,
        ),
      ),
      ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
        title: Text(
          "Score: ${user.score}",
          textAlign: TextAlign.left,
        ),
      ),
      ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
        title: Text(
          "UserID: ${user.userID}",
          textAlign: TextAlign.left,
        ),
      ),
      ListTile(
        contentPadding: EdgeInsets.all(10),
        leading: Icon(Icons.exit_to_app),
        onTap: () {
          Navigator.of(context).pop();
          Navigator.of(context).pushNamed('/');
          return Provider.of<Auth>(context, listen: false).logOut();
        },
        title: Text("Logout"),
      )
    ]));
  }
}
