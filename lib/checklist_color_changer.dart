import 'package:flutter/material.dart';

class TitleColorChanger {
  final deadlineColor0 = 0xff8ede78;
  final deadlineColor1 = 0xff9dde78;
  final deadlineColor2 = 0xffa6de78;
  final deadlineColor3 = 0xffb7de78;
  final deadlineColor4 = 0xffc6de78;
  final deadlineColor5 = 0xffd4de78;
  final deadlineColor6 = 0xffdedb78;
  final deadlineColor7 = 0xffded278;
  final deadlineColor8 = 0xffdec378;
  final deadlineColor9 = 0xffdeb278;
  final deadlineColor10 = 0xffde9878;
  final deadlineColor11 = 0xffde7878;

  final List<int> deadlineColorList = [
    0xff8ede78,
    0xff9dde78,
    0xffa6de78,
    0xffb7de78,
    0xffc6de78,
    0xffd4de78,
    0xffdedb78,
    0xffded278,
    0xffdec378,
    0xffdeb278,
    0xffde9878,
    0xffde7878,
  ];

  Map<DateTime, Color> colorTimeFrames = {};

  DateTime _creationDate;

  Duration _deadlineIncrement;

  TitleColorChanger(DateTime creationDateIn, DateTime deadlineDateIn) {
    _creationDate = creationDateIn;

    _deadlineIncrement = deadlineDateIn.difference(creationDateIn) ~/ 12;

    for (int i = 1; i <= 12; i++) {
      colorTimeFrames[creationDateIn.add(_deadlineIncrement * i)] =
          Color(deadlineColorList[i - 1]);
    }

    print(colorTimeFrames);
  }

  Color getTitleColor(DateTime updatedTime) {
    Duration shortestTime = _deadlineIncrement;

    DateTime closestTimeFrame = _creationDate;

    colorTimeFrames.forEach((timeFrame, color) {
      if (timeFrame.difference(updatedTime).abs() < shortestTime) {
        closestTimeFrame = timeFrame;
      }
    });

    print("New Updated Closest Time Frame: ${closestTimeFrame.toString()}");

    return (closestTimeFrame != null)
        ? colorTimeFrames[closestTimeFrame]
        : Color(0xffffffff);
  }
}
