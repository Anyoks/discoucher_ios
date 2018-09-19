import 'dart:math';

import 'package:discoucher/screens/shared/search-app-bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class DiscoverPage extends StatefulWidget {
  @override
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: SearchAppBar(), body: buildStaggeredGridView());
  }

  List<String> images = [
    'https://cdn.pixabay.com/photo/2016/01/22/16/42/eiffel-tower-1156146_960_720.jpg',
    'https://cdn.pixabay.com/photo/2016/10/21/14/50/plouzane-1758197_960_720.jpg',
    'https://cdn.pixabay.com/photo/2016/01/22/16/42/eiffel-tower-1156146_960_720.jpg',
    'https://cdn.pixabay.com/photo/2016/11/16/10/59/mountains-1828596_960_720.jpg',
    'https://cdn.pixabay.com/photo/2017/08/24/22/37/gyrfalcon-2678684_960_720.jpg',
    'https://cdn.pixabay.com/photo/2013/01/17/08/25/sunset-75159_960_720.jpg',
    'https://cdn.pixabay.com/photo/2013/04/07/21/30/croissant-101636_960_720.jpg'
  ];
  Random random = new Random();

  buildImage() {
    final int imagesNo = images.length;
    int randomPosition = 0;
    randomPosition = random.nextInt(imagesNo);
    String imageSrc = images[randomPosition];

    return Image.network(imageSrc, fit: BoxFit.cover);
  }

  fetchImage() {
    final int imagesNo = images.length;
    int randomPosition = 0;
    randomPosition = random.nextInt(imagesNo);
    String imageSrc = images[randomPosition];

    return NetworkImage(imageSrc);
  }

  buildStaggeredGridView() {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: StaggeredGridView.countBuilder(
        crossAxisCount: 4,
        itemCount: 18,
        itemBuilder: (BuildContext context, int index) => InkWell(
              onTap: () {
                print("Print");
              },
              child: Container(
                alignment: Alignment(0.0, 1.0),
                decoration: new BoxDecoration(
                  borderRadius: new BorderRadius.all(new Radius.circular(5.0)),
                  shape: BoxShape.rectangle,
                  color: Colors.black,
                  backgroundBlendMode: BlendMode.overlay,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: fetchImage(),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(3.0),
                  child: Text(
                    "Ibis Styles",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
        staggeredTileBuilder: (int index) =>
            StaggeredTile.count(2, index.isEven ? 2 : 1),
        mainAxisSpacing: 5.0,
        crossAxisSpacing: 5.0,
      ),
    );
  }
}
