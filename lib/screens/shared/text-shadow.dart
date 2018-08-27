import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class ShadowText extends StatelessWidget {
  ShadowText(this.data, {this.style}) : assert(data != null);

  final String data;
  final TextStyle style;

  Widget build(BuildContext context) {
    return new ClipRect(
      child: new Stack(
        children: [
          new Positioned(
            top: 2.0,
            left: 2.0,
            child: new Text(
              data,
              style: style.copyWith(color: Colors.black.withOpacity(0.5)),
            ),
          ),
          new BackdropFilter(
            filter: new ui.ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
            child: new Text(data, style: style),
          ),
        ],
      ),
    );
  }

// Usage
//  child: new ShadowText(
//             'Hello world!',
//             style: Theme.of(context).textTheme.display3,
//           ),
}


// Or

// import 'package:flutter/material.dart';

// class ShadowText extends StatelessWidget {

//   final String data;
//   final TextStyle style;
//   final TextAlign textAlign;
//   final TextDirection textDirection;
//   final bool softWrap;
//   final TextOverflow overflow;
//   final double textScaleFactor;
//   final int maxLines;

//   const ShadowText(this.data, {
//     Key key,
//     this.style,
//     this.textAlign,
//     this.textDirection,
//     this.softWrap,
//     this.overflow,
//     this.textScaleFactor,
//     this.maxLines,
//   }) : assert(data != null);

//   Widget build(BuildContext context) {
//     return new ClipRect(
//       child: new Stack(
//         children: [
//           new Positioned(
//             top: 2.0,
//             left: 2.0,
//             child: new Text(
//               data,
//               style: style.copyWith(color: Colors.black.withOpacity(0.5)),
//               textAlign: textAlign,
//               textDirection: textDirection,
//               softWrap: softWrap,
//               overflow: overflow,
//               textScaleFactor: textScaleFactor,
//               maxLines: maxLines,
//             ),
//           ),
//           new Text(
//             data,
//             style: style,
//             textAlign: textAlign,
//             textDirection: textDirection,
//             softWrap: softWrap,
//             overflow: overflow,
//             textScaleFactor: textScaleFactor,
//             maxLines: maxLines,
//           ),
//         ],
//       ),
//     );
//   }
// }

