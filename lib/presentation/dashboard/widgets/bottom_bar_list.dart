import 'package:flutter/material.dart';
import 'package:practical/shared/constants/colors.dart';
import 'package:practical/shared/constants/strings.dart';

List<BottomNavigationBarItem> bottomBarItems = [
  BottomNavigationBarItem(
    label: movies,
    backgroundColor: Colors.transparent,
    icon: const Icon(Icons.movie_creation_rounded),
    activeIcon: Icon(
      Icons.movie_creation_rounded,
      color: kPrimaryColor,
    ),
  ),
  BottomNavigationBarItem(
    label: todo,
    backgroundColor: Colors.transparent,
    icon: const Icon(Icons.task),
    activeIcon: Icon(
      Icons.task,
      color: kPrimaryColor,
    ),
  )
];
