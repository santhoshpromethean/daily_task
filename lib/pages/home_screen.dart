import 'package:flutter/material.dart';
import 'add_task_screen.dart';
import 'overview_page_view.dart';
import 'upcoming_page_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _togglePressed(int index) {
    setState(() {
      _selectedIndex = index;
      _tabController.animateTo(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: height * 0.25,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  "Hello",
                  style: TextStyle(fontSize: 40),
                ),
                const Spacer(),
                ClipOval(
                  child: Image.asset(
                    "lib/assets/images/img.png",
                    height: width * 0.12,
                    width: width * 0.12,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            SizedBox(height: height * 0.02),
            const Text(
              "Home",
              style: TextStyle(fontSize: 24, color: Colors.blue),
            ),
            SizedBox(height: height * 0.02),
            Row(
              children: [
                CustomButton(
                  value: "Overview",
                  isSelected: _selectedIndex == 0,
                  onPressed: () => _togglePressed(0),
                  width: 100,
                ),
                const SizedBox(width: 10),
                CustomButton(
                  value: "Upcoming",
                  isSelected: _selectedIndex == 1,
                  onPressed: () => _togglePressed(1),
                  width: 100,
                ),
              ],
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          OverviewTab(),
          UpcomingTab(),
        ],
      ),
    );
  }
}
