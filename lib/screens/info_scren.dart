import 'package:flutter/material.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding:
                    EdgeInsets.only(top: 15, right: 15, left: 5, bottom: 50),
                child: Text('مدیریت تراکنش ها به تومان',
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              ),
              MoneyInfoWidget(
                firstText: 'پرداختی امروز',
                firstprice: '30',
                secondText: 'دریافتی امروز',
                secondprice: '10',
              ),
              MoneyInfoWidget(
                firstText: 'پرداختی این ماه',
                firstprice: '900',
                secondText: 'دریافتی این ماه',
                secondprice: '300',
              ),
              MoneyInfoWidget(
                firstText: 'پرداختی امسال',
                firstprice: '18000',
                secondText: 'دریافتی امسال',
                secondprice: '3600',
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
      padding: const EdgeInsets.only(right: 15, left: 5, top: 25, bottom: 70),
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
