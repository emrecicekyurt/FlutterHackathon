import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterhackathon/models/user.dart';
import 'package:flutterhackathon/screens/chat_details.dart';
import 'package:flutterhackathon/widgets/appbar_widget.dart';
import 'package:flutterhackathon/widgets/button_widget.dart';
import 'package:flutterhackathon/widgets/number_widget.dart';
import 'package:flutterhackathon/widgets/profile_widget.dart';

class ProfilePageReadOnly extends StatefulWidget {
  final User targetUser;
  final User currentUser;

  ProfilePageReadOnly({required this.targetUser, required this.currentUser});
  @override
  _ProfilePageReadOnlyState createState() => _ProfilePageReadOnlyState();
}

class _ProfilePageReadOnlyState extends State<ProfilePageReadOnly> {
  @override
  Widget build(BuildContext context) {

    return 
     Scaffold(
        appBar: buildAppBar(context),
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            const SizedBox(height: 18),
            ProfileWidget(
              editingIcon: false,
              imagePath: widget.targetUser.photoUrl,
              onClicked: () {
               
              },
            ),
            const SizedBox(height: 24),
            buildName(widget.targetUser),
            const SizedBox(height: 24),
            Center(child: buildUpgradeButton()),
            const SizedBox(height: 24),
            NumbersWidget(),
            const SizedBox(height: 48),
            buildAbout(widget.targetUser),
          ],
        ),
      );
    
  }

  Widget buildName(User user) => Column(
        children: [
          Text(
            user.name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            user.mail,
            style: TextStyle(color: Colors.grey),
          )
        ],
      );

  Widget buildUpgradeButton() => ButtonWidget(
        text: 'Mesaj Gönder',
        onClicked: () {
            Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ChatDetails(currentUser: widget.currentUser, targetUser: widget.targetUser ,)),
                );
        },
      );

  Widget buildAbout(User user) => Container(
        padding: EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              user.about,
              style: TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      );
}