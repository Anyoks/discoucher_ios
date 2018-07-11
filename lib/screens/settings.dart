import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  final String imageUrl;
  final String heroTag;
  SettingsPage(this.imageUrl, this.heroTag);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("Settings")),
      body: Center(
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute<Null>(builder: (BuildContext context) {
                return Scaffold(
                  appBar: AppBar(
                    title: const Text('Flippers Page'),
                  ),
                  body: Hero(
                    tag: heroTag,
                    child: SizedBox(
                      width: 300.0,
                      child: Image.asset(imageUrl),
                    ),
                  ),
                );
              }),
            );
          },
          // Main route
          child: Hero(
            tag: heroTag,
            child: SizedBox(
              width: 300.0,
              child: Image.asset(imageUrl),
            ),
          ),
        ),
      ),
    );
  }
}
