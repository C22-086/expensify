import 'package:core/core.dart';
import 'package:core/presentation/widgets/income_tail_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../widgets/custom_add_card.dart';
import '../widgets/custome_overview_card.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final dbRef = FirebaseDatabase.instance.ref('users/$uid').once();

    final pageController = PageController(
      viewportFraction: 0.8,
      keepPage: true,
    );
    // final ref = FirebaseDatabase.instance.ref('transactions/$uid');

    // Future<int> getTransactionSum() async {
    //   final getAllKey = await ref.get();

    //   if (getAllKey.exists) {
    //     final allKey = getAllKey.children.toList();
    //     final allKeyLength = allKey.length;
    //     for (int i = 0; i < allKeyLength; i++) {

    //     }
    //   }
    // }

    List cardItem = [
      Padding(
        padding: const EdgeInsets.only(left: 20, right: 15),
        child: OverviewCard(
          titleImageUrl: 'assets/icon-trending-up.png',
          color: kGreen,
          secColor: kSoftGreen,
          title: 'Income',
          label: "+",
          amount: 400,
          subMinPercent: "30% Pemasukan",
          subMaxPercent: "70% Pengeluaran",
          valueChartOne: 70,
          valueChartTwo: 30,
          chartOneTitle: "70%",
          chartTwoTitle: "30%",
          onTap: () {
            Navigator.pushNamed(
              context,
              DetailIncomePage.routeName,
            );
          },
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 20),
        child: OverviewCard(
          titleImageUrl: 'assets/icon-trending-down.png',
          color: kRed,
          secColor: kSoftRed,
          title: 'Expense',
          label: "-",
          amount: 700,
          subMinPercent: "30% from tranfer",
          subMaxPercent: "70% from salary",
          valueChartOne: 65,
          valueChartTwo: 35,
          chartOneTitle: "65%",
          chartTwoTitle: "35%",
          onTap: () {
            Navigator.pushNamed(
              context,
              DetailExpensePage.routeName,
            );
          },
        ),
      ),
    ];

    buildHeader(user) {
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: defaultMargin,
            vertical: 25,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello, ${user['name']}',
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      color: kWhite,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Image.asset(
                        'assets/icon_wallet.png',
                        scale: 2.5,
                        color: kWhite,
                      ),
                      const SizedBox(width: 9),
                      Text(
                        'Balance',
                        style: kHeading7.copyWith(color: kWhite),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Rp. ${user['balance']}',
                    style: kHeading6.copyWith(color: kWhite, fontSize: 22),
                  ),
                  const SizedBox(height: 10),
                  InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (_) {
                            return AlertDialog(
                              content: const Text(
                                  'Dengan melanjutkan pengubahan saldo kamu saat ini, kamu akan mereset semua transaksi yang sudah ada'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Batal')),
                                TextButton(
                                    onPressed: () async {
                                      final ref = FirebaseDatabase.instance
                                          .ref('transaction/$uid');
                                      await ref.remove();
                                      if (!mounted) return;
                                      Navigator.pushNamed(
                                          context, SetBalancePage.routeName);
                                    },
                                    child: const Text('Lanjutkan'))
                              ],
                            );
                          });
                    },
                    child: Chip(
                      backgroundColor: Colors.transparent,
                      labelStyle: GoogleFonts.poppins(
                        fontSize: 12,
                      ),
                      label: const Text('Ubah saldo'),
                    ),
                  )
                ],
              ),
              user['imageProfile'] == ''
                  ? CircleAvatar(
                      radius: 40,
                      backgroundColor: kWhite,
                      child: CircleAvatar(
                        radius: 35,
                        child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Text(
                              'No Image',
                              style: kSubtitle.copyWith(fontSize: 10),
                              textAlign: TextAlign.center,
                            )),
                      ),
                    )
                  : CircleAvatar(
                      radius: 36,
                      backgroundImage: NetworkImage(user['imageProfile']),
                    ),
            ],
          ),
        ),
      );
    }

    buildCard(user) {
      return Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 15,
            ),
            height: 195,
            width: double.infinity,
            child: PageView.builder(
              padEnds: false,
              controller: pageController,
              physics: const BouncingScrollPhysics(),
              itemCount: cardItem.length,
              itemBuilder: (context, index) {
                return cardItem[index];
              },
            ),
          ),
          const SizedBox(height: 10),
          SmoothPageIndicator(
            controller: pageController,
            count: cardItem.length,
            effect: CustomizableEffect(
              activeDotDecoration: DotDecoration(
                width: 35,
                height: 8,
                color: kGreen,
                borderRadius: BorderRadius.circular(24),
              ),
              dotDecoration: DotDecoration(
                width: 15,
                height: 8,
                color: kSoftGreen,
                borderRadius: BorderRadius.circular(16),
                verticalOffset: 0,
              ),
              spacing: 6.0,
            ),
          ),
        ],
      );
    }

    buildMainFuture(user) {
      return Padding(
        padding: EdgeInsets.only(
          left: defaultMargin,
          right: defaultMargin,
          top: height * 0.03,
        ),
        child: Row(
          children: [
            Expanded(
                child: AddCard(
              iconPath: 'assets/icon_income.png',
              subtitle: 'Income',
              textColor: kGreen,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddIncomePage(
                      user: user,
                    ),
                  ),
                );
              },
            )),
            const SizedBox(width: 20),
            Expanded(
              child: AddCard(
                iconPath: 'assets/icon_expense.png',
                subtitle: 'Expense',
                textColor: kRed,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddExpensePage(
                        user: user,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
    }

    Widget buildContent() {
      return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: defaultMargin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StreamBuilder(
              stream: FirebaseDatabase.instance.ref('transaction/$uid').onValue,
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  if (snapshot.hasError) {
                    return const Center(
                        child: Text('Kamu belum melakukan transaksi'));
                  } else if (snapshot.hasData) {
                    Map<dynamic, dynamic> transaction =
                        snapshot.data.snapshot.value == null
                            ? {}
                            : snapshot.data!.snapshot!.value;

                    List<dynamic> list = transaction.values.toList();

                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (_) {
                                  return AlertDialog(
                                    title: const Text('Detail '),
                                    content: SizedBox(
                                      height: 100,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              'Nominal \t\t:${list[index]['nominal']}'),
                                          Text(
                                              'Category \t:${list[index]['category']}'),
                                          Text(
                                              'Catatan \t\t:${list[index]['note']}')
                                        ],
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          // FirebaseDatabase.instance
                                          //     .ref('transaction/$uid')
                                          //     .child(list[index].key.)
                                          //     .remove();
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Delete'),
                                      ),
                                    ],
                                  );
                                });
                          },
                          child: IncomeTailCard(
                            iconPath: list[index].keys.contains('incomeId')
                                ? 'assets/icon_up.png'
                                : 'assets/icon_down.png',
                            color: list[index].keys.contains('incomeId')
                                ? kSoftGreen
                                : kSoftRed,
                            category: list[index]['category'],
                            nominal: list[index]['nominal'],
                            date: list[index].keys.contains('incomeId')
                                ? list[index]['incomeDate'].split(' ')[0]
                                : list[index]['expanseDate'].split(' ')[0],
                            label: list[index].keys.contains('incomeId')
                                ? '+'
                                : '-',
                            currencyColor: list[index].keys.contains('incomeId')
                                ? kGreen
                                : kRed,
                          ),
                        );
                      },
                    );
                  } else {
                    return const Text('data kosong');
                  }
                }
              },
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is UnAuthenticated) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const LoginPage()),
              (route) => false,
            );
          }
        },
        child: FutureBuilder(
          future: dbRef,
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: Text('Loading...'),
              );
            }
            final result = snapshot.data;
            final user = result.snapshot.value;
            return snapshot.hasData
                ? CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    slivers: [
                      SliverAppBar(
                        floating: true,
                        snap: true,
                        stretch: true,
                        elevation: 0,
                        leading: Container(),
                        bottom: const PreferredSize(
                          preferredSize: Size.fromHeight(155),
                          child: SizedBox(),
                        ),
                        flexibleSpace: FlexibleSpaceBar(
                          background: Container(
                            decoration: const BoxDecoration(
                              color: kGreen,
                              image: DecorationImage(
                                image: AssetImage('assets/green_substract.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: buildHeader(user),
                          ),
                        ),
                      ),
                      SliverList(
                        delegate: SliverChildListDelegate([
                          buildCard(user),
                          buildMainFuture(user),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 20,
                            ),
                            child: Text(
                              "Recent Transaction",
                              style: kHeading5.copyWith(
                                color: kSoftBlack,
                              ),
                            ),
                          ),
                          buildContent(),
                        ]),
                      ),
                    ],
                  )
                : const Center(
                    child: Text('Loading...'),
                  );
          },
        ),
      ),
    );
  }
}
