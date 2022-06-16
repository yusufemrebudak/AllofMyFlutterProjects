import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class Translationhelper {
  Translationhelper._(); // nesne üretilmemesi için
  static getDeviceLanguage(BuildContext context) {
    var _deviceLanguage = context.deviceLocale.countryCode!.toLowerCase();
    switch (_deviceLanguage) {
      case 'tr':
        return LocaleType.tr;
        break;
        case 'en':
        return LocaleType.en;
        break;
      default:
    }
    
  }
}
