import 'package:flutter/material.dart';

class GreyContainer extends StatelessWidget {
  final double width;
  final double height;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final Widget child;

  GreyContainer({
    this.width = double.infinity,
    this.height,
    this.margin,
    this.padding,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.width,
      height: this.height,
      margin: this.margin,
      padding: this.padding,
      child: this.child,
      decoration: BoxDecoration(
        color: Color(0xE5E5E5E5),
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
    );
  }
}
