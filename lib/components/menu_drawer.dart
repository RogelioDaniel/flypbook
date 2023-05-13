import 'package:flutter/material.dart';

class MenuDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
              child: Center(
                child: Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.home,
                color: Colors.blue,
              ),
              title: Text(
                'Home',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 16,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.info,
                color: Colors.blue,
              ),
              title: Text(
                'About',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 16,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                // Navigate to About screen
              },
            ),
          ],
        ),
      ),
    );
  }
}
