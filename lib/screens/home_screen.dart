import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:money_app/consts/constant.dart';
import 'package:searchbar_animation/searchbar_animation.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../models/money.dart';
import 'main.dart';
import 'new_transactions_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static List<Money> moneys = [];

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchController = TextEditingController();
  Box<Money> hiveBox = Hive.box<Money>('moneybox');
//------------------
  @override
  void initState() {
    MyApp.getData();
    super.initState();
  }
//------------------

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: fabWidget(),
        body: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              headerWidget(),
              Expanded(
                child: HomeScreen.moneys.isEmpty
                    ? const EmptyWidget()
                    : ListView.builder(
                        itemCount: HomeScreen.moneys.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            //* Edit----------------------------------------------------------
                            onTap: () {
                              NewTransActionScreen.decriptionController.text =
                                  HomeScreen.moneys[index].title;
                              //
                              NewTransActionScreen.priceController.text =
                                  HomeScreen.moneys[index].price;
                              //
                              NewTransActionScreen.groupId =
                                  HomeScreen.moneys[index].isRecieved ? 1 : 2;
                              //
                              NewTransActionScreen.isEditing = true;
                              //
                              NewTransActionScreen.id =
                                  HomeScreen.moneys[index].id;
                              //
                              NewTransActionScreen.date =
                                  HomeScreen.moneys[index].date;
                              //
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const NewTransActionScreen(),
                                ),
                              ).then((value) {
                                MyApp.getData();
                                setState(() {});
                              });
                            },

                            //! Delete---------------------------------------------------------
                            onLongPress: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        title: const Text(
                                            'آیا از حذف این آیتم مطمئن هستید',
                                            style: TextStyle(fontSize: 12),
                                            textAlign: TextAlign.center),
                                        actionsAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text('خیر',
                                                  style: TextStyle(
                                                      color: Colors.black54))),
                                          TextButton(
                                              onPressed: () {
                                                setState(() {
                                                  hiveBox.deleteAt(index);
                                                  MyApp.getData();
                                                  // HomeScre  en.moneys
                                                  //     .removeAt(index);
                                                  Navigator.pop(context);
                                                });
                                              },
                                              child: const Text('بله',
                                                  style: TextStyle(
                                                      color: Colors.black54)))
                                        ],
                                      ));
                            },
                            child: MyListTileWidget(
                              index: index,
                            ),
                          );
                        },
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }

  //!FAB widget++++++++++++++
  Widget fabWidget() {
    return FloatingActionButton(
      onPressed: () {
        NewTransActionScreen.decriptionController.text = '';
        NewTransActionScreen.priceController.text = '';
        NewTransActionScreen.groupId = 0;
        NewTransActionScreen.isEditing = false;
        NewTransActionScreen.date = 'تاریخ';
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const NewTransActionScreen(),
          ),
        ).then(
          (value) {
            MyApp.getData();
            setState(() {});
          },
        );
      },
      backgroundColor: kPurpleColor,
      elevation: 8,
      child: const Icon(Icons.add),
    );
  }

  //! Header widget++++++++++
  Widget headerWidget() {
    return Padding(
      padding: const EdgeInsets.only(right: 20, top: 20, left: 5),
      child: Row(
        children: [
          Expanded(
            child: SearchBarAnimation(
              hintText: 'جستجو کن',
              buttonElevation: 1,
              // buttonShadowColour: Colors.black26,
              // buttonBorderColour: Colors.black26,
              onFieldSubmitted: (String text) {
                List<Money> result = hiveBox.values
                    .where(
                      (value) =>
                          value.title.contains(text) ||
                          value.date.contains(text),
                    )
                    .toList();
                HomeScreen.moneys.clear();
                setState(() {
                  for (var value in result) {
                    HomeScreen.moneys.add(value);
                  }
                });
              },
              onCollapseComplete: () {
                MyApp.getData();
                searchController.text = '';
                setState(() {});
              },
              textEditingController: SearchController(),
              isOriginalAnimation: false,
              trailingWidget: const Icon(
                Icons.search,
                size: 20,
                color: Colors.black,
              ),
              secondaryButtonWidget: const Icon(
                Icons.close,
                size: 20,
                color: Colors.black,
              ),
              buttonWidget: const Icon(
                Icons.search,
                size: 20,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          const Text('تراکنش ها'),
        ],
      ),
    );
  }
}

//! My List Title
class MyListTileWidget extends StatelessWidget {
  final int index;

  const MyListTileWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color:
                  HomeScreen.moneys[index].isRecieved ? kGreenColor : kRedColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
                child: Icon(
              HomeScreen.moneys[index].isRecieved ? Icons.add : Icons.remove,
              color: Colors.white,
            )),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            //* title shown --------------------------------------
            child: Text(HomeScreen.moneys[index].title),
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  Text(
                    'تومان',
                    style: TextStyle(
                        fontSize: 14,
                        color: HomeScreen.moneys[index].isRecieved
                            ? kGreenColor
                            : kRedColor),
                  ),
                  //* price shown ---------------------------------
                  Text(
                    HomeScreen.moneys[index].price,
                    style: TextStyle(
                        fontSize: 14,
                        color: HomeScreen.moneys[index].isRecieved
                            ? kGreenColor
                            : kRedColor),
                  ),
                ],
              ),
              Text(HomeScreen.moneys[index].date)
            ],
          )
        ],
      ),
    );
  }
}

//! empty
class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        SvgPicture.asset(
          'assets/images/finance.svg',
          height: 200,
        ),
        const Text('! تراکنشی موجود نیست '),
        const Spacer(),
      ],
    );
  }
}
