import 'dart:convert';

import 'package:core/core.dart';
import 'package:core/presentation/widgets/income_tail_card.dart';
import 'package:core/utils/format_currency.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../widgets/back_button.dart';
import '../widgets/custom_header_app.dart';

class DetailIncomePage extends StatefulWidget {
  static const routeName = '/detail_income_page';
  const DetailIncomePage({super.key});

  @override
  State<DetailIncomePage> createState() => _DetailIncomePageState();
}

class _DetailIncomePageState extends State<DetailIncomePage> {
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
  void initState() {
    fetchUserTransaction();
    super.initState();
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
                  "Income overview",
                  style: kHeading6.copyWith(color: kWhite),
                ),
                const SizedBox(width: 20)
              ],
            ),
          ),
        );

    buildCardIncome(data) {
      final income = [];
      for (var e in data) {
        if (e['type'] == 'income') {
          income.add(e['amount']);
        }
      }
      final totalIncome =
          income.length >= 2 ? income.reduce((a, b) => a + b) : income.first;

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
            color: kGreen,
            borderRadius: BorderRadius.circular(14),
            image: const DecorationImage(
              image: AssetImage('assets/income_card.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        '+ ${income.length} Pemasukkan',
                        style: kHeading5.copyWith(
                          fontSize: 30,
                          color: kWhite,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Kamu mendapatkan pemasukan sebesar : ",
                        style: kSubtitle.copyWith(color: kWhite),
                      ),
                      Text(
                        "+ ${formatCurrency.format(totalIncome)} ",
                        style: kSubtitle.copyWith(color: kWhite, fontSize: 30),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
              ],
            ),
          ),
        ),
      );
    }

    buildListIncome(data) {
      var income = [];
      for (var e in data) {
        if (e['type'] == 'income') {
          income.add(e);
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
            Text("Daftar Pemasukkan Kamu ", style: kHeading5),
            const SizedBox(height: 15),
            ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: income.length,
              itemBuilder: (context, index) {
                return IncomeTailCard(
                  iconPath: 'assets/icon_up.png',
                  color: kSoftGreen,
                  category: income[index]['category'],
                  amount: formatCurrency.format(income[index]['amount']),
                  date: income[index]['incomeDate'],
                  label: '+',
                  currencyColor: kGreen,
                  title: income[index]['title'],
                );
              },
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          const BackgroundHeader(height: 0.15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildAppBar(),
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
                            buildCardIncome(data),
                            buildListIncome(data),
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
