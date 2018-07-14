import 'package:flutter/material.dart';
import 'package:discoucher/screens/shared/generic-list.dart';

class CategoryListPage extends StatelessWidget {
  final String title;
  final String imageUrl = "images/establishments/ob.jpg";
  CategoryListPage(this.title);

  buildSliberAppBar(BuildContext context) {
    return SliverAppBar(
      centerTitle: true,
      pinned: true,
      expandedHeight: 200.0,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back_ios),
      ),
      actions: <Widget>[
        IconButton(
          onPressed: () {
            print("pressed");
          },
          icon: Icon(Icons.share),
        ),
        IconButton(
          onPressed: () {
            print("pressed");
          },
          icon: Icon(Icons.favorite_border),
        )
      ],
      flexibleSpace: FlexibleSpaceBar(
        title: Text(this.title),
        background: DecoratedBox(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(this.imageUrl), fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }

  buildSliverGrid() {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200.0,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
        childAspectRatio: 4.0,
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Container(
            height: 154.0,
            child: Text("data")
          );
        },
      ),
    );
  }

  buildFixedList() {
    return SliverFixedExtentList(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new CustomScrollView(
        slivers: <Widget>[
          buildSliberAppBar(context),
          buildSliverGrid(),
          buildFixedList()
        ],
      ),
    );
  }
}
