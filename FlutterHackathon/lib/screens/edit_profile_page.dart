import 'dart:io';


import 'package:flutter/material.dart';
import 'package:flutterhackathon/models/user.dart';
import 'package:flutterhackathon/widgets/appbar_widget.dart';
import 'package:flutterhackathon/widgets/button_widget.dart';
import 'package:flutterhackathon/widgets/profile_widget.dart';
import 'package:flutterhackathon/widgets/text_field_widget.dart';
import 'package:path/path.dart';

class EditProfilePage extends StatefulWidget {
  final User user;

  EditProfilePage({required this.user});
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  String name = "";
  String mail = "";
  String about = "";
  @override
  Widget build(BuildContext context) =>  Scaffold(
            appBar: buildAppBar(context),
            body: ListView(
              padding: EdgeInsets.symmetric(horizontal: 32),
              physics: BouncingScrollPhysics(),
              children: [
                const SizedBox(height: 18),
                ProfileWidget(
                  imagePath: widget.user.photoUrl,
                  isEdit: true,
                  onClicked: () async {},
                ),
                const SizedBox(height: 24),
                TextFieldWidget(
                  label: 'Full Name',
                  text: widget.user.name,
                  onChanged: (name) {
                    name = name;
                  },
                ),
                const SizedBox(height: 24),
                TextFieldWidget(
                  label: 'Email',
                  text: widget.user.mail,
                  onChanged: (email) {
                    mail = email;
                  },
                ),
                const SizedBox(height: 24),
                TextFieldWidget(
                  label: 'About',
                  text: widget.user.about,
                  maxLines: 5,
                  onChanged: (about) {
                    about = about;
                  },
                ),

                Padding(
                  padding: const EdgeInsets.only(top:8.0),
                  child: ButtonWidget(text: "Onayla", onClicked: (){
                    widget.user.name = name;
                    widget.user.mail= mail;
                    widget.user.about = about;
                    Navigator.pop(context);
                  }),
                )
              ],
            ),
          );
       
}