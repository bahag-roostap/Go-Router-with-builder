import 'dart:math';
import 'dart:ui';

import 'package:barcode_widget/barcode_widget.dart';
import 'package:custom_widgets/widgets/widgets.dart';
import 'package:flutter/material.dart';

class DraggableScrollableStoreSheet extends StatefulWidget {
  const DraggableScrollableStoreSheet({super.key});

  @override
  State<DraggableScrollableStoreSheet> createState() =>
      _DraggableScrollableStoreSheetState();
}

class _DraggableScrollableStoreSheetState
    extends State<DraggableScrollableStoreSheet>
    with SingleTickerProviderStateMixin {
  // despite not explicitely used, SingleTickerProviderStateMixin is needed
  Color animatedBackgroundColor = const Color.fromARGB(0, 220, 220, 220);
  double sigma = 0.0;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.only(bottom: 12),
      child: NotificationListener<DraggableScrollableNotification>(
        onNotification: (notification) {
          final animatedExtent = notification.minExtent * 1.1;
          final currentExtent = notification.extent - notification.minExtent;
          final currentPercentageExtent = currentExtent / animatedExtent;
          setState(() {
            sigma = (min(currentPercentageExtent, 1) * 30);
            animatedBackgroundColor = animatedBackgroundColor.withAlpha(
              (min(currentPercentageExtent, 1) * 170).toInt(),
            );
          });
          return true;
        },
        child: DraggableScrollableSheet(
          initialChildSize: 0.15,
          maxChildSize: 0.8,
          minChildSize: 0.15,
          builder: ((context, scrollController) {
            return Stack(
              fit: StackFit.expand,
              children: [
                ClipPath(
                  clipper: SheetCircleUpperClipper(),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
                    child: Container(
                      color: animatedBackgroundColor,
                      child: SingleChildScrollView(
                        controller: scrollController,
                        scrollDirection: Axis.vertical,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 60),
                          child: Column(
                            children: [
                              SizedBox(
                                width: 250,
                                child: BarcodeWidget(
                                  data: "1231241241241",
                                  barcode: Barcode.qrCode(
                                      typeNumber: 4,
                                      errorCorrectLevel:
                                          BarcodeQRCorrectionLevel.low),
                                ),
                              ),
                              const Text("scan qr code")
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: IgnorePointer(
                    child: Container(
                      width: 50,
                      height: 50,
                      // child: ,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Konglomerat(
                          shapeColor: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}

class SheetCircleUpperClipper extends CustomClipper<Path> {
  final radius = 25;
  @override
  Path getClip(Size size) {
    return Path()
      ..moveTo(0, radius.toDouble() + 50)
      // ..moveTo(0, radius.toDouble())
      ..quadraticBezierTo(0, radius.toDouble(), 50, radius.toDouble())
      // ..lineTo(10, radius.toDouble() + 10)
      ..lineTo(size.width / 2 - radius, radius.toDouble())
      ..arcToPoint(
        Offset(size.width / 2 + radius, radius.toDouble()),
        radius: const Radius.circular(1),
      )
      ..lineTo(size.width - 50, radius.toDouble())
      ..quadraticBezierTo(
          size.width, radius.toDouble(), size.width, radius.toDouble() + 50)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }
}

class SheetCircleLowerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()
      ..moveTo(0, 0)
      ..lineTo(size.width / 2 - 30, 0)
      // ..quadraticBezierTo(size.width / 2 - 28, 0, size.width / 2 - 28, 10)
      ..arcToPoint(
        Offset(size.width / 2 + 30, 0),
        clockwise: false,
        radius: const Radius.circular(1),
      )
      // ..quadraticBezierTo(size.width / 2, 0, size.width / 2 + 45, 0)
      // ..quadraticBezierTo(size.width / 2 - 0, 0, size.width / 2, 0)
      // ..quadraticBezierTo(size.width / 2 + 0, 0, size.width / 2 + 0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}
