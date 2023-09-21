import 'package:hive/hive.dart';
import 'package:money_app/models/money.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

//!
Box<Money> hiveBox = Hive.box<Money>('moneybox');
//!
String year = Jalali.now().year.toString();
String month = (Jalali.now().month.toString()).length == 1
    ? '0${Jalali.now().month.toString()}'
    : Jalali.now().month.toString();
String day = (Jalali.now().day.toString()).length == 1
    ? '0${Jalali.now().day.toString()}'
    : Jalali.now().day.toString();

//!
class Calculate {
  static today() {
    return '$year/$month/$day';
  }

  static double pToday() {  //? Pay Today
    double result = 0;
    for (var value in hiveBox.values) {
      if (value.date == today() && value.isRecieved == false) {
        result += double.parse(value.price);
      }
    }
    return result;
  }

  static double bToday() {  //? Recive Today
    double result = 0;
    for (var value in hiveBox.values) {
      if (value.date == today() && value.isRecieved) {
        result += double.parse(value.price);
      }
    }
    return result;
  }
  static double pMonth() {  //?Pay Month
    double result = 0;
    for (var value in hiveBox.values) {
      if (value.date.substring(0,7) == '$year/$month' && value.isRecieved == false) {
        result += double.parse(value.price);
      }
    }
    return result;
  }

  static double bMonth() {  //? Recive Month
    double result = 0;
    for (var value in hiveBox.values) {
      if (value.date.substring(0,7) == '$year/$month' && value.isRecieved) {
        result += double.parse(value.price);
      }
    }
    return result;
  }
  static double pYear() {  //?Pay Year
    double result = 0;
    for (var value in hiveBox.values) {
      if (value.date.substring(0,4) == year && value.isRecieved == false) {
        result += double.parse(value.price);
      }
    }
    return result;
  }

  static double bYear() {  //? Recive Year
    double result = 0;
    for (var value in hiveBox.values) {
      if (value.date.substring(0,4) == year && value.isRecieved) {
        result += double.parse(value.price);
      }
    }
    return result;
  }
}
