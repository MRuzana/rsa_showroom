
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rsa_showroom/controllers/bottom_nav_provider.dart';
import 'package:rsa_showroom/views/bottom_nav/home_screen_content.dart';
import 'package:rsa_showroom/views/bottom_nav/ledgerScreen.dart';
import 'package:rsa_showroom/views/bottom_nav/profile.dart';
import 'package:rsa_showroom/views/bottom_nav/uncompleted.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final List<Widget> pages = [
    HomeScreenContent(),
    UnCompletedBookings(),
    LedgerScreen(),
    ProfileScreen(),
  ];

  final List<IconData> iconList = [
    Icons.home,
    Icons.receipt,
    Icons.request_page_outlined,
    Icons.person,
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final provider = Provider.of<BottomNavProvider>(context, listen: false);
        if (provider.selectedIndex != 0) {
          provider.updateIndex(0); // Go to home
          return false; // Don't exit the app
        }
        return true; // Exit the app
      },
      child: Scaffold(
        body: SafeArea(
          child: Consumer<BottomNavProvider>(
            builder: (context, provider, child) {
              return pages[provider.selectedIndex];
            },
          ),
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     _showBottomSheet(context);
        //   },
        //   shape: CircleBorder(),
        //   backgroundColor: Colors.green,
        //   child: const Icon(Icons.more_horiz, color: Colors.white),
        // ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: Consumer<BottomNavProvider>(
          builder: (context, provider, child) {
            return AnimatedBottomNavigationBar(
              icons: iconList,
              activeIndex: provider.selectedIndex,
              gapLocation: GapLocation.none, // ← disable the notch gap
              notchSmoothness: NotchSmoothness.softEdge,
              backgroundColor: Colors.red,
              activeColor: Colors.white,
              inactiveColor: Colors.black,
              elevation: 10,
              onTap: (index) {
                provider.updateIndex(index);
              },
            );
          },
        ),
      ),
    );
  }
}
