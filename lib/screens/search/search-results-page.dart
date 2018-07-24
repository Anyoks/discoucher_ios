import 'package:flutter/cupertino.dart';

class SearchResultsView extends StatelessWidget {
  final data;
  SearchResultsView(this.data);

  @override
  Widget build(BuildContext context) {
    return Container(child: this.data);
  }}