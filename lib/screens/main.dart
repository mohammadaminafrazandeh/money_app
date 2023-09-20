
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_app/models/money.dart';
import 'package:money_app/screens/home_screen.dart';
import 'package:money_app/screens/main_screen.dart';


void main() async {
  await Hive.initFlutter(); //? prepration for path
  Hive.registerAdapter(MoneyAdapter()); //? register model
  await Hive.openBox<Money>('moneybox'); //? opening the box
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static void getData() {
    //? defining a method to reading and getting data
    HomeScreen.moneys.clear();
    Box<Money> hiveBox = Hive.box<Money>('moneybox');
    for (var value in hiveBox.values) {
      HomeScreen.moneys.add(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'iransans'),
      debugShowCheckedModeBanner: false,
      title: 'اپیکیشن مدیریت مالی',
      home: const MainScreen(),
    );
  }
}
