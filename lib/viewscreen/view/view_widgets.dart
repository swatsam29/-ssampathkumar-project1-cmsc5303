import 'package:flutter/material.dart';

class CircleContainer extends StatefulWidget {
  const CircleContainer({Key? key, required this.color, required this.isFilled})
      : super(key: key);
  final bool isFilled;
  final Color color;

  @override
  State<CircleContainer> createState() => _CircleContainerState();
}

class _CircleContainerState extends State<CircleContainer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 4.0),
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: widget.isFilled == true ? widget.color : Colors.white,
          shape: BoxShape.circle,
          border: Border.all(width: 4, color: widget.color),
        ),
      ),
    );
  }
}