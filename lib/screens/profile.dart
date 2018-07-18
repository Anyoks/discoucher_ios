import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final person;
  ProfilePage(this.person);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      // appBar: new AppBar(
      //   title: new Text("Profile"),
      //   backgroundColor: Colors.green[900],
      // ),
      body: new CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            // backgroundColor: Colors.transparent,
            pinned: true,
            expandedHeight: 200.0,
            actions: <Widget>[
              IconButton(
                onPressed: () {
                  print("pressed");
                },
                icon: Icon(Icons.filter_list),
              )
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: DecoratedBox(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("images/establishments/platter.png"),
                      fit: BoxFit.cover),
                  gradient: LinearGradient(
                    begin: Alignment(0.0, -1.0),
                    end: Alignment(0.0, -0.2),
                    colors: <Color>[
                      Color(0x60000000),
                      Color(0x00000000)
                    ],
                  ),
                ),
              ),
            ),
          ),
          new SliverGrid(
            gridDelegate: new SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200.0,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: 4.0,
            ),
            delegate: new SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return new Container(
                  alignment: Alignment.center,
                  color: Colors.teal[100 * (index % 9)],
                  child: new Text('grid item $index'),
                );
              },
              childCount: 20,
            ),
          ),
          new SliverFixedExtentList(
            itemExtent: 50.0,
            delegate: new SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return new Container(
                  alignment: Alignment.center,
                  color: Colors.lightBlue[100 * (index % 9)],
                  child: new Text('list item $index'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
