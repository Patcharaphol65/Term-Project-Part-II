import 'package:flutter/material.dart';
import 'package:group_project/views/login.dart';

import 'package:group_project/views/read_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dangerous American Area',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        '/': (context) => const HomePage(), // The home route
        '/login': (context) => createPage()
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  List<Widget> _pages = [
    const ReadData(),
    LoginPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        height: 70, // adjust the height as needed
        color: const Color.fromARGB(255, 255, 255, 255), // พื้นหลังไอคอน
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceAround, // distribute items evenly
          children: [
            PageViewer(
              selectedIndex: _selectedIndex,
              currentIndex: 0,
              onTap: _onItemTapped,
              iconData: Icons.home,
              label: 'Home',
            ),
            PageViewer(
              selectedIndex: _selectedIndex,
              currentIndex: 1,
              onTap: _onItemTapped,
              iconData: Icons.data_saver_on,
              label: 'Insert',
            ),
          ],
        ),
      ),
    );
  }
}

class PageViewer extends StatefulWidget {
  final int selectedIndex;
  final int currentIndex;
  final Function(int) onTap;
  final IconData iconData;
  final String label;

  const PageViewer({
    Key? key,
    required this.selectedIndex,
    required this.currentIndex,
    required this.onTap,
    required this.iconData,
    required this.label,
  }) : super(key: key);

  @override
  _PageViewerState createState() => _PageViewerState();
}

class _PageViewerState extends State<PageViewer> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent, // ทำให้ Material โปร่งใส
      child: InkWell(
        onTap: () {
          widget.onTap(widget.currentIndex);
        },
        splashColor: Colors.blue.withOpacity(0.3), // สีวง ripple effect
        borderRadius: BorderRadius.circular(50), // ทำให้ ripple มีขอบโค้งมน
        child: Column(
          mainAxisSize: MainAxisSize.min, // shrink-wrap the column
          children: [
            Icon(
              widget.iconData, // icon passed from the parent widget
              color: widget.selectedIndex == widget.currentIndex
                  ? const Color.fromARGB(255, 0, 68, 255)
                  : const Color.fromARGB(255, 0, 0, 0),
            ),
            Text(
              widget.label, // label text passed from the parent widget
              style: TextStyle(
                color: widget.selectedIndex == widget.currentIndex
                    ? const Color.fromARGB(255, 0, 68, 255)
                    : const Color.fromARGB(255, 0, 0, 0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
