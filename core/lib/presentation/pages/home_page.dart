import 'package:core/core.dart';
import 'package:core/domain/entities/chart_income.dart';
import 'package:core/presentation/widgets/income_tail_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../widgets/custom_add_card.dart';
import '../widgets/custome_overview_card.dart';
import '../widgets/no_overview_card.dart';

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
      viewportFraction: 0.85,
      keepPage: true,
    );

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

    buildCard(data) {
      return Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 20,
            ),
            height: 195,
            width: double.infinity,
            child: StreamBuilder<dynamic>(
              stream: FirebaseDatabase.instance
                  .ref()
                  .child('transaction/$uid')
                  .onValue,
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  if (snapshot.hasData) {
                    final Map<dynamic, dynamic> transactions =
                        snapshot.data.snapshot.value ?? {};
                    final listData = transactions.values.toList();

                    //get total income
                    final incomesAmount = [];
                    for (var e in listData) {
                      if (e['type'] == 'income') {
                        incomesAmount.add(e['amount']);
                      }
                    }
                    final totalIncome = incomesAmount.length >= 2
                        ? incomesAmount.reduce((a, b) => a + b)
                        : incomesAmount.isEmpty
                            ? 0
                            : incomesAmount.first;

                    //get all income
                    final List<ChartIncome> incomes = [];
                    for (var e in listData) {
                      if (e['type'] == 'income') {
                        incomes.add(ChartIncome.fromMap(e));
                      }
                    }
                    //get total Expanse
                    final expansesAmount = [];
                    for (var e in listData) {
                      if (e['type'] == 'expanse') {
                        expansesAmount.add(e['amount']);
                      }
                    }
                    final totalExpanse = expansesAmount.length >= 2
                        ? expansesAmount.reduce((a, b) => a + b)
                        : expansesAmount.isEmpty
                            ? 0
                            : expansesAmount.first;

                    //get all expanses
                    final List<ChartIncome> expanses = [];
                    for (var e in listData) {
                      if (e['type'] == 'expanse') {
                        expanses.add(ChartIncome.fromMap(e));
                      }
                    }
                    return PageView(
                      padEnds: false,
                      controller: pageController,
                      physics: const BouncingScrollPhysics(),
                      children: [
                        incomes.isEmpty
                            ? const NoOverviewCard(
                                title: 'pemasukkan',
                              )
                            : OverviewCard(
                                titleImageUrl: 'assets/icon-trending-up.png',
                                color: kGreen,
                                secColor: kSoftGreen,
                                title: 'Income',
                                label: "+",
                                chart: SfCircularChart(
                                  tooltipBehavior: TooltipBehavior(
                                      enable: true,
                                      format: 'point.x : Rp. point.y'),
                                  series: [
                                    DoughnutSeries<ChartIncome, String>(
                                      explode: true,
                                      enableTooltip: true,
                                      dataSource: incomes,
                                      xValueMapper: (data, _) =>
                                          incomes[_].category,
                                      yValueMapper: (data, _) =>
                                          incomes[_].amount,
                                    )
                                  ],
                                ),
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    DetailIncomePage.routeName,
                                  );
                                },
                                total: '$totalIncome',
                              ),
                        expanses.isEmpty
                            ? const NoOverviewCard(title: 'pengeluaran')
                            : OverviewCard(
                                titleImageUrl: 'assets/icon-trending-down.png',
                                color: kRed,
                                secColor: kSoftGreen,
                                title: 'Expanse',
                                label: "-",
                                chart: expanses.isEmpty
                                    ? const NoOverviewCard(title: 'pengeluaran')
                                    : SfCircularChart(
                                        tooltipBehavior: TooltipBehavior(
                                            enable: true,
                                            format: 'point.x : Rp. point.y'),
                                        series: [
                                          DoughnutSeries<ChartIncome, String>(
                                            explode: true,
                                            enableTooltip: true,
                                            dataSource: expanses,
                                            xValueMapper: (data, _) =>
                                                expanses[_].category,
                                            yValueMapper: (data, _) =>
                                                expanses[_].amount,
                                          )
                                        ],
                                      ),
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    DetailExpensePage.routeName,
                                  );
                                },
                                total: '$totalExpanse',
                              )
                      ],
                    );
                  } else {
                    return PageView(
                      padEnds: false,
                      controller: pageController,
                      physics: const BouncingScrollPhysics(),
                      children: const [
                        NoOverviewCard(title: ''),
                      ],
                    );
                  }
                }
              },
            ),
          ),
          const SizedBox(height: 10),
          SmoothPageIndicator(
            controller: pageController,
            count: 2,
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
                                              'Nominal \t\t:${list[index]['amount']}'),
                                          Text(
                                              'Category \t:${list[index]['category']}'),
                                          Text(
                                              'Nama \t\t\t:${list[index]['title']}')
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
                                        onPressed: () async {
                                          await FirebaseDatabase.instance
                                              .ref('transaction/$uid')
                                              .child(
                                                  list[index]['transactionId'])
                                              .remove();
                                          if (!mounted) return;
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Delete'),
                                      ),
                                    ],
                                  );
                                });
                          },
                          child: IncomeTailCard(
                            iconPath: list[index]['type'].contains('income')
                                ? 'assets/icon_up.png'
                                : 'assets/icon_down.png',
                            color: list[index]['type'].contains('income')
                                ? kSoftGreen
                                : kSoftRed,
                            category: list[index]['category'],
                            amount: list[index]['amount'],
                            date: list[index]['type'].contains('income')
                                ? list[index]['incomeDate'].split(' ')[0]
                                : list[index]['expanseDate'].split(' ')[0],
                            label: list[index]['type'].contains('income')
                                ? '+'
                                : '-',
                            currencyColor:
                                list[index]['type'] == 'income' ? kGreen : kRed,
                            title: list[index]['title'],
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
                                color: context.watch<ThemeBloc>().state
                                    ? kWhite
                                    : kSoftBlack,
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

  OverviewCard buildOverviewIncomeCart(
      totalIncome, List<ChartIncome> incomes, BuildContext context) {
    return OverviewCard(
      titleImageUrl: 'assets/icon-trending-up.png',
      color: kGreen,
      secColor: kSoftGreen,
      title: 'Income',
      label: "+ ",
      chart: incomes.isEmpty
          ? Container()
          : SfCircularChart(
              tooltipBehavior:
                  TooltipBehavior(enable: true, format: 'point.x : point.y'),
              series: [
                DoughnutSeries<ChartIncome, String>(
                  explode: true,
                  enableTooltip: true,
                  dataSource: incomes,
                  xValueMapper: (data, _) => incomes[_].category,
                  yValueMapper: (data, _) => incomes[_].amount,
                )
              ],
            ),
      onTap: () {
        Navigator.pushNamed(
          context,
          DetailIncomePage.routeName,
        );
      },
      total: '$totalIncome',
    );
  }
}
