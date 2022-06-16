class Not {
  int? notID;
  late int kategoriID;
  String? kategoriBaslik;
  late String notBaslik;
  String? notIcerik;
  String? notTarih;
  late int notOncelik;
  Not(
    this.kategoriID,
    this.notBaslik,
    this.notIcerik,
    this.notTarih,
    this.notOncelik,
  );
  Not.withID(
    // okurken
    this.notID,
    this.kategoriID,
    this.notBaslik,
    this.notIcerik,
    this.notTarih,
    this.notOncelik,
  );
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['notID'] = notID;
    map['kategoriID'] = kategoriID;
    map['notBaslik'] = notBaslik;
    map['notIcerik'] = notIcerik;
    map['notTarih'] = notTarih;
    map['notOncelik'] = notOncelik;
    return map;
  }

  Not.fromMap(Map<String, dynamic> map) {
    notID = map['notID'];
    kategoriID = map['kategoriID'];
    kategoriBaslik = map['kategoriBaslik'];
    notBaslik = map['notBaslik'];
    notIcerik = map['notIcerik'];
    notTarih = map['notTarih'];
    notOncelik = map['notOncelik'];
  }
  @override
  String toString() {
   
    return 'Not{notID: $notID, kategoriID: $kategoriID, notBaslik: $notBaslik, notIcerik: $notIcerik, notTarih: $notTarih, notOncelik: $notOncelik}';
  }
}
