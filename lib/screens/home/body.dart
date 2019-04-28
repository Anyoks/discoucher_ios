import 'dart:async';
import 'dart:io';

import 'package:discoucher/contollers/home-controller.dart';
import 'package:discoucher/loader/loader.dart';
import 'package:discoucher/models/voucher-data.dart';
import 'package:discoucher/screens/home/home-list-error.dart';
import 'package:discoucher/screens/home/horizontal-list.dart';
import 'package:discoucher/screens/home/top-banner.dart';
import 'package:discoucher/screens/shared/search-app-bar.dart';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:uuid/uuid.dart';

class HomeBody extends StatefulWidget {
  @override
  _HomeBodyState createState() => new _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  final _homeController = new HomeController();

  Future<List<List<VoucherData>>> _homeFuture;
  dynamic list;
  List<String> categories;
  bool connected = false;
  var counter = 0;

  @override
  void initState() {
    super.initState();
    
    _getCategories();
    checkInternet();
  }

  _getCategories() async {
    // List<String> list;
    await _homeController.fetchListOfCartegoryNames().then((data) {
      if (data != null) {
        setState(() {
          categories = data;
          _homeFuture = _homeController.fetchHomeDataV2(categories);
        });
      } else {
        if (counter < 2) {
          counter++;
          _getCategories();
        } else {
          counter = 0;
        }
      }
    });
  }

  checkInternet() async {
    try {
      final result = await InternetAddress.lookup('http://159.89.103.53');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        print(result);
        setState(() {
          connected = true;
        });
      }
    } on SocketException catch (_) {
      print('not connected');
      setState(() {
        connected = false;
      });
    }

    // try {
    //   var connectivityResult = await (Connectivity().checkConnectivity());
    //   if (connectivityResult == ConnectivityResult.mobile) {
    //     // I am connected to a mobile network.
    //     setState(() {
    //       connected = true;
    //     });
    //   } else if (connectivityResult == ConnectivityResult.wifi) {
    //     // I am connected to a wifi network.
    //     setState(() {
    //       connected = true;
    //     });
    //   } else if (connectivityResult == ConnectivityResult.none) {
    //     setState(() {
    //       connected = false;
    //     });
    //   }
    // } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Handle loading screens

    return Scaffold(
      appBar: SearchAppBar(),
      body: FutureBuilder(
        future: _homeFuture,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            // case ConnectionState.done:
            //   return snapshot.data.length > 0
            //         ? sectionBuilder(context, snapshot.data)
            //         : HomeError(
            //             onPressed: () async {
            //               return await handleRefresh();
            //             },
            //             message: "There are no vouchers to load at the moment");
            case ConnectionState.waiting:
              return Container(
                child: Center(
                    child:
                        Loader()), //Center(child: CircularProgressIndicator()), //
              );
            case ConnectionState.none:
              return connected
                  ? Center(child: Loader())
                  : HomeError(
                      onPressed: () async {
                        return await handleRefresh();
                      },
                      message: "You are offline");

            default:
              if (snapshot.hasError)
                return HomeError(
                  onPressed: () async {
                    return await handleRefresh();
                  },
                  message: "Nothing to see",
                );
              else
                return snapshot.data.length > 0
                    ? sectionBuilder(context, snapshot.data)
                    : HomeError(
                        onPressed: () async {
                          return await handleRefresh();
                        },
                        message: "There are no vouchers to load at the moment");
          }
        },
      ),
    );
  }

  Future<List<List<VoucherData>>> handleRefresh() async {
    setState(() {
      // _homeFuture = _homeController.fetchHomeData();
      // _homeFuture = _homeController.fetchHomeDataV2(categories);
      _getCategories();
    });

    return _homeFuture;
  }

  sectionBuilder(BuildContext context, List<List<VoucherData>> sections) {
    // print('SSSSSSSSSSSSSSSSSSSSSNAPTIOT'+ ' ${sections.length}');
    return RefreshIndicator(
      onRefresh: handleRefresh,
      child: ListView(
        children: <Widget>[
          SizedBox(height: 5.0),
          topBannerSection,
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            key: new Key(new Uuid().v1()),
            scrollDirection: Axis.vertical,
            itemCount: sections.length,
            itemBuilder: (BuildContext context, int index) {
              // print('XXXXXXXXXXXXXXXXXX' + '$index' +' ' + '${sections.length}');
              return buildHomeList(context, sections[index], index, categories);
            },
          )
        ],
      ),
    );
  }
}
