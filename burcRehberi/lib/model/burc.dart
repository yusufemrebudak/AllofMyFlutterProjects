class Burc {
  final String _burcAdi;
  final String _burcTarihi;
  final String _burDetayi;
  final String _burcKucukResim;
  final String _burcBuyukResim;

  get burcAdi => this._burcAdi;
  get burcTarihi => this._burcTarihi;
  get burDetayi => this._burDetayi;
  get burcKucukResim => this._burcKucukResim;
  get burcBuyukResim => this._burcBuyukResim;

  Burc(this._burcAdi, this._burcTarihi, this._burDetayi, this._burcKucukResim,
      this._burcBuyukResim);
  @override
  String toString() {
    return '$_burcAdi - $_burcBuyukResim';
  }
}
