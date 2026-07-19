// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Fishing Manager';

  @override
  String get changeTheme => 'Change Theme';

  @override
  String get home => 'Home';

  @override
  String get boats => 'Boats';

  @override
  String get noBoatFound => 'No Boat Data is Found';

  @override
  String get registrationNumber => 'Registratoin';

  @override
  String get captainShare => 'Captain Share';

  @override
  String get addBoat => 'Add Boat';

  @override
  String get boatName => 'Boat Name';

  @override
  String get editBoat => 'Edit Boat';

  @override
  String get enterBoatName => 'Enter Boat Name';

  @override
  String get enterRegistrationNumber => 'Enter Registation Number';

  @override
  String get enterCaptainShare => 'Enter Captain Share';

  @override
  String get enterValidCaptainShare => 'Enter Valid Number Between 0 and 100';

  @override
  String get enterPositiveNumber => 'Enter Positive Number';

  @override
  String get save => 'Save';

  @override
  String get update => 'Update';

  @override
  String get error => 'error';

  @override
  String get failedToSave => 'Failed to Save';

  @override
  String get succeeded => 'Succeeded';

  @override
  String get deleteConfirmation => 'Delete Confirmation';

  @override
  String get areSuretoDelete =>
      'Are You Sure You Want to Permanently Delete The Boat?';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';
}
