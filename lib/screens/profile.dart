import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final person;
  ProfilePage(this.person);

  @override
  Widget build(BuildContext context) {
    PopupMenuItem<String> _buildMenuItem(IconData icon, String label) {
      return new PopupMenuItem<String>(
        child: new Row(
          children: <Widget>[
            new Padding(
                padding: const EdgeInsets.only(right: 24.0),
                child: new Icon(icon, color: Colors.black54)),
            new Text(label,
                style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black54,
                    height: 24.0 / 15.0)),
          ],
        ),
      );
    }

    return new Scaffold(
      // appBar: new AppBar(
      //   title: new Text("Profile"),
      //   backgroundColor: Colors.green[900],
      // ),
      body: new CustomScrollView(
        slivers: <Widget>[
          const SliverAppBar(
            // backgroundColor: Colors.transparent,
            pinned: true,
            expandedHeight: 200.0,
            actions: <Widget>[
              const IconButton(
                // onPressed: () {
                //   print("pressed");
                // },
                icon: const Icon(Icons.filter_list),
              )
            ],
            flexibleSpace: const FlexibleSpaceBar(
              background: const DecoratedBox(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("images/establishments/platter.png"),
                      fit: BoxFit.cover),
                  gradient: const LinearGradient(
                    begin: const Alignment(0.0, -1.0),
                    end: const Alignment(0.0, -0.2),
                    colors: const <Color>[
                      const Color(0x60000000),
                      const Color(0x00000000)
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
