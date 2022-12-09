import 'dart:convert';

import 'package:core/core.dart';
import 'package:core/presentation/widgets/income_tail_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../widgets/back_button.dart';
import '../widgets/custom_category.dart';
import '../widgets/custom_header_app.dart';

class DetailExpensePage extends StatefulWidget {
  static const routeName = '/detail_expense_page';
  const DetailExpensePage({super.key});

  @override
  State<DetailExpensePage> createState() => _DetailExpensePageState();
}

class _DetailExpensePageState extends State<DetailExpensePage> {
  Future fetchUserTransaction() async {
    var transactions = [];
    try {
      final currentUserId = FirebaseAuth.instance.currentUser!.uid;
      final transactionRef =
          FirebaseDatabase.instance.ref('transaction/$currentUserId');
      final json = await transactionRef.orderByKey().get();
      final data = jsonDecode(jsonEncode(json.value)) as Map;
      data.forEach((key, value) {
        transactions.add(value);
      });
      return transactions;
    } catch (e) {
      return ServerFailure;
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    buildAppBar() => SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 25,
              horizontal: defaultMargin,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomBackButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Text(
                  "Expenses overview",
                  style: kHeading6.copyWith(color: kWhite),
                ),
                const SizedBox(width: 20)
              ],
            ),
          ),
        );

    buildCategory() => Padding(
          padding: EdgeInsets.only(
            left: defaultMargin,
            right: defaultMargin,
            top: height * 0.03,
            bottom: height * 0.01,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              CustomeCategory(
                index: 0,
                title: "Last Year",
                titleColor: kRed,
              ),
              CustomeCategory(
                index: 1,
                title: "Last Month",
                titleColor: kRed,
              ),
              CustomeCategory(
                index: 2,
                title: "Last Week",
                titleColor: kRed,
              ),
              CustomeCategory(
                index: 3,
                title: "Last Day",
                titleColor: kRed,
              ),
            ],
          ),
        );

    buildCardExpanses(data) {
      final expanses = [];

      if (data != null) {
        for (var e in data) {
          if (e['type'] == 'expanse') {
            expanses.add(e['amount']);
          }
        }
      }

      final totalExpanses = expanses.length > 1
          ? expanses.reduce(
              (a, b) => a + b,
            )
          : expanses.isNotEmpty
              ? expanses.first
              : 0;

      return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: defaultMargin,
        ),
        child: Container(
          height: 180,
          padding: const EdgeInsets.only(
            left: 20,
            top: 20,
            bottom: 20,
            right: 50,
          ),
          decoration: BoxDecoration(
            color: kDarkRed,
            borderRadius: BorderRadius.circular(14),
            image: const DecorationImage(
              image: AssetImage('assets/expense_card.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Text(
                    '- ${expanses.length} Pengeluaran',
                    style: kHeading5.copyWith(
                      fontSize: 30,
                      color: kWhite,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Pengeluaran kamu sebesar :",
                    style: kSubtitle.copyWith(color: kWhite),
                  ),
                  Text(
                    "Rp.-$totalExpanses",
                    textAlign: TextAlign.right,
                    style: kSubtitle.copyWith(
                      color: kWhite,
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 10),
            ],
          ),
        ),
      );
    }

    buildListExpanses(data) {
      var expanses = [];
      for (var e in data) {
        if (e['type'] == 'expanse') {
          expanses.add(e);
        }
      }
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: defaultMargin + 5,
          vertical: height * 0.03,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Daftar Pengeluaran Kamu", style: kHeading5),
            const SizedBox(height: 15),
            ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: expanses.length,
              itemBuilder: (context, index) {
                return IncomeTailCard(
                  iconPath: 'assets/icon_down.png',
                  color: kSoftRed,
                  category: expanses[index]['category'].toString(),
                  nominal: expanses[index]['nominal'],
                  date: expanses[index]['expanseDate'].split(' ')[0],
                  label: '-',
                  currencyColor: kRed,
                  title: expanses[index]['title'],
                );
              },
            )
          ],
        ),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          const BackgroundHeader(
            height: 0.15,
            imagePath: 'assets/red_substract.png',
            color: kDarkRed,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildAppBar(),
              buildCategory(),
              Expanded(
                child: FutureBuilder<dynamic>(
                    future: fetchUserTransaction(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snapshot.data == ServerFailure) {
                        return const Center(
                          child: Text('Data masih kosong'),
                        );
                      }

                      final data = snapshot.data;
                      return SizedBox(
                        child: ListView(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          children: [
                            buildCardExpanses(data),
                            buildListExpanses(data),
                          ],
                        ),
                      );
                    }),
              )
            ],
          ),
        ],
      ),
    );
  }
}
