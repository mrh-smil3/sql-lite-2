// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_element, non_constant_identifier_names, avoid_types_as_parameter_names, avoid_function_literals_in_foreach_calls, unused_local_variable, unused_import, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'database/db_helper.dart';
import 'form_mahasiswa.dart';
import 'list_mahasiswa.dart';
import 'edit_mahasiswa.dart';
import 'hapus_mahasiswa.dart';
import 'model/mahasiswa.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       home: ListKontakPage(),
//     );
//   }
// }

// import 'package:flutter/material.dart';

// import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Mahasiswa App'),
        ),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        padding: EdgeInsets.all(20),
        child: Column(children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return FormMahasiswa();
              }));
            },
            child: Text("Add Mahasiswa"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return EditMahasiswaPage();
              }));
            },
            child: Text("Edit"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return HapusMahasiswaPage();
              }));
            },
            child: Text("Hapus"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return ListMahasiswaPage();
              }));
            },
            child: Text("List Mahasiswa Record"),
          ),
        ]),
      ),
    );
  }
}
