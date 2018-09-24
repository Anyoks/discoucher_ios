import 'package:discoucher/models/tag-data.dart';
import 'package:discoucher/screens/search/search-results-page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class DiscoverGrid extends StatelessWidget {
  final List<TagData> tags;

  DiscoverGrid({this.tags});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: StaggeredGridView.countBuilder(
        crossAxisCount: 4,
        itemCount: tags.length,
        itemBuilder: (BuildContext context, int index) => GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  SearchResultsPageRoute(tags[index].attributes.name),
                );
              },
              child: Container(
                alignment: Alignment(0.0, 1.0),
                decoration: new BoxDecoration(
                  borderRadius: new BorderRadius.all(new Radius.circular(5.0)),
                  shape: BoxShape.rectangle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(tags[index].attributes.image),
                    colorFilter: new ColorFilter.mode(
                      Colors.black.withOpacity(0.2),
                      BlendMode.darken,
                    ),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(3.0),
                  child: Text(
                    tags[index].attributes.name,
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
