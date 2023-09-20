import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:money_app/consts/constant.dart';
import 'package:money_app/models/money.dart';
import 'package:money_app/screens/main.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:fl_chart/fl_chart.dart';

class NewTransActionScreen extends StatefulWidget {
  const NewTransActionScreen({super.key});
  static int groupId = 0;
  static TextEditingController decriptionController = TextEditingController();
  static TextEditingController priceController = TextEditingController();
  static bool isEditing = false;
  static int id = 0;
  static String date = 'تاریخ';

  @override
  State<NewTransActionScreen> createState() => _NewTransActionScreenState();
}

class _NewTransActionScreenState extends State<NewTransActionScreen> {
  Box<Money> hiveBox =
      Hive.box<Money>('moneybox'); //? definin box to a variable
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          padding: const EdgeInsets.all(15),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                NewTransActionScreen.isEditing
                    ? 'ویرایش تراکنش'
                    : 'تراکنش جدید',
                style: const TextStyle(fontSize: 18),
              ),
              MyTextField(
                hintext: 'توضیحات',
                controller: NewTransActionScreen.decriptionController,
              ),
              MyTextField(
                hintext: 'مبلغ',
                type: TextInputType.number,
                controller: NewTransActionScreen.priceController,
              ),
              const MyTypeAndDateWidget(),
              MyButton(
                text: NewTransActionScreen.isEditing
                    ? 'ویرایش کردن'
                    : 'اضافه کردن',
                onPressed: () {
                  Money item = Money(
                    id: Random().nextInt(9999),
                    title: NewTransActionScreen.decriptionController.text,
                    price: NewTransActionScreen.priceController.text,
                    date: NewTransActionScreen.date,
                    isRecieved:
                        NewTransActionScreen.groupId == 1 ? true : false,
                  );
                  if (NewTransActionScreen.isEditing) {
                    //!   Editting
                    // HomeScreen.moneys[NewTransActionScreen.index] = item;
                    int index = 0;
                    MyApp.getData();
                    for (int i = 0; i < hiveBox.length; i++) {
                      if (hiveBox.values.elementAt(i).id ==
                          NewTransActionScreen.id) {
                        index = i;
                      }
                    }
                    hiveBox.putAt(index, item);
                  } else {
                    //!   Adding
                    // HomeScreen.moneys.add(item);
                    hiveBox.add(item);
                  }
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//! My Button
class MyButton extends StatelessWidget {
  final String text;
  final Function() onPressed;

  const MyButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: kPurpleColor,
        ),
        child: Text(text),
      ),
    );
  }
}

//! My Type And Date Widget
class MyTypeAndDateWidget extends StatefulWidget {
  const MyTypeAndDateWidget({
    super.key,
  });

  @override
  State<MyTypeAndDateWidget> createState() => _MyTypeAndDateWidgetState();
}

class _MyTypeAndDateWidgetState extends State<MyTypeAndDateWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: MyRadioButton(
                value: 1,
                groupValue: NewTransActionScreen.groupId,
                onChanged: (value) {
                  setState(() {
                    NewTransActionScreen.groupId = value!;
                  });
                },
                text: 'دریافتی'),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: MyRadioButton(
                value: 2,
                groupValue: NewTransActionScreen.groupId,
                onChanged: (value) {
                  setState(() {
                    NewTransActionScreen.groupId = value!;
                  });
                },
                text: 'پرداختی'),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: OutlinedButton(
              onPressed: () async {
                var pickedDate = await showPersianDatePicker(
                    context: context,
                    initialDate: Jalali.now(),
                    firstDate: Jalali(1402),
                    lastDate: Jalali(1499));
                setState(() {
                  String year = pickedDate!.year.toString();
                  //
                  String month = (pickedDate.month.toString()).length == 1
                      ? '0${pickedDate.month.toString()}'
                      : pickedDate.month.toString();
                  //
                  String day = (pickedDate.day.toString()).length == 1
                      ? '0${pickedDate.day.toString()}'
                      : pickedDate.day.toString();
                  //
                  NewTransActionScreen.date = '$year/$month/$day';
                });
              },
              child: Expanded(
                child: Text(
                  NewTransActionScreen.date,
                  style: const TextStyle(color: Colors.black, fontSize: 12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//! My Radio Button
class MyRadioButton extends StatelessWidget {
  final int value;
  final int groupValue;
  final Function(int?) onChanged;
  final String text;

  const MyRadioButton(
      {super.key,
      required this.value,
      required this.groupValue,
      required this.onChanged,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Radio(
              value: value,
              groupValue: groupValue,
              onChanged: onChanged,
              activeColor: kPurpleColor),
        ),
        Text(text),
      ],
    );
  }
}

//! My Text Field
class MyTextField extends StatelessWidget {
  final String hintext;
  final TextInputType type;
  final TextEditingController controller;

  const MyTextField({
    super.key,
    required this.hintext,
    this.type = TextInputType.text,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: type,
      cursorColor: Colors.black38,
      decoration: InputDecoration(
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.shade300,
            ),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.shade300,
            ),
          ),
          hintText: hintext),
    );
  }
}
