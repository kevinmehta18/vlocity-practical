import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:practical/domain/providers/dashboard_provider.dart';
import 'package:practical/presentation/dashboard/movies/movies_listing.dart';
import 'package:practical/presentation/dashboard/todo/todo_listing_screen.dart';
import 'package:practical/shared/constants/colors.dart';
import 'package:provider/provider.dart';

import 'widgets/bottom_bar_list.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      context.read<DashboardProvider>().setIndex(0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        await _onPopInvoked(context);
      },
      child: Consumer<DashboardProvider>(
        builder: (BuildContext context, provider, Widget? child) {
          return Scaffold(
            backgroundColor: kWhite,
            body: getBody(provider.currentIndex),
            bottomNavigationBar: getBottomNavBar(provider, context),
          );
        },
      ),
    );
  }

  Widget getBody(int currentIndex) {
    return currentIndex == 0
        ? const MoviesListingScreen()
        : const TodoListingScreen();
  }

  Widget getBottomNavBar(DashboardProvider provider, BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: kWhite,
      currentIndex: provider.currentIndex,
      onTap: (value) {
        onBottomNavBarItemPress(value, provider, context);
      },
      items: bottomBarItems,
      selectedItemColor: kPrimaryColor,
    );
  }

  /// BottomNavBar Item Press Event Handling
  onBottomNavBarItemPress(
      int value, DashboardProvider provider, BuildContext context) {
    provider.navigationQueue.addLast(provider.currentIndex);
    provider.setIndex(value);
  }

  Future<bool> _onPopInvoked(BuildContext context) async {
    DashboardProvider provider = context.read<DashboardProvider>();

    if (provider.navigationQueue.isNotEmpty) {
      int lastIndex = provider.navigationQueue.removeLast();
      provider.setIndex(lastIndex);
      return false;
    } else {
      SystemNavigator.pop();
    }

    return true;
  }
}
