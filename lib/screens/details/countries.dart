import 'dart:async';
import 'dart:convert';

import 'package:discoucher/models/country.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CountriesPage extends StatefulWidget {
  @override
  _CountriesPageState createState() => _CountriesPageState();
}

class _CountriesPageState extends State<CountriesPage> {
  final String countriesApi = "https://restcountries.eu/rest/v2/all";
  List countries;
  StreamController<Country> countriesStreamController;
  List<Country> countryList = [];

  @override
  void initState() {
    super.initState();

    countriesStreamController = StreamController.broadcast();
    countriesStreamController.stream
        .listen((country) => setState(() => countryList.add(country)));

    loadCountriesUsingStream(countriesStreamController);
  }

  buildCountriesStream(int index) {
    if (index >= countryList.length) {
      return null;
    }

    return Card(
      child: Stack(
        alignment: Alignment(-1.0, 1.0),
        children: <Widget>[
          // Container(
          //   color: Colors.amber[300],
          //   //child: buildSvgImage(countryList[index].flag),
          // ),
          Container(
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                countryList[index].name,
                style: Theme.of(context).textTheme.body2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  loadCountriesUsingStream(StreamController sc) async {
    var client = http.Client();
    var req = http.Request('get', Uri.parse(countriesApi));
    var streamedResponse = await client.send(req);

    streamedResponse.stream
        .transform(UTF8.decoder)
        .transform(json.decoder)
        .expand((e) => e)
        .map((map) => Country.fromJsonMap(map))
        .pipe(countriesStreamController);
  }

  buildCountriesList() {
    this.getCountries();

    return ListView.builder(
      itemCount: countries == null ? 0 : countries.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          child: Text(countries[index]["name"]),
        );
      },
    );
  }

  Future<bool> getCountries() async {
    var response = await http.get(Uri.encodeFull(countriesApi),
        headers: {'Accept': 'application/json'});

    setState(() {
      countries = json.decode(response.body);
    });
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text("All Countries"),
      ),
      body: Center(
        child: ListView.builder(
            itemBuilder: (BuildContext context, int index) =>
                buildCountriesStream(index)),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    countriesStreamController?.close();
  }
}
