import 'package:flutter/material.dart';
import 'dart:math';

class AnimatedBackground extends StatefulWidget {
  const AnimatedBackground({Key? key}) : super(key: key);

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 60))
          ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: BlobsPainter(_controller.value),
          child: Container(),
        );
      },
    );
  }
}

class BlobsPainter extends CustomPainter {
  final double animationValue;

  BlobsPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    List<Blob> blobs = [
      Blob(
        color: Colors.blue.withOpacity(0.5),
        radius: 100,
        speed: 10,
        path: PathType.circle,
      ),
      Blob(
        color: Colors.lightBlueAccent.withOpacity(0.4),
        radius: 80,
        speed: 8,
        path: PathType.ellipse,
      ),
      Blob(
        color: Colors.cyan.withOpacity(0.3),
        radius: 60,
        speed: 12,
        path: PathType.sin,
      ),
    ];

    for (var blob in blobs) {
      Offset position = getBlobPosition(blob, size);
      Paint paint = Paint()..color = blob.color;
      canvas.drawCircle(position, blob.radius, paint);
    }
  }

  Offset getBlobPosition(Blob blob, Size size) {
    double t = animationValue * 2 * pi * blob.speed;

    switch (blob.path) {
      case PathType.circle:
        double x = size.width / 2 + 100 * cos(t);
        double y = size.height / 2 + 100 * sin(t);
        return Offset(x, y);
      case PathType.ellipse:
        double x = size.width / 2 + 150 * cos(t);
        double y = size.height / 2 + 80 * sin(t);
        return Offset(x, y);
      case PathType.sin:
        double x = size.width / 2 + 120 * cos(t);
        double y = size.height / 2 + 60 * sin(2 * t);
        return Offset(x, y);
      default:
        return Offset(size.width / 2, size.height / 2);
    }
  }

  @override
  bool shouldRepaint(covariant BlobsPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}

class Blob {
  final Color color;
  final double radius;
  final double speed;
  final PathType path;

  Blob({
    required this.color,
    required this.radius,
    required this.speed,
    required this.path,
  });
}

enum PathType { circle, ellipse, sin }
