import 'package:daily_task/pages/add_task_screen.dart';
import 'package:daily_task/pages/home_screen.dart';
import 'package:daily_task/pages/task_library_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
    print('Firebase Initialized Successfully!');
  } catch (e) {
    print('Error Initializing Firebase: $e');
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainNavigation(),
    );
  }
}

class MainNavigation extends StatefulWidget {
  @override
  _MainNavigationState createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 1;

  final List<Widget> _screens = [
    AddTaskScreen(),
    HomeScreen(),
    TaskLibraryScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: false,
        showSelectedLabels: false,
        iconSize: 60,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.add_circle,
                size: 50,
                color: _selectedIndex == 0 ? Colors.black : Colors.grey,
              ),
              label: ""),
          BottomNavigationBarItem(
              icon: _selectedIndex == 1
                  ? CircleAvatar(
                      backgroundColor:
                          _selectedIndex == 1 ? Colors.black : Colors.grey,
                      child: Icon(
                        Icons.home_sharp,
                        color: Colors.white,
                      ),
                    )
                  : CircleAvatar(
                      backgroundColor:
                          _selectedIndex == 1 ? Colors.white : Colors.grey,
                      child: Icon(
                        Icons.home_sharp,
                        color: Colors.white,
                      ),
                    ),
              label: ""),
          BottomNavigationBarItem(
              icon: _selectedIndex == 2
                  ? CircleAvatar(
                      backgroundColor:
                          _selectedIndex == 2 ? Colors.black : Colors.grey,
                      child: Icon(
                        Icons.my_library_books,
                        color: Colors.white,
                      ),
                    )
                  : CircleAvatar(
                      backgroundColor:
                          _selectedIndex == 2 ? Colors.white : Colors.grey,
                      child: Icon(
                        Icons.my_library_books_outlined,
                        color: Colors.white,
                      ),
                    ),
              label: "Library"),
        ],
      ),
    );
  }
}
