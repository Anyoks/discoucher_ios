import 'package:flutter/material.dart';

class SearchResultsView extends StatelessWidget {
  final data;
  SearchResultsView(this.data);

  @override
  Widget build(BuildContext context) {
    return Container(child: this.data);
  }}