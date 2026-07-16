// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appName => 'إدارة القوارب';

  @override
  String get changeTheme => 'تغيير المظهر';

  @override
  String get home => 'الرئيسية';

  @override
  String get boats => 'القوارب';

  @override
  String get registrationNumber => 'رقم التسجيل';

  @override
  String get captainShare => 'نسبة النوخذة';

  @override
  String get addBoat => 'أضف قارب';

  @override
  String get boatName => 'اسم القارب';

  @override
  String get editBoat => 'تعديل القارب';

  @override
  String get enterBoatName => 'يرجى إدخال اسم القارب';

  @override
  String get enterRegistrationNumber => 'ادخل رقم التسجيل';

  @override
  String get enterCaptainShare => 'ادخل نسبة النوخذة';

  @override
  String get enterValidCaptainShare => 'Enter Valid Number Between 0 and 100';

  @override
  String get enterPositiveNumber => 'ادخل رقم موجب';

  @override
  String get save => 'حفظ';

  @override
  String get update => 'تحديث';

  @override
  String get error => 'خطاء';

  @override
  String get failedToSave => 'فشل في الحفظ';

  @override
  String get succeeded => 'نجح';
}
