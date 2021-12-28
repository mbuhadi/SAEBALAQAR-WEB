import 'package:flutter/material.dart';

class OnHoverButton extends StatefulWidget {
  final Widget Function(bool isHovered) builder;

  const OnHoverButton({
    Key? key,
    required this.builder,
  }) : super(key: key);

  @override
  _OnHoverButtonState createState() => _OnHoverButtonState();
}

class _OnHoverButtonState extends State<OnHoverButton> {
  @override
  bool isHovered = false;
  Widget build(BuildContext context) {
    final hoveredTransform = Matrix4.identity()..scale(1.01);
    final transform = isHovered ? hoveredTransform : Matrix4.identity();
    return MouseRegion(
        onEnter: (event) => onEntered(true),
        onExit: (event) => onEntered(false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: transform,
          child: widget.builder(isHovered),
        ));
  }

  void onEntered(bool isHovered) => setState(() {
        this.isHovered = isHovered;
      });
}

class OnHoverButtonTwo extends StatefulWidget {
  final Widget Function(bool isHovered) builder;

  const OnHoverButtonTwo({
    Key? key,
    required this.builder,
  }) : super(key: key);

  @override
  _OnHoverButtonTwoState createState() => _OnHoverButtonTwoState();
}

class _OnHoverButtonTwoState extends State<OnHoverButtonTwo> {
  @override
  bool isHovered = false;
  Widget build(BuildContext context) {
    final hoveredTransform = Matrix4.identity()..scale(1);
    final transform = isHovered ? hoveredTransform : Matrix4.identity();
    return MouseRegion(
        onEnter: (event) => onEntered(true),
        onExit: (event) => onEntered(false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: transform,
          child: widget.builder(isHovered),
        ));
  }

  void onEntered(bool isHovered) => setState(() {
        this.isHovered = isHovered;
      });
}
