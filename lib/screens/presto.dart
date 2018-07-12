import 'dart:typed_data';

import 'package:flutter/material.dart';

class PrestoPage extends StatefulWidget {
  PrestoPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _PrestoPageState createState() => new _PrestoPageState();
}

const kExpandedHeight = 300.0;

class _PrestoPageState extends State<PrestoPage> {
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController()..addListener(() => setState(() {}));
  }

  bool get _showTitle {
    print(kToolbarHeight * 2);

    return _scrollController.hasClients &&
        _scrollController.offset > kExpandedHeight - (kToolbarHeight * 2);
  }

  @override
  Widget build(BuildContext context) {
    final Uint8List kTransparentImage = new Uint8List.fromList(<int>[
      0x89,
      0x50,
      0x4E,
      0x47,
      0x0D,
      0x0A,
      0x1A,
      0x0A,
      0x00,
      0x00,
      0x00,
      0x0D,
      0x49,
      0x48,
      0x44,
      0x52,
      0x00,
      0x00,
      0x00,
      0x01,
      0x00,
      0x00,
      0x00,
      0x01,
      0x08,
      0x06,
      0x00,
      0x00,
      0x00,
      0x1F,
      0x15,
      0xC4,
      0x89,
      0x00,
      0x00,
      0x00,
      0x0A,
      0x49,
      0x44,
      0x41,
      0x54,
      0x78,
      0x9C,
      0x63,
      0x00,
      0x01,
      0x00,
      0x00,
      0x05,
      0x00,
      0x01,
      0x0D,
      0x0A,
      0x2D,
      0xB4,
      0x00,
      0x00,
      0x00,
      0x00,
      0x49,
      0x45,
      0x4E,
      0x44,
      0xAE,
    ]);
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {},
            ),
            expandedHeight: kExpandedHeight,
            title: Column(
              children: <Widget>[
                Text("Search in restaurants"),
              ],
            ),
            // title: TextField(
            //   style: TextStyle(color: Colors.white),
            //   decoration: InputDecoration(
            //       fillColor: Colors.white,
            //       prefixIcon: Icon(Icons.search),
            //       hintText: 'Please enter a search term'),
            // ),
            flexibleSpace: FlexibleSpaceBar(
              title: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: AnimatedOpacity(
                        opacity: _showTitle ? 0.0 : 1.0,
                        duration: Duration(milliseconds: 900),
                        child: Text("Restaurants"),
                      ),
                    ),
                  ),
                ],
              ),
              background: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                fit: BoxFit.cover,
                image:
                    'https://static1.squarespace.com/static/5527c8e2e4b09173e4adc370/t/5a61b50c24a694dddab8c2b9/1516352792003/Amandina.jpg?format=500w',
              ),
              //

              //  Image.asset("images/establishments/mister.jpg",
              //     fit: BoxFit.cover,
              //     colorBlendMode: BlendMode.softLight,
              //     color: Colors.black),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              List<Text>.generate(100, (int i) {
                return Text("List item $i");
              }),
            ),
          ),
        ],
      ),
    );
  }
}
