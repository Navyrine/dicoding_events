import 'package:dicoding_events/screen/finished_event_screen.dart';
import 'package:dicoding_events/screen/home_screen.dart';
import 'package:dicoding_events/screen/upcoming_event_screen.dart';
import 'package:flutter/material.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int _selectedIndex = 0;

  void _selectedScreen(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activeScreen = const HomeScreen();

    if (_selectedIndex == 1) {
      activeScreen = const UpcomingEventScreen();
    }

    if (_selectedIndex == 2) {
      activeScreen = const FinishedEventScreen();
    }

    return Scaffold(
      body: activeScreen,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          _selectedScreen(index);
        },
        items: const [
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: "Upcoming Event",
            icon: Icon(Icons.schedule),
          ),
          BottomNavigationBarItem(
            label: "Finished Events",
            icon: Icon(Icons.event_available),
          ),
        ],
      ),
    );
  }
}
