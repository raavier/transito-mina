import 'dart:math';
import 'dart:ui';

import 'package:flutter/animation.dart';
import 'package:flutter/rendering.dart';
import 'package:transito_vale/config/palette.dart';

class BackgroundPainter extends CustomPainter {
  BackgroundPainter({Animation<double> animation})
      : darkGreenPaint = Paint()
          ..color = Palette.darkGreen
          ..style = PaintingStyle.fill,
        yellowPaint = Paint()
          ..color = Palette.yellow
          ..style = PaintingStyle.fill,
        greyPaint = Paint()
          ..color = Palette.grey
          ..style = PaintingStyle.fill,
        darkOrangePaint = Paint()
          ..color = Palette.darkOrange
          ..style = PaintingStyle.fill,
        darkRedPaint = Paint()
          ..color = Palette.darkRed
          ..style = PaintingStyle.fill,
        lightBluePaint = Paint()
          ..color = Palette.lightBlue
          ..style = PaintingStyle.fill,
        lightGreenPaint = Paint()
          ..color = Palette.lightGreen
          ..style = PaintingStyle.fill,
        greenPaint = Paint()
          ..color = Palette.green
          ..style = PaintingStyle.fill,
        lightYellowPaint = Paint()
          ..color = Palette.lightYellow
          ..style = PaintingStyle.fill,
        liquidAnim = CurvedAnimation(
          curve: Curves.elasticOut,
          reverseCurve: Curves.easeInBack,
          parent: animation,
        ),
        blueAnim = CurvedAnimation(
          curve: const SpringCurve(),
          reverseCurve: Curves.easeInCirc,
          parent: animation,
        ),
        yellowAnim = CurvedAnimation(
          parent: animation,
          curve: const Interval(0, 0.7,
              curve: Interval(0, 0.8, curve: SpringCurve())),
          reverseCurve: Curves.linear,
        ),
        greyAnim = CurvedAnimation(
          parent: animation,
          curve: const Interval(
            0,
            0.8,
            curve: Interval(0, 0.9, curve: SpringCurve()),
          ),
          reverseCurve: Curves.easeInCirc,
        ),
        orangeAnim = CurvedAnimation(
          parent: animation,
          curve: const Interval(
            0,
            0.7,
            curve: Interval(0, 0.8, curve: SpringCurve()),
          ),
          reverseCurve: Curves.linear,
        ),
        super(repaint: animation);

  final Animation<double> liquidAnim;
  final Animation<double> blueAnim;
  final Animation<double> yellowAnim;
  final Animation<double> greyAnim;
  final Animation<double> orangeAnim;

  final Paint darkGreenPaint;
  final Paint yellowPaint;
  final Paint greyPaint;
  final Paint darkOrangePaint;
  final Paint darkRedPaint;
  final Paint lightBluePaint;
  final Paint lightGreenPaint;
  final Paint greenPaint;
  final Paint lightYellowPaint;

  @override
  void paint(Canvas canvas, Size size) {
    print('painting');
    paintDarkGreen(size, canvas);
    paintGrey(size, canvas);
  }

  void paintDarkGreen(Size size, Canvas canvas) {
    final path = Path();
    path.moveTo(size.width, size.height / 2);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.lineTo(
      0,
      lerpDouble(0, size.height, liquidAnim.value),
    );
    _addPointsToPath(path, [
      Point(
        lerpDouble(0, size.width / 3, liquidAnim.value),
        lerpDouble(0, size.height, liquidAnim.value),
      ),
      Point(
        lerpDouble(size.width / 2, size.width / 4 * 3, liquidAnim.value),
        lerpDouble(size.height / 2, size.height / 4 * 3, liquidAnim.value),
      ),
      Point(
        size.width,
        lerpDouble(size.height / 2, size.height * 3 / 4, liquidAnim.value),
      ),
    ]);
    canvas.drawPath(path, darkGreenPaint);
  }

  void paintGrey(Size size, Canvas canvas) {
    final path = Path();
    path.moveTo(size.width, 300);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.lineTo(
      0,
      lerpDouble(
        size.height / 4,
        size.height / 2,
        liquidAnim.value,
      ),
    );
    _addPointsToPath(
      path,
      [
        Point(
          size.width / 4,
          lerpDouble(size.height / 2, size.height * 3 / 4, liquidAnim.value),
        ),
        Point(
          size.width * 3 / 5,
          lerpDouble(size.height / 4, size.height / 2, liquidAnim.value),
        ),
        Point(
          size.width * 4 / 5,
          lerpDouble(size.height / 6, size.height / 3, liquidAnim.value),
        ),
        Point(
          size.width,
          lerpDouble(size.height / 5, size.height / 4, liquidAnim.value),
        ),
      ],
    );

    canvas.drawPath(path, yellowPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  void _addPointsToPath(Path path, List<Point> points) {
    if (points.length < 3) {
      throw UnsupportedError('Need three or more points to create a path');
    }

    for (var i = 0; i < points.length - 2; i++) {
      final xc = (points[i].x + points[i + 1].x) / 2;
      final yc = (points[i].y + points[i + 1].y) / 2;
      path.quadraticBezierTo(points[i].x, points[i].y, xc, yc);
    }

    //connec the last tw points
    path.quadraticBezierTo(
        points[points.length - 2].x,
        points[points.length - 2].y,
        points[points.length - 1].x,
        points[points.length - 1].y);
  }
}

class Point {
  final double x;
  final double y;

  Point(this.x, this.y);
}

class SpringCurve extends Curve {
  const SpringCurve({
    this.a = 0.15,
    this.w = 19.4,
  });
  final double a;
  final double w;

  @override
  double transformInternal(double t) {
    return (-(pow(e, -t / a * cos(t * w) + 1).toDouble()));
  }
}
