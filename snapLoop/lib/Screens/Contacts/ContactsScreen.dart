import 'package:SnapLoop/Provider/UserDataProvider.dart';
import 'package:SnapLoop/Screens/Chat/loopChatScreen.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContactScreen extends StatefulWidget {
  ContactScreen({Key key}) : super(key: key);
  static const routeName = "/ContactScreen";
  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  @override
  Widget build(BuildContext context) {
    String loopName = ModalRoute.of(context).settings.arguments as String;
    final contacts = Provider.of<UserDataProvider>(context).contacts;
    return Container(
        child: Scaffold(
      body: SafeArea(
        child: Padding(
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
            placeHolder: Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(contacts[index].displayName),
                    subtitle: Text(contacts[index].email),
                    onTap: () {
                      Navigator.of(context).pushNamed(LoopChatScreen.routeName,
                          arguments: [contacts[index], loopName]);
                    },
                  );
                },
                itemCount: contacts.length,
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
