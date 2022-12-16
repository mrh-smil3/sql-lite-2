// ignore_for_file: file_names, unnecessary_this, prefer_collection_literals

class Mahasiswa {
  int? id;
  String? name;
  String? nim;
  String? prodi;
  String? fakultas;

  Mahasiswa({this.id, this.name, this.nim, this.prodi, this.fakultas});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    if (id != null) {
      map['id'] = id;
    }
    map['name'] = name;
    map['nim'] = nim;
    map['prodi'] = prodi;
    map['fakultas'] = fakultas;

    return map;
  }

  Mahasiswa.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.name = map['name'];
    this.nim = map['nim'];
    this.prodi = map['prodi'];
    this.fakultas = map['fakultas'];
  }
}
