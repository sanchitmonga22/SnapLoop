import 'package:SnapLoop/Provider/UserDataProvider.dart';
import 'package:SnapLoop/Screens/Chat/newLoopChatScreen.dart';
import 'package:SnapLoop/Screens/constants.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/models/persistent-nav-bar-scaffold.widget.dart';
import 'package:provider/provider.dart';

/// author: @sanchitmonga22

class ContactScreen extends StatefulWidget {
  static const routeName = "/ContactScreen";

  const ContactScreen({Key key}) : super(key: key);

  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen>
    with AutomaticKeepAliveClientMixin<ContactScreen> {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    // String loopName = ModalRoute.of(context).settings.arguments as String;
    // final contacts = Provider.of<UserDataProvider>(context).contacts;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      //TODO: Add the search function using the future and connect it to the provider
      child: SearchBar(
        onItemFound: (item, index) {},
        onSearch: (text) {},
        //minimumChars: 5,
        loader: Center(
          child: Text("loading..."),
        ),
        //TODO: might need to add this depending on the API
        //debounceDuration: Duration(milliseconds: 800),
        icon: Icon(Icons.contacts),
        searchBarStyle: SearchBarStyle(
          backgroundColor: Theme.of(context).primaryColor,
          padding: EdgeInsets.all(10),
          borderRadius: BorderRadius.circular(10),
        ),
        placeHolder: Column(
          children: [
            Expanded(
                child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "Hello1",
                    style: TextStyle(fontSize: 50),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "Hello2",
                    style: TextStyle(fontSize: 50),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "Hello3",
                    style: TextStyle(fontSize: 50),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "Hello4",
                    style: TextStyle(fontSize: 50),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "Hello5",
                    style: TextStyle(fontSize: 50),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "Hello6",
                    style: TextStyle(fontSize: 50),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "Hello7",
                    style: TextStyle(fontSize: 50),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "Hello8",
                    style: TextStyle(fontSize: 50),
                  ),
                )
              ],
            )
                // ListView.builder(
                //   itemBuilder: (context, index) {
                //     return ListTile(
                //       title: Text(contacts[index].displayName),
                //       subtitle: Text(contacts[index].email),
                //       onTap: () {
                //         Navigator.of(context).pushNamed(
                //             NewLoopChatScreen.routeName,
                //             arguments: [contacts[index], loopName]);
                //       },
                //     );
                //   },
                //   itemCount: contacts.length,
                // ),
                ),
          ],
        ),
      ),
    );
  }
}
