import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
class User {
  final String name, email, userName;
  User(this.name, this.email, this.userName);
}
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DataFromAPI(),
    );
  }
}

class DataFromAPI extends StatefulWidget {
  @override
  _DataFromAPIState createState() => _DataFromAPIState();
}

class _DataFromAPIState extends State<DataFromAPI> {

  Future getUserData() async {
    var response =
    await http.get(Uri.https('jsonplaceholder.typicode.com', 'users'));
    var jsonData = jsonDecode(response.body);
    List<User> users = [];

    for (var u in jsonData) {
      var user = User(u["name"], u["email"], u["username"]);
      users.add(user);
    }
    print(users.length);
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Data'),
      ),
      body: Container(
        child: Card(
          child: FutureBuilder(
            future: getUserData(),
            builder: (context, AsyncSnapshot snapshot){
              if (snapshot.data == null) {
                return Container(
                  child: Center(
                    child: Text('Loading...'),
                  ),
                );
              }
              else {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, i) {
                      return ListTile(
                        title: Text(snapshot.data[i].name),
                        subtitle: Text(snapshot.data[i].userName),
                        trailing: Text(snapshot.data[i].email),
                      );
                    });
              }
            },
          ),
        ),
      ),
    );
  }


}
