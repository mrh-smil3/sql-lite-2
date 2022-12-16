// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_function_literals_in_foreach_calls, non_constant_identifier_names, unused_element, unused_local_variable, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'form_mahasiswa.dart';

import 'database/db_helper.dart';
import 'model/mahasiswa.dart';

class EditMahasiswaPage extends StatefulWidget {
  const EditMahasiswaPage({Key? key}) : super(key: key);

  @override
  _EditMahasiswaPageState createState() => _EditMahasiswaPageState();
}

class _EditMahasiswaPageState extends State<EditMahasiswaPage> {
  List<Mahasiswa> listMahasiswa = [];
  DbHelper db = DbHelper();

  @override
  void initState() {
    //menjalankan fungsi getallkontak saat pertama kali dimuat
    _getAllMahasiswa();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Mahasiswa'),
      ),
      body: ListView.builder(
          itemCount: listMahasiswa.length,
          itemBuilder: (context, index) {
            Mahasiswa mahasiswa = listMahasiswa[index];
            return Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ListTile(
                leading: Icon(
                  Icons.person,
                  size: 50,
                ),
                title: Text('${mahasiswa.name}'),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                      ),
                      child: Text("NIM: ${mahasiswa.nim}"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                      ),
                      child: Text("Prodi: ${mahasiswa.prodi}"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                      ),
                      child: Text("Fakultas: ${mahasiswa.fakultas}"),
                    )
                  ],
                ),
                trailing: FittedBox(
                  fit: BoxFit.fill,
                  child: Row(
                    children: [
                      // button edit
                      // IconButton(
                      //     onPressed: () {
                      //       _openFormEdit(mahasiswa);
                      //     },
                      //     icon: Icon(Icons.edit)),
                      TextButton(
                        onPressed: () {
                          _openFormEdit(mahasiswa);
                        },
                        child: Text(
                          "Edit",
                        ),
                      ),
                      // button hapus
                      // IconButton(
                      //   icon: Icon(Icons.delete),
                      // TextButton(
                      //   child: Text("Hapus"),
                      //   onPressed: () {
                      //     //membuat dialog konfirmasi hapus
                      //     AlertDialog hapus = AlertDialog(
                      //       title: Text("Information"),
                      //       content: Container(
                      //         height: 100,
                      //         child: Column(
                      //           children: [
                      //             Text(
                      //                 "Yakin ingin Menghapus Data ${mahasiswa.name}")
                      //           ],
                      //         ),
                      //       ),
                      //       //terdapat 2 button.
                      //       //jika ya maka jalankan _deleteKontak() dan tutup dialog
                      //       //jika tidak maka tutup dialog
                      //       actions: [
                      //         TextButton(
                      //             onPressed: () {
                      //               _deleteKontak(mahasiswa, index);
                      //               Navigator.pop(context);
                      //             },
                      //             child: Text("Ya")),
                      //         TextButton(
                      //           child: Text('Tidak'),
                      //           onPressed: () {
                      //             Navigator.pop(context);
                      //           },
                      //         ),
                      //       ],
                      //     );
                      //     showDialog(
                      //         context: context, builder: (context) => hapus);
                      //   },
                      // )
                    ],
                  ),
                ),
              ),
            );
          }),
      //membuat button mengapung di bagian bawah kanan layar
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.add),
      //   onPressed: () {
      //     _openFormCreate();
      //   },
      // ),
    );
  }

  //mengambil semua data Mahasiswa
  Future<void> _getAllMahasiswa() async {
    //list menampung data dari database
    var list = await db.getAllMahasiswa();

    //ada perubahanan state
    setState(() {
      //hapus data pada listMahasiswa
      listMahasiswa.clear();

      //lakukan perulangan pada variabel list
      list!.forEach((mahasiswa) {
        //masukan data ke listMahasiswa
        listMahasiswa.add(Mahasiswa.fromMap(mahasiswa));
      });
    });
  }

  //menghapus data Mahasiswa
  Future<void> _deleteKontak(Mahasiswa mahasiswa, int position) async {
    await db.deleteMahasiswa(mahasiswa.id!);
    setState(() {
      listMahasiswa.removeAt(position);
    });
  }

  // membuka halaman tambah Mahasiswa
  Future<void> _openFormCreate() async {
    var result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => FormMahasiswa()));
    if (result == 'save') {
      await _getAllMahasiswa();
    }
  }

  //membuka halaman edit Mahasiswa
  Future<void> _openFormEdit(Mahasiswa mahasiswa) async {
    var result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => FormMahasiswa(mahasiswa: mahasiswa)));
    if (result == 'update') {
      await _getAllMahasiswa();
    }
  }
}
