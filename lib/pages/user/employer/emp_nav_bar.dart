import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hospal/pages/job/job_post_page.dart';
import 'package:line_icons/line_icons.dart';

import '../../../constants/style.dart';
import '../../../widgets/text_poppins_widget.dart';
import '../../job/job_custom_search_page.dart';
import 'emp_home_page.dart';
import 'emp_post_history_page.dart';
import 'emp_profile_page.dart';

class EmployerNavBar extends StatefulWidget {
  const EmployerNavBar({Key? key}) : super(key: key);

  @override
  State<EmployerNavBar> createState() => _EmployerNavBarState();
}

class _EmployerNavBarState extends State<EmployerNavBar> {
  int _selectedIndex = 0;
  static const List<Widget> _pageOptions = <Widget>[
    EmployerHomePage(),
    JobPostPage(),
    EmployerPostHistoryPage(),
    EmployerProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: light,
      appBar: AppBar(
        elevation: 20,
        title: PoppinsTextWidget(
          text: 'HosPal',
          color: light,
          size: fontTitle,
          isBold: true,
        ),
        centerTitle: true,
        backgroundColor: midOrange,
      ),
      body: Center(
        child: _pageOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: midOrange,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: const Color.fromARGB(80, 255, 255, 255),
              hoverColor: const Color.fromARGB(30, 255, 255, 255),
              gap: 10,
              activeColor: light,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: const Color.fromARGB(45, 255, 255, 255),
              color: light,
              tabs: const [
                GButton(
                  icon: LineIcons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: LineIcons.plusCircle,
                  text: 'New Post',
                ),
                GButton(
                  icon: LineIcons.history,
                  text: 'My Posts',
                ),
                GButton(
                  icon: LineIcons.user,
                  text: 'Profile',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
