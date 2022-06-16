class Kategori {
  int? kategoriID;
  late String kategoriBaslik;

  Kategori(
      this.kategoriBaslik); // kategori eklereken, // isimlendirilmiş constructor
  Kategori.withID(this.kategoriID,
      this.kategoriBaslik); // kategorileri okurken, // isimlendirilmiş constructor

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map['kategoriID'] = kategoriID;
    map['kategoriBaslik'] = kategoriBaslik;
    return map;
  }

  Kategori.fromMap(Map<String, dynamic> map) {
    // isimlendirilmiş constructor, kategorileri çekip objeye dönüştürürken
    kategoriID = map['kategoriID'];
    kategoriBaslik = map['kategoriBaslik'];
  }

  @override
  String toString() {
    return 'Kategori{kategoriID: $kategoriID, kategoriBaslik: $kategoriBaslik}';
  }
}
