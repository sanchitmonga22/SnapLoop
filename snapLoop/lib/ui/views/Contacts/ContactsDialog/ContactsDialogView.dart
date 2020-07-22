import 'package:SnapLoop/Model/user.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../constants.dart';

/// author: @sanchitmonga22

//TODO: Send contacts to the server and sync them all
class ContactsDialogView extends StatefulWidget {
  const ContactsDialogView({Key key}) : super(key: key);

  @override
  _ContactsDialogViewState createState() => _ContactsDialogViewState();
}

class _ContactsDialogViewState extends State<ContactsDialogView>
    with AutomaticKeepAliveClientMixin<ContactsDialogView> {
  List<Contact> _contacts = [];
  List<PublicUserData> users = [];
  int activeIndex;

  Future<void> refreshContacts() async {
    // Load without thumbnails initially.
    var contacts =
        (await ContactsService.getContacts(withThumbnails: false)).toList();
    setState(() {
      _contacts = contacts;
    });
  }

  @override
  void initState() {
    super.initState();
    _askPermissions();
    refreshContacts();
  }

  Future<void> _askPermissions() async {
    PermissionStatus permissionStatus = await _getContactPermission();
    if (permissionStatus != PermissionStatus.granted) {
      _handleInvalidPermissions(permissionStatus);
    }
  }

  Future<PermissionStatus> _getContactPermission() async {
    PermissionStatus permission = await Permission.contacts.request();
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.denied) {
      Map<Permission, PermissionStatus> permissionStatus =
          await [Permission.contacts].request();
      return permissionStatus[Permission.contacts] ?? Permission.unknown;
    } else {
      return permission;
    }
  }

  void _handleInvalidPermissions(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      throw PlatformException(
          code: "PERMISSION_DENIED",
          message: "Access to location data denied",
          details: null);
    } else if (permissionStatus == PermissionStatus.denied) {
      throw PlatformException(
          code: "PERMISSION_DISABLED",
          message: "Location data is not available on device",
          details: null);
    }
  }

  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    // both will be asynchronous calls
    // Provider.of<UserDataProvider>(context, listen:false).syncContacts(_contacts);
    // users = Provider.of<UserDataProvider>(context).userContacts;
    super.build(context);
    return users != null && users.length != 0
        ? ListView.builder(
            itemBuilder: (context, index) {
              return ContactWidget(
                c: users?.elementAt(index),
                key: ValueKey(index),
                isLoading: activeIndex == index,
                onPressed: () {
                  setState(() {
                    activeIndex = index;
                  });
                },
              );
            },
            itemCount: users?.length ?? 0,
          )
        : Center(
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.circular(5)),
              padding: EdgeInsets.all(10),
              child: AutoSizeText(
                "There are currently no users available to add from the contacts, Hit the refresh button or try back again later",
                style: kTextFormFieldStyle.copyWith(color: kSystemPrimaryColor),
              ),
            ),
          );
  }

  // TODO: Add a refresh button here!!
  void contactOnDeviceHasBeenUpdated(Contact contact) {
    this.setState(() {
      var id = _contacts.indexWhere((c) => c.identifier == contact.identifier);
      _contacts[id] = contact;
    });
  }
}

class ContactWidget extends StatelessWidget {
  const ContactWidget(
      {Key key,
      this.onPressed,
      this.c,
      this.isLoading = false,
      this.requestSent = false})
      : super(key: key);

  final onPressed;
  final PublicUserData c;
  final isLoading;
  final requestSent;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 20,
        child: Icon(
          Icons.person,
          color: Colors.white,
          size: 20,
        ),
      ),
      title: Text(
        c.username ?? "",
        style: kTextFormFieldStyle,
      ),
      trailing: RaisedButton(
        padding: EdgeInsets.all(8),
        color: kSystemPrimaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        onPressed: onPressed,
        child: isLoading
            ? CircularProgressIndicator()
            : requestSent
                ? Container(
                    child: Text(
                      "Sent",
                      style: kTextFormFieldStyle.copyWith(fontSize: 14),
                    ),
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 15,
                      ),
                      Text(
                        "Add",
                        style: kTextFormFieldStyle.copyWith(fontSize: 14),
                      )
                    ],
                  ),
      ),
    );
  }
}
