import 'package:flutter/material.dart';

class SkeletonWidget extends StatefulWidget {
  final double height;
  final double width;
  final double cornerRadius;
  final Widget? child;
  final Clip clipBehavior;

  const SkeletonWidget({
    super.key,
    this.height = 20,
    this.width = 200,
    this.cornerRadius = 4,
    this.clipBehavior = Clip.none,
    this.child,
  });

  @override
  SkeletonWidgetState createState() => SkeletonWidgetState();
}

class SkeletonWidgetState extends State<SkeletonWidget>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;

  late Animation gradientPosition;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 1500), vsync: this);

    gradientPosition = Tween<double>(
      begin: -3,
      end: 10,
    ).animate(
      CurvedAnimation(parent: _controller!, curve: Curves.linear),
    )..addListener(() {
        setState(() {});
      });

    _controller!.repeat();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: widget.width,
      height: widget.height,
      clipBehavior: widget.clipBehavior,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.cornerRadius),
          gradient: LinearGradient(
              begin: Alignment(gradientPosition.value, 0),
              end: const Alignment(-1, 0),
              colors: isDarkTheme
                  ? [
                      const Color(0x66000000),
                      const Color(0x99000000),
                      const Color(0x66000000)
                    ]
                  : [
                      const Color(0x0D000000),
                      const Color(0x1A000000),
                      const Color(0x0D000000)
                    ])),
      child: widget.child,
    );
  }
}
