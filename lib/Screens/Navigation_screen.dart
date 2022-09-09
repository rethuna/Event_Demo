import 'package:event_dynamic_link/Screens/Home_screen.dart';
import 'package:event_dynamic_link/Screens/PostScreen.dart';
import 'package:event_dynamic_link/config/palette.dart';
import 'package:flutter/material.dart';
class MyDrawerDirectory extends StatelessWidget {
  Color mainColor = Palette.primaryColor;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            // <-- SEE HERE
            decoration: BoxDecoration(color: mainColor),
            accountName: Text(
              "Event Invitation",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            accountEmail: Text(
              "event@gmail.com",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            currentAccountPicture: Image.asset("images/a.jpg"),
          ),
          ListTile(
            leading: Icon(
              Icons.home,
            ),
            title: const Text('Home'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                  builder: (context) => MyHomePage()));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.calendar_today_rounded,
            ),
            title: const Text('My Event'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PostScreen("Invitation")));
            },
          ),

          ListTile(
            leading: Icon(
              Icons.notifications_active_outlined,
            ),
            title: const Text('Notification'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
            ),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
