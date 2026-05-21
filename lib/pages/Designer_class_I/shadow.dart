import 'package:flutter/material.dart';

class shadow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  static BoxDecoration boxshadow(
    double width,
    double radius,
    double offset1,
    double offset2,
  ) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(width * radius),
      color: Colors.grey.shade300,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.shade500,
          offset: Offset(offset1, offset1),
          blurRadius: 15.0,
          spreadRadius: 1.0,
        ),
        BoxShadow(
          color: Colors.white,
          offset: Offset(offset2, offset2),
          blurRadius: 15.0,
          spreadRadius: 1.0,
        ),
      ],
    );
  }

  static BoxDecoration boxshadowForAppBar(
    double width,
    double radius,
    double offset1,
    double offset2, {
    Color? color,
    double? blurRadius_1,
    double? blurRadius_2,
    double? spreadRadius_1,
    double? spreadRadius_2,
  }) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(width * radius),
      color: (color == null) ? Colors.grey.shade300 : color,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.shade500,
          offset: Offset(offset1, offset1),
          blurRadius: (blurRadius_1 == null) ? 15.0 : blurRadius_1,
          spreadRadius: (spreadRadius_1 == null) ? 1.0 : spreadRadius_1,
        ),
        BoxShadow(
          color: Colors.white,
          offset: Offset(offset2, offset2),
          blurRadius: (blurRadius_2 == null) ? 15.0 : blurRadius_2,
          spreadRadius: (spreadRadius_2 == null) ? 1.0 : spreadRadius_2,
        ),
      ],
    );
  }

  static BoxDecoration boxshadowForMenuIcon(
    double width,
    double radius,
    double offset1,
    double offset2, {
    Color? color,
    double? blurRadius_1,
    double? blurRadius_2,
    double? spreadRadius_1,
    double? spreadRadius_2,
    bool? border,
  }) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(width * radius),
      color: (color == null) ? Colors.grey.shade300 : color,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.shade500,
          offset: Offset(offset1, offset1),
          blurRadius: (blurRadius_1 == null) ? 15.0 : blurRadius_1,
          spreadRadius: (spreadRadius_1 == null) ? 1.0 : spreadRadius_1,
        ),
        BoxShadow(
          color: Colors.white,
          offset: Offset(offset2, offset2),
          blurRadius: (blurRadius_2 == null) ? 15.0 : blurRadius_2,
          spreadRadius: (spreadRadius_2 == null) ? 1.0 : spreadRadius_2,
        ),
      ],
      border:
          (border == false || border == null)
              ? Border.all(width: 0, color: Colors.transparent)
              : Border(
                right: BorderSide(
                  color: const Color.fromARGB(117, 158, 158, 158),
                  width: 1.3,
                ),
              ),
    );
  }
}
