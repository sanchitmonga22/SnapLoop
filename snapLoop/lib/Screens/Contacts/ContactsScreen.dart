import 'package:contacts_service/contacts_service.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

/// author: @sanchitmonga22

//TODO: Send contacts to the server and sync them all
class ContactScreen extends StatefulWidget {
  static const routeName = "/ContactScreen";

  const ContactScreen({Key key}) : super(key: key);

  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen>
    with AutomaticKeepAliveClientMixin<ContactScreen> {
  List<Contact> _contacts;

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
    // String loopName = ModalRoute.of(context).settings.arguments as String;
    // final contacts = Provider.of<UserDataProvider>(context).contacts;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SearchBar(
        onItemFound: (item, index) {},
        onSearch: (text) {},
        //minimumChars: 5,
        loader: Center(
          child: Text("loading..."),
        ),
        //debounceDuration: Duration(milliseconds: 800),
        icon: Icon(Icons.contacts),
        searchBarStyle: SearchBarStyle(
          backgroundColor: Theme.of(context).primaryColor,
          padding: EdgeInsets.all(10),
          borderRadius: BorderRadius.circular(10),
        ),
        placeHolder: _contacts != null
            ? ListView.builder(
                itemBuilder: (context, index) {
                  Contact c = _contacts?.elementAt(index);
                  return ListTile(
                    leading: Text(c.displayName ?? ""),
                    title: Row(children: [
                      ...c.emails
                          .map((e) => Text("${e.value.toString()} "))
                          .toList()
                    ]),
                    subtitle: Row(children: [
                      ...c.phones
                          .map((e) => Text("${e.value.toString()} "))
                          .toList()
                    ]),
                    // title: Text(contacts[index].displayName),
                    // subtitle: Text(contacts[index].familyName),
                    onTap: () {
                      // Navigator.of(context).pushNamed(
                      //     NewLoopChatScreen.routeName,
                      //     arguments: [contacts[index], ]);
                    },
                  );
                },
                itemCount: _contacts?.length ?? 0,
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }

// if the user presses this to update its contacts list
  void contactOnDeviceHasBeenUpdated(Contact contact) {
    this.setState(() {
      var id = _contacts.indexWhere((c) => c.identifier == contact.identifier);
      _contacts[id] = contact;
    });
  }
}
