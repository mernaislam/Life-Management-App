import 'package:flutter/material.dart';

class WaveClipperThird extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - size.height*0.2);
    var firstStart = Offset(size.width / 5, size.height - size.height*0.02);
    var firstEnd = Offset(size.width / 2, size.height - size.height*0.009);
    path.quadraticBezierTo(firstStart.dx, firstStart.dy, firstEnd.dx, firstEnd.dy);
    var secondStart = Offset(size.width - size.width / 3.24, size.height - size.height*0.02);
    var secondEnd = Offset(size.width, size.height - size.height*0.2);
    path.quadraticBezierTo(secondStart.dx, secondStart.dy, secondEnd.dx, secondEnd.dy);
    
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }
  
  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}