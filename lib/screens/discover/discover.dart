import 'package:flutter/cupertino.dart';

class ExplorePage extends StatefulWidget {
  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: CupertinoButton(
      child: Text("Discover stuff"),
      onPressed: () {
        print("Stuff");
      },
    ));
  }
}
