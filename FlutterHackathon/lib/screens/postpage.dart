import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterhackathon/models/user_model.dart';


class PostPage extends StatefulWidget {
  const PostPage({Key? key}) : super(key: key);
  @override
  _PostPageState createState() => _PostPageState();
}
class _PostPageState extends State<PostPage> {
  final _firestore=FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  DateTimeRange dateRange = DateTimeRange(
    start: DateTime(2022, 12, 2),
    end: DateTime(2022, 31, 12),
  );

  List _items = [];
  List _city = [];
  List _district = [];
  late int indexCity = 0;
  String? il;
  String? ilce;
  String? selectedValue;
  String? userName;


  // Fetch content from the json file
  Future<void> readJson() async {
    final String response =
    await rootBundle.loadString('assets/json_data.json');
    final data = await json.decode(response);
    setState(() {
      _items = data["items"];
      //print(data["items"][80]["name"]);
      var num = _items.length;
      //print(_items[6]["counties"][1]);
      for (var i = 0; i < num; i++) {
        _city.add(data["items"][i]["name"]);
      }
    });
  }

  @override
  void initState() {
    readJson();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {
        userName=loggedInUser.firstName.toString()+' '+loggedInUser.secondName.toString();
      });
    });
    super.initState();
  }



  final _formKey = GlobalKey<FormState>();
  String _dropDownValue = "For Humans";
  late DateTime _dateTime;
  TimeOfDay selectedTime = TimeOfDay.now();
  String time="?";
  String? hours;
  TextEditingController textController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    CollectionReference postRef = _firestore.collection('Postlar');

    return Scaffold(
        appBar: AppBar(
        leading: BackButton(color: Colors.black,),
        actions: [BackButton(color: Colors.transparent,onPressed: (){},)],
        backgroundColor: Colors.white,
        title: Center(child: Text("Create Post Page", style: TextStyle(color: Colors.black),)),),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 8),
          child: ListView(
            children: [
              Column(
                key: _formKey,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //city
                  DropdownButtonFormField2(
                    decoration: InputDecoration(
                      //Add isDense true and zero Padding.
                      //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      //Add more decoration as you want here
                      //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                    ),
                    isExpanded: true,
                    hint: const Text(
                      'Select Your City',
                      style: TextStyle(fontSize: 14),
                    ),
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black45,
                    ),
                    iconSize: 30,
                    buttonHeight: 60,
                    buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                    dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    items: _city
                        .map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ))
                        .toList(),
                    validator: (value) {
                      if (value == null) {
                        return 'Please select city.';
                      }
                    },
                    onChanged: (value) {
                      for (var i = 0; i < 81; i++) {
                        //print(_city[i]);
                      }
                      setState(() {
                        indexCity = _city.indexOf(value);
                        il=value.toString();
                      });

                      print(indexCity);

                      //indexCity=_city.indexOf(value);
                      setState(() {
                        //_district.clear();
                        var index = _items[_city.indexOf(value)]["counties"].length;
                        //print(_items[_city.indexOf(value)]["counties"][1]);
                        for (var i = 0; i < index; i++) {
                          //print(_items[_city.indexOf(value)]["counties"][i]);
                          _district
                              .add(_items[_city.indexOf(value)]["counties"][i]);
                        }
                      });
                      //indexCity=_city.indexOf(value);

                      //Do something when changing the item if you want.
                    },
                    onSaved: (value) {
                      selectedValue = value.toString();
                    },
                  ),
                  const SizedBox(height: 25),
                  //ilce
                  DropdownButtonFormField2(
                    decoration: InputDecoration(
                      //Add isDense true and zero Padding.
                      //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      //Add more decoration as you want here
                      //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                    ),
                    isExpanded: true,
                    hint: const Text(
                      'Select Your District',
                      style: TextStyle(fontSize: 14),
                    ),
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black45,
                    ),
                    iconSize: 30,
                    buttonHeight: 60,
                    buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                    dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    items: _district
                        .map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ))
                        .toList(),
                    validator: (value) {
                      if (value == null) {
                        return 'Please district city.';
                      }
                    },
                    onChanged: (value) {
                      setState(() {
                        ilce=value.toString();
                      });
                      print(value);
                      //Do something when changing the item if you want.
                    },
                    onSaved: (value) {
                      selectedValue = value.toString();
                      print(value);
                    },
                  ),

                  const SizedBox(height: 12),
                  //Secenekler
                  DropdownButton(
                    hint: _dropDownValue == null
                        ? Text('Dropdown')
                        : Text(
                      _dropDownValue,
                      style: TextStyle(color: Colors.blue),
                    ),
                    isExpanded: true,
                    iconSize: 30.0,
                    style: TextStyle(color: Colors.blue),
                    items: ['For Humans', 'For Animals', 'For Humans and Animals'].map(
                          (val) {
                        return DropdownMenuItem<String>(
                          value: val,
                          child: Text(val),
                        );
                      },
                    ).toList(),
                    onChanged: (String? val) {
                      setState(
                            () {
                          _dropDownValue = val!;
                        },
                      );
                    },
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ElevatedButton(

                            child: Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Icon(Icons.calendar_today_sharp),
                                Text(" ${time}")
                              ],
                            ),

                            onPressed: () async {

                              _dateTime= (await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2025)))!;

                              setState(() {
                                time=DateFormat("dd-MM-yy").format(_dateTime);
                              });
                            }),
                        ElevatedButton(
                          onPressed: () {
                            _selectTime(context);
                            setState(() {
                              hours="${selectedTime.hour}:${selectedTime.minute}";
                            });
                          },
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [

                              Text("${selectedTime.hour}:${selectedTime.minute}"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),

                  TextField(
                    maxLines: 5,
                    controller: textController,
                    maxLength: 250,
                    //cursorColor: Colors.black,
                    style: TextStyle(
                        color: Colors.black
                    ),
                    decoration: InputDecoration(
                      hintText: "Enter your name",
                      labelText: 'Aciklama',
                      prefixText: ' ',
                      prefixStyle: TextStyle(),
                      suffixText: 'MP',
                      hintStyle: TextStyle(color: Colors.black),

                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(12)
                      ),
                    ),
                  ),
                  // submit
                  MaterialButton(
                    onPressed: () async {
                      
                      print(textController.text);
                      print(il);
                      print(ilce);
                      print(_dropDownValue);
                      print(time);
                      print(hours);
                      print(userName);

                      Map<String, dynamic> postData={"City":il,"Name":userName,"District":ilce,"Category":_dropDownValue,"Date": time,"Time":hours,"Explenation":textController.text,};
                      await postRef.doc(userName).set(postData);
                      
                       showDialog<String>(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                            title: const Text('Success'),
                                            content: const Text(
                                                'Your post is created'),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () =>
                                                    Navigator.pop(context, 'OK'),
                                                child: const Text('OK'),
                                              ),
                                            ],
                                          ),
                                        );
                    },
                    child: const Text('Submit Button'),
                    
                  ),


                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.dial,

    );
    if(timeOfDay != null && timeOfDay != selectedTime)
    {
      setState(() {
        selectedTime = timeOfDay;
      });
    }
  }

}