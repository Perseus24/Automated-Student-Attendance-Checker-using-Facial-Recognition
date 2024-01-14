import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<List<User>>(create: (_) => streamOfUsers(), initialData: []),
      ],
      child: MaterialApp(
        title: 'Firestore DEMO',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
      ),
    );
  }

  Stream<List<User>> streamOfUsers() {
    var ref = FirebaseFirestore.instance.collection('users');
    return ref.snapshots().map((list) => list.docs.map((doc) => User.fromFirestore(doc)).toList());
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final users = Provider.of<List<User>>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text("Firestore DEMO"),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    User user = users[index];
                    return ListTile(
                      title: Text(user.name),
                      subtitle: Text(user.id),
                      trailing: IconButton(icon: Icon(Icons.delete), onPressed: () => _removeUser(user)),
                      leading: IconButton(icon: Icon(Icons.edit), onPressed: () => _updateUser(user)),
                    );
                  }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                    child: Text("Add"),
                    onPressed: () => Firestore.instance.collection('users').document().setData({'name': 'New name added'})),
              ],
            ),
          ],
        ));
  }

  void _removeUser(User user) {
    Firestore.instance.collection('users').document(user.id).delete();
  }

  void _updateUser(User user) {
    Firestore.instance.collection('users').document(user.id).setData({'name': "My name changed"});
  }
}