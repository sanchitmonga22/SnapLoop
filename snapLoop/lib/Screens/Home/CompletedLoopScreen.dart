import 'package:SnapLoop/Provider/LoopsProvider.dart';
import 'package:SnapLoop/Screens/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CompletedLoopsScreen extends StatefulWidget {
  const CompletedLoopsScreen({Key key}) : super(key: key);

  @override
  _CompletedLoopsScreenState createState() => _CompletedLoopsScreenState();
}

class _CompletedLoopsScreenState extends State<CompletedLoopsScreen>
    with AutomaticKeepAliveClientMixin<CompletedLoopsScreen> {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    MediaQueryData size = MediaQuery.of(context);
    final List<Widget> inactiveLoops = Provider.of<LoopsProvider>(context)
        .completedLoopBuilder((size.size.width) / 4);
    return Container(
        decoration: kHomeScreenBoxDecoration,
        child: Column(children: <Widget>[
          Expanded(
              child: Stack(children: [
            inactiveLoops == null || inactiveLoops.length == 0
                ? Center(
                    child: Text(
                    "There are no inactive loops available yet, \n once you are part of a successfully completed loop it will show up here!",
                    style: kTextStyleHomeScreen,
                  ))
                : ListView.builder(
                    itemBuilder: (_, index) {
                      return inactiveLoops[index];
                    },
                    itemCount: inactiveLoops.length)
          ]))
        ]));
  }
}
