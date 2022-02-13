
import 'package:flutterhackathon/models/user.dart';
import 'package:flutterhackathon/models/user_model.dart';

User userHelper(UserModel userModel){
   return User(name: userModel.firstName!, surname: userModel.secondName!, mail: userModel.email!, phone: "", photoUrl: "https://i.pravatar.cc/114", about: "", isActive: true, messages: [], contactPeople: [User(name:"Jason",  surname: "Leo", mail: "jl@gmail.com", phone: "054xxxxxxx",  photoUrl: "https://i.pravatar.cc/110", about: "", isActive: true, messages: [], contactPeople: []),User(name: "Daniel",  surname: "Bourke", mail: "db@gmail.com", phone:"054xxxxxxx", photoUrl: "https://i.pravatar.cc/111", about:"", isActive:false, messages: [], contactPeople: [])]);   
}