import 'dart:math';

import 'package:flutter/material.dart';

// Loader based on https://www.youtube.com/watch?v=KdQhPoquekc
class Loader extends StatefulWidget {
  @override
  _LoaderState createState() => _LoaderState();
}

class _LoaderState extends State<Loader> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation_rotation;
  Animation<double> animation_radius_in;
  Animation<double> animation_radius_out;

  final double initialRadius = 15;

  double radius = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 5));

    animation_rotation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
        parent: controller, curve: Interval(0.0, 1.0, curve: Curves.linear)));

    animation_radius_in = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
        parent: controller,
        curve: Interval(0.75, 1.0, curve: Curves.elasticIn)));

    animation_radius_out = Tween(begin: 0.0, end: 0.1).animate(CurvedAnimation(
        parent: controller,
        curve: Interval(0.0, 0.25, curve: Curves.elasticOut)));

    controller.addListener(() {
      setState(() {
        if (controller.value >= 0.75 && controller.value <= 1.0) {
          // print(" RADIUS IN ${controller.value}");
          radius = animation_radius_out.value * initialRadius;
          // radius = animation_radius_in.value * initialRadius;
        } else if (controller.value >= 0.0 && controller.value <= 0.25) {
          // print(" RADIUS OUT ${controller.value}");
          // radius = animation_radius_out.value * initialRadius;
          radius = animation_radius_in.value * initialRadius;
        }
      });
    });
    controller.repeat();

    
  }

  @override
    dispose() {
      controller.dispose();
      super.dispose();
    }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.0,
      height: 100.0,
      child: Center(
        child: RotationTransition(
          turns: animation_rotation,
          child: Stack(
            children: <Widget>[
              Dot(
                radius: 15.0,
                colour: Theme.of(context).primaryColor, // shade of grey
              ),
              Transform.translate(
                offset: Offset(radius * cos(pi / 4), radius * sin(pi / 4)),
                child: Dot(
                  radius: 5.0,
                  colour: Colors.brown,
                ),
              ),
              Transform.translate(
                offset:
                    Offset(radius * cos(2 * pi / 4), radius * sin(2 * pi / 4)),
                child: Dot(
                  radius: 5.0,
                  colour: Colors.black,
                ),
              ),
              Transform.translate(
                offset:
                    Offset(radius * cos(3 * pi / 4), radius * sin(3 * pi / 4)),
                child: Dot(
                  radius: 5.0,
                  colour: Colors.orange,
                ),
              ),
              Transform.translate(
                offset:
                    Offset(radius * cos(4 * pi / 4), radius * sin(4 * pi / 4)),
                child: Dot(
                  radius: 5.0,
                  colour: Colors.pink,
                ),
              ),
              Transform.translate(
                offset:
                    Offset(radius * cos(5 * pi / 4), radius * sin(5 * pi / 4)),
                child: Dot(
                  radius: 5.0,
                  colour: Colors.purple,
                ),
              ),
              Transform.translate(
                offset:
                    Offset(radius * cos(6 * pi / 4), radius * sin(6 * pi / 4)),
                child: Dot(
                  radius: 5.0,
                  colour: Colors.green,
                ),
              ),
              Transform.translate(
                offset:
                    Offset(radius * cos(7 * pi / 4), radius * sin(7 * pi / 4)),
                child: Dot(
                  radius: 5.0,
                  colour: Colors.blue,
                ),
              ),
              Transform.translate(
                offset:
                    Offset(radius * cos(8 * pi / 4), radius * sin(8 * pi / 4)),
                child: Dot(
                  radius: 5.0,
                  colour: Colors.yellow,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Dot extends StatelessWidget {
  final double radius;
  final Color colour;

  Dot({this.radius, this.colour});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: this.radius,
        height: this.radius,
        decoration: BoxDecoration(
          color: this.colour,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
