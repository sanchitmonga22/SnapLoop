import 'dart:ui';

import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../constants.dart';

/// author: @sanchitmonga22

//TODO: Send contacts to the server and sync them all
class ContactsDialog extends StatefulWidget {
  const ContactsDialog({Key key}) : super(key: key);

  @override
  _ContactsDialogState createState() => _ContactsDialogState();
}

class _ContactsDialogState extends State<ContactsDialog>
    with AutomaticKeepAliveClientMixin<ContactsDialog> {
  List<Contact> _contacts;
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
    super.build(context);
    return _contacts != null
        ? ListView.builder(
            itemBuilder: (context, index) {
              return ContactWidget(
                c: _contacts?.elementAt(index),
                key: ValueKey(index),
                isLoading: activeIndex == index,
                onPressed: () {
                  setState(() {
                    activeIndex = index;
                  });
                },
              );
            },
            itemCount: _contacts?.length ?? 0,
          )
        : Center(
            child: CircularProgressIndicator(),
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
  const ContactWidget({Key key, this.onPressed, this.c, this.isLoading = false})
      : super(key: key);

  final onPressed;
  final Contact c;
  final isLoading;

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
        c.displayName ?? "",
        style: kTextFormFieldStyle,
      ),
      trailing: RaisedButton(
        padding: EdgeInsets.all(8),
        color: kSystemPrimaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        onPressed: onPressed,
        child: isLoading
            ? CircularProgressIndicator()
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
      //subtitle: Text(contacts[index].familyName)
    );
  }
}
