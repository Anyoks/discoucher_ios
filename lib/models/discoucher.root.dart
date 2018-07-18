import 'package:discoucher/models/datum.dart';
import 'package:discoucher/models/jsonapi.dart';
// import 'package:discoucher/models/jsonapi.version.dart';

// class DiscoucherRoot {
//   final List<Datum> data;
//   final Jsonapi jsonapi;

//   DiscoucherRoot.fromJsonMap(Map map)
//       : data = map['data'],
//         jsonapi = map['jsonapi'];
// }


class DiscoucherRoot {
  final List<Datum> data;
  final Jsonapi jsonapi;

  DiscoucherRoot.fromJsonMap(Map map)
      : data = map['data'],
        jsonapi = map['jsonapi'];
}
