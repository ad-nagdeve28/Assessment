import 'package:assessment/components/signout.dart';
import 'package:assessment/screens/homescreen.dart';
import 'package:assessment/screens/orderscreen.dart';
import 'package:assessment/screens/profilescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  bool _isBottomNavVisible = true;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (_isBottomNavVisible) {
          setState(() {
            _isBottomNavVisible = false;
          });
        }
      } else if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (!_isBottomNavVisible) {
          setState(() {
            _isBottomNavVisible = true;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _selectedIndex == 0
            ? const Text("Home")
            : _selectedIndex == 1
                ? const Text("Orders")
                : const Text("Profile"),
        actions: [
          if (_selectedIndex == 0)
            GestureDetector(
              onTap: () =>
                  Provider.of<SignOut>(context, listen: false).logout(context),
              child: const Image(
                height: 20,
                width: 20,
                image: AssetImage('assets/on-off-button.png'),
              ),
            ),
          const SizedBox(width: 20),
        ],
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          if (scrollNotification is ScrollUpdateNotification) {
            if (scrollNotification.scrollDelta != null) {
              if (scrollNotification.scrollDelta! > 0 && _isBottomNavVisible) {
                setState(() {
                  _isBottomNavVisible = false;
                });
              } else if (scrollNotification.scrollDelta! < 0 &&
                  !_isBottomNavVisible) {
                setState(() {
                  _isBottomNavVisible = true;
                });
              }
            }
          }
          return false;
        },
        child: IndexedStack(
          index: _selectedIndex,
          children: [
            HomeScreen(scrollController: _scrollController),
            OrderScreen(scrollController: _scrollController),
            ProfileScreen(scrollController: _scrollController),
          ],
        ),
      ),
      bottomNavigationBar: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: _isBottomNavVisible ? kBottomNavigationBarHeight : 0.0,
        child: Wrap(
          children: [
            Visibility(
              visible: _isBottomNavVisible,
              child: BottomNavigationBar(
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_cart),
                    label: 'Order',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: 'Profile',
                  ),
                ],
                currentIndex: _selectedIndex,
                onTap: _onItemTapped,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
