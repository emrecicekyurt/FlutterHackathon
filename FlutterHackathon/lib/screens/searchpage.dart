import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/services.dart';
import 'package:flutterhackathon/widgets/appbar_widget.dart';
import 'package:intl/intl.dart';
import 'searchresult.dart';



class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);
  @override
  _SearchPageState createState() => _SearchPageState();
}
class _SearchPageState extends State<SearchPage> {
  DateTimeRange dateRange = DateTimeRange(
    start: DateTime(2022, 12, 2),
    end: DateTime(2022, 31, 12),
  );

  List _items = [];
  List _city = [];
  List _district = [];
  late int indexCity = 0;

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
    super.initState();
  }

  String? selectedValue;

  final _formKey = GlobalKey<FormState>();
  String _dropDownValue = "One";
  late DateTime _dateTime;
  String time="?";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black,),
        actions: [BackButton(color: Colors.transparent,onPressed: (){},)],
        backgroundColor: Colors.white,
        title: Center(child: Text("Search Page", style: TextStyle(color: Colors.black),)),),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
        child: Column(
          key: _formKey,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //il
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
                  return 'Please select ciry.';
                }
              },
              onChanged: (value) {
                for (var i = 0; i < 81; i++) {
                  //print(_city[i]);
                }
                setState(() {
                  indexCity = _city.indexOf(value);
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
            //ilce
            const SizedBox(height: 30),
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
                  return 'Please select city.';
                }
              },
              onChanged: (value) {
                print(value);
                //Do something when changing the item if you want.
              },
              onSaved: (value) {
                selectedValue = value.toString();
                print(value);
              },
            ),
            const SizedBox(height: 12),
            //Katogori
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
              items: ['One', 'Two', 'Three'].map(
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
            const SizedBox(width: 12),
            //Date
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    textStyle: TextStyle(
                        color: Colors.black)
                ),

                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [

                    Icon(Icons.calendar_today_sharp, color: Colors.black,size: 25, ),
                    Text(" ${time}", style: TextStyle(color: Colors.black, fontSize: 25),)
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
            MaterialButton(
              onPressed: (){


                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Resultm()));




              },


              child: const Text('SEARCH'),
            ),
          ],
        ),
      ),
    );
  }

}