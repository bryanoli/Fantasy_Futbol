import 'package:flutter/material.dart';

class NavDrawer extends StatelessWidget {
 
  final List<_DrawerItem> _drawerItems = [
    _DrawerItem(Icons.input, 'Home', '/'),
    _DrawerItem(Icons.verified_user, 'Squad', '/squad'),
    _DrawerItem(Icons.settings, 'Settings', '/settings'),
    _DrawerItem(Icons.border_color, 'Feedback', '/feedback'),
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.black,
                image: DecorationImage(
                  fit: BoxFit.scaleDown,
                  image: AssetImage('assets/images/profile.jpg'),
                ),
              ),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
            for (var item in _drawerItems)
              _buildMult(item, context),
          ],
        ),
      ),
    );
  }

  ListTile _buildMult(_DrawerItem item, BuildContext context) {
    return ListTile(
      leading: Icon(item.icon),
      title: Text(item.title),
      onTap: () {
        Navigator.pushNamed(context, item.routeName);
      },
    );
  }
}


class _DrawerItem {
  final IconData icon;
  final String title;
  final String routeName;

  _DrawerItem(this.icon, this.title, this.routeName);
}