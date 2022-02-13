import 'package:flutterhackathon/models/message.dart';

class User {
   String name;
   String surname;
   String phone;
   String mail;
   String photoUrl;
   String about;
   bool? isActive;
   List<Message> messages;
   List<User> contactPeople;

  User(
    {
    required this.name,
    required this.surname,
    required this.mail,
    required this.phone,
    required this.photoUrl,
    required this.about,
    required this.isActive,
    required this.messages,
    required this.contactPeople, 
} 
  );
}