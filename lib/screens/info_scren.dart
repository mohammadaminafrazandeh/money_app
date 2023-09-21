import 'package:flutter/material.dart';
import 'package:money_app/utils/calculator.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Padding(
                padding:
                    EdgeInsets.only(top: 15, right: 15, left: 5, bottom: 20),
                child: Text('مدیریت تراکنش ها به تومان',
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              ),
              MoneyInfoWidget(
                firstText: 'پرداختی امروز',
                firstprice: Calculate.bToday().toString(),
                secondText: 'دریافتی امروز',
                secondprice: Calculate.pToday().toString(),
              ),
              MoneyInfoWidget(
                firstText: 'پرداختی این ماه',
                firstprice: Calculate.pMonth().toString(),
                secondText: 'دریافتی این ماه',
                secondprice: Calculate.bMonth().toString(),
              ),
              MoneyInfoWidget(
                firstText: 'پرداختی امسال',
                firstprice: Calculate.pYear().toString(),
                secondText: 'دریافتی امسال',
                secondprice: Calculate.pYear().toString(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//! first row widget
class MoneyInfoWidget extends StatelessWidget {
  final String firstText;
  final String secondText;
  final String firstprice;
  final String secondprice;

  const MoneyInfoWidget({
    super.key,
    required this.firstText,
    required this.secondText,
    required this.firstprice,
    required this.secondprice,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15, left: 5, top: 25, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Text(
              secondprice,
              textAlign: TextAlign.right,
            ),
          )),
          const Text(':'),
          Text(secondText),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Text(
              firstprice,
              textAlign: TextAlign.right,
            ),
          )),
          const Text(':'),
          Text(firstText),
        ],
      ),
    );
  }
}
