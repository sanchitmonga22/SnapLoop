import 'package:SnapLoop/app/router.gr.dart';
import 'package:SnapLoop/app/constants.dart';
import 'package:SnapLoop/ui/Widget/ImagePickerDialog/ImagePickerDialog.dart';
import 'package:SnapLoop/ui/views/Profile/UserProfileViewModel.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

///author: @sanchitmonga22
class UserProfileView extends StatefulWidget {
  const UserProfileView({Key key}) : super(key: key);

  @override
  _UserProfileViewState createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView>
    with AutomaticKeepAliveClientMixin<UserProfileView> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => UserProfileViewModel(),
      builder: (context, model, child) {
        return Container(
            child: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    title: GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => ImagePicketDialog(
                              remove:
                                  model.user.myAvatar == null ? false : true,
                            ),
                          );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.blue,
                              child: model.user.myAvatar == null
                                  ? AutoSizeText(
                                      model.user.username[0].toUpperCase(),
                                      style: kTextFormFieldStyle.copyWith(
                                          fontSize: 40),
                                    )
                                  : ClipOval(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.black,
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: MemoryImage(
                                                model.user.myAvatar,
                                              )),
                                        ),
                                      ),
                                    ),
                            )
                          ],
                        )),
                  ),
                  SizedBox(height: 20),
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
                      await model.logout();
                      Navigator.pushReplacementNamed(context, Routes.snapLoop);
                    },
                    title: Text("Logout"),
                  )
                ]),
          ),
        ));
      },
    );
  }
}
