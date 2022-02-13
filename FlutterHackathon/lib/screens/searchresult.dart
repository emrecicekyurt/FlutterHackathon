import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class Resultm extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: SafeArea(

          child: Result(),
      ),
    );
  }
}

class Result extends StatefulWidget {
  const Result({Key? key}) : super(key: key);

  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance.collection('Postlar').snapshots(),
      builder: (_, snapshot) {
        if (snapshot.hasError) return Text('Error = ${snapshot.error}');

        if (snapshot.hasData) {
          final docs = snapshot.data!.docs;
          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (_, i) {
              final data = docs[i].data();
              return ListTile(
                leading: Image.network("https://ps.w.org/simple-user-avatar/assets/icon-256x256.png?rev=2413146",
                  width: 150,
                  fit: BoxFit.cover,),
                title: Text(""" ${data['Name']} ${data['City']} ${data['District']} ${data['Date']} ${data['time']}"""),
                subtitle: Text(data['Explenation']),
              );
            },
          );
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
