import 'package:flutter_storage/model/models.dart';

abstract class LocalStorageService {
  //soyut sınıf bu sınıf methodlarının içini yazamıyor ve nesne üretilemeyen sınıftır. 
  
  Future<void> verileriKaydet(UserInformation userInformation);

  Future<UserInformation> verileriOku();


}
