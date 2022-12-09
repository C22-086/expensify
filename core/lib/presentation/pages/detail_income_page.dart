import 'dart:convert';

import 'package:core/core.dart';
import 'package:core/presentation/widgets/income_tail_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../widgets/back_button.dart';
import '../widgets/custom_category.dart';
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
      print(transactions);
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
              ),
              CustomeCategory(
                index: 1,
                title: "Last Month",
              ),
              CustomeCategory(
                index: 2,
                title: "Last Week",
              ),
              CustomeCategory(
                index: 3,
                title: "Last Day",
              ),
            ],
          ),
        );

    buildCardIncome(data) {
      final income = [];
      for (var e in data) {
        if (e['type'] == 'income') {
          income.add(e['nominal']);
        }
      }
      final totalIncome =
          income.length > 2 ? income.reduce((a, b) => a + b) : 0;

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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
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
                    "Rp.$totalIncome ",
                    style: kSubtitle.copyWith(color: kWhite, fontSize: 30),
                  ),
                ],
              ),
              const SizedBox(width: 10),
            ],
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
                  category: income[index]['category'].toString(),
                  nominal: data[index]['nominal'],
                  date: data[index]['incomeDate'].split(' ')[0],
                  label: '+',
                  currencyColor: kGreen,
                  title: income[index]['note'],
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
