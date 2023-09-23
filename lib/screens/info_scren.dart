import 'package:flutter/material.dart';
import 'package:money_app/utils/calculator.dart';
import 'package:money_app/utils/extention.dart';
import 'package:money_app/widgets/bar_chart_widget.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  Widget build(BuildContext context) {
    print(ScreenSize(context).screenWidth);
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.infinity,
          
          child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 15,
                      right: 15,
                      left: 5,
                    ),
                    child: Text('مدیریت تراکنش ها به تومان',
                        style:
                            TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  ),
                ],
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
              const SizedBox(height: 50),
              SizedBox(
                height: ScreenSize(context).screenHeight*0.5,
                child: BarChartWidget(
                    fontsizeText: ScreenSize(context).screenWidth < 903.6 ? 9 : ScreenSize(context).screenWidth * 0.01
),
              )
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
