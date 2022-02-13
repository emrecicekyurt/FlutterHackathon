import 'package:flutter/material.dart';
import 'package:flutterhackathon/models/user.dart';
import 'package:flutterhackathon/screens/chats.dart';
import 'package:flutterhackathon/screens/postpage.dart';
import 'package:flutterhackathon/screens/profile_page.dart';
import 'package:flutterhackathon/screens/searchpage.dart';

class Dashboard extends StatefulWidget {
  final User currentUser;
  const Dashboard({ required this.currentUser });

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  

  static User currentUser = User(name: "Daniel",  surname: "Bourke", mail: "db@gmail.com", phone:"054xxxxxxx", photoUrl: "https://i.pravatar.cc/111", about:"", isActive:false, messages: [], contactPeople: []);
  int _selectedIndex = 0; 
  @override
  Widget build(BuildContext context) {



       final _tabs = [
      
      SearchPage(),
      PostPage(),
      Chats(widget.currentUser),
      ProfilePage(user: widget.currentUser),
    ];
    return   Scaffold(
        backgroundColor: Colors.white,
     
        body: _tabs[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.search),
                title: Text(
                  'Search',
                  
                )),
            BottomNavigationBarItem(
                icon: Icon(Icons.create),
                title: Text(
                  'Create Post',
                  
                )),
                BottomNavigationBarItem(
                icon: Icon(Icons.chat),
                title: Text(
                  'Chat',
                  
                )),
                BottomNavigationBarItem(
                icon: Icon(Icons.person),
                title: Text(
                  'Profile',
                  
                )),
          ],
          currentIndex: _selectedIndex,
          type: BottomNavigationBarType.fixed,
          fixedColor: Colors.green[600],
          onTap: _onItemTapped,
        ));
  }
    void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  
}
