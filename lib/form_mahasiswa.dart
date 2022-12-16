// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors, prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'database/db_helper.dart';
import 'model/mahasiswa.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/src/widgets/container.dart';

class FormMahasiswa extends StatefulWidget {
  final Mahasiswa? mahasiswa;

  FormMahasiswa({this.mahasiswa});

  @override
  _FormMahasiswaState createState() => _FormMahasiswaState();
}

class _FormMahasiswaState extends State<FormMahasiswa> {
  DbHelper db = DbHelper();

  TextEditingController? name;
  TextEditingController? lastName;
  TextEditingController? nim;
  TextEditingController? prodi;
  TextEditingController? fakultas;

  @override
  void initState() {
    name = TextEditingController(
        text: widget.mahasiswa == null ? '' : widget.mahasiswa!.name);

    nim = TextEditingController(
        text: widget.mahasiswa == null ? '' : widget.mahasiswa!.nim);

    prodi = TextEditingController(
        text: widget.mahasiswa == null ? '' : widget.mahasiswa!.prodi);

    fakultas = TextEditingController(
        text: widget.mahasiswa == null ? '' : widget.mahasiswa!.fakultas);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Mahasiswa'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          TextFormField(
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp("[a-z A-Z .,']"))
            ],
            controller: name,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                hintText: "Masukan Nama Lengkap Anda",
                labelText: "Nama",
                border: OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(10.0))),
            validator: ((value) {
              if (value == null || value.isEmpty) {
                return 'Nama Tidak Boleh Kosong';
              }
              return null;
            }),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: TextFormField(
              maxLength: 12,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              controller: nim,
              decoration: InputDecoration(
                hintText: "Masukkan NIM Anda",
                labelText: "NIM",
                border: OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(10.0)),
              ),
              validator: ((value) {
                if (value == null || value.isEmpty) {
                  return 'NIM Tidak Boleh Kosong';
                }
                return null;
              }),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5.0),
            child: TextFormField(
              controller: prodi,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  hintText: "Masukkan Program Studi",
                  labelText: "Prodi",
                  border: OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(10.0))),
              validator: ((value) {
                if (value == null || value.isEmpty) {
                  return 'Masukkan Program Studi';
                }
                return null;
              }),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: TextFormField(
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp("[a-z A-Z ]"))
              ],
              controller: fakultas,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  hintText: "Masukkan Fakultas",
                  labelText: "Fakultas",
                  border: OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(10.0))),
              validator: ((value) {
                if (value == null || value.isEmpty) {
                  return 'Fakultas Tidak Boleh Kosong';
                }
                return null;
              }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ElevatedButton(
              child: (widget.mahasiswa == null)
                  ? Text(
                      'Add',
                      style: TextStyle(color: Colors.white),
                    )
                  : Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
              onPressed: () {
                upsertMhs();
              },
            ),
          )
        ],
      ),
    );
  }

  Future<void> upsertMhs() async {
    if (widget.mahasiswa != null) {
      //update
      await db.updateMahasiswa(Mahasiswa(
          id: widget.mahasiswa!.id,
          name: name!.text,
          nim: nim!.text,
          prodi: prodi!.text,
          fakultas: fakultas!.text));

      Navigator.pop(context, 'update');
    } else {
      //insert
      await db.saveMahasiswa(Mahasiswa(
        name: name!.text,
        nim: nim!.text,
        prodi: prodi!.text,
        fakultas: fakultas!.text,
      ));
      Navigator.pop(context, 'save');
    }
  }
}
