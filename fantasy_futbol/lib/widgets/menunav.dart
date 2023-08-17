import 'package:fantasy_futbol/auth/main_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NavDrawer extends StatelessWidget {
 
  final List<_DrawerItem> _drawerItems = [
    _DrawerItem(Icons.input, 'Home', '/'),
    _DrawerItem(Icons.groups_2_sharp, 'Squad', '/squad'),
    _DrawerItem(Icons.settings, 'Settings', '/settings'),
    _DrawerItem(Icons.border_color, 'Feedback', '/feedback'),
    _DrawerItem(Icons.logout_sharp, 'Logout', '/logout'),
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
        if(item.logout){
           new MaterialPageRoute(builder:(BuildContext context) => MainPage());
         }
         else{
          Navigator.pushNamed(context, item.routeName);
         }
        
      },
    );
  }

  // void _handleLogout(BuildContext context){

  //  FirebaseAuth.instance.signOut();

  //   // Navigate to the sign-in page
  //   Navigator.pushReplacementNamed(context, '/logout');
  
  // }

}




class _DrawerItem {
  final IconData icon;
  final String title;
  final String routeName;
  final bool logout;
  _DrawerItem(this.icon, this.title, this.routeName, {this.logout = false});
}