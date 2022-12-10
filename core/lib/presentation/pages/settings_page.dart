import 'package:core/core.dart';
import 'package:core/presentation/widgets/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';

class SettingsPage extends StatefulWidget {
  static const routeName = '/settings_page';

  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool status = false;

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final dbRef = FirebaseDatabase.instance.ref('users/$uid').onValue;

    buildAppBar() => SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 25,
              horizontal: defaultMargin,
            ),
            child: Center(
              child: Text(
                "Pengaturan",
                style: kHeading6,
              ),
            ),
          ),
        );
    buildHeader(user) {
      return SafeArea(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      user['imageProfile'] == ''
                          ? const CircleAvatar(
                              radius: 36,
                              child: Text('No Image'),
                            )
                          : CircleAvatar(
                              radius: 36,
                              backgroundImage:
                                  NetworkImage(user['imageProfile']),
                            ),
                      CustomButton(
                        title: 'Edit Profil',
                        width: 100,
                        fontSize: 12,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditProfilePage(
                                user: user,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 13,
                  ),
                  Text(
                    user['name'],
                    style: kHeading6,
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(user['email'], style: kSubtitle),
                ],
              )));
    }

    buildList(user) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(13),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: kGrey,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(15))),
                child: Image.asset(
                  'assets/icon_darkmode.png',
                ),
              ),
              title: Text(
                'Tema Gelap',
                style: kHeading6,
              ),
              trailing: BlocBuilder<ThemeBloc, bool>(
                builder: (context, state) {
                  return SizedBox(
                    width: 100,
                    child: FlutterSwitch(
                      width: 105.0,
                      height: 40.0,
                      valueFontSize: 18.0,
                      toggleSize: 35.0,
                      value: state,
                      borderRadius: 30.0,
                      padding: 8.0,
                      showOnOff: true,
                      activeIcon: const Icon(Icons.sunny),
                      inactiveColor: kGrey,
                      activeColor: kGreen,
                      onToggle: (val) {
                        BlocProvider.of<ThemeBloc>(context)
                            .toggleTheme(value: val);
                      },
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 33,
            ),
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
              child: ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(13),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: kGrey,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15))),
                    child: Image.asset(
                      'assets/balance.png',
                    ),
                  ),
                  title: Text(
                    'Ubah Saldo',
                    style: kHeading6,
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 20,
                  )),
            ),
            const SizedBox(
              height: 33,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ExportDataPage(
                      user: user,
                    ),
                  ),
                );
              },
              child: ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(13),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: kGrey,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15))),
                    child: Image.asset(
                      'assets/icon_export.png',
                    ),
                  ),
                  title: Text(
                    'Ekspor Data',
                    style: kHeading6,
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 20,
                  )),
            ),
            const SizedBox(
              height: 33,
            ),
            ListTile(
              onTap: () {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      title: Text(
                        "Keluar",
                        style: kHeading7.copyWith(fontSize: 18, color: kGreen),
                        textAlign: TextAlign.center,
                      ),
                      content: SizedBox(
                        height: 50,
                        child: Text(
                          "Apakah anda yakin ingin keluar ?",
                          style: kHeading7.copyWith(fontSize: 16),
                        ),
                      ),
                      actions: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 36.0,
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  color: kGreen),
                              child: TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Batal',
                                      style: kHeading7.copyWith(
                                          fontSize: 16, color: kWhite))),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 36.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  color: kRed),
                              child: TextButton(
                                  onPressed: () =>
                                      BlocProvider.of<AuthBloc>(context)
                                          .add(LogOutRequested()),
                                  child: Text('Keluar',
                                      style: kHeading7.copyWith(
                                          fontSize: 16,
                                          color: kWhite))), //belum
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                );
              },
              leading: Container(
                padding: const EdgeInsets.all(13),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: kGrey,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(15))),
                child: Image.asset(
                  'assets/logout.png',
                ),
              ),
              title: Text(
                'Keluar',
                style: kHeading6,
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 20,
              ),
            )
          ],
        ),
      );
    }

    return Scaffold(
      body: MultiBlocListener(
        listeners: [
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is UnAuthenticated) {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                  (route) => false,
                );
              }
            },
          ),
          BlocListener<DatabaseBloc, DatabaseState>(
            listener: (context, state) {
              if (state is DatabaseSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Success mengedit profile')));
              }
            },
          )
        ],
        child: StreamBuilder<dynamic>(
            stream: dbRef,
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Column(
                  children: const [
                    Spacer(),
                    Text('Loading data...'),
                    Spacer(),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: LinearProgressIndicator(backgroundColor: kGrey),
                    ),
                  ],
                );
              }
              final result = snapshot.data;
              final user = result.snapshot.value;
              return snapshot.hasData
                  ? Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildAppBar(),
                            Expanded(
                                child: SizedBox(
                              child: ListView(
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                children: [buildHeader(user), buildList(user)],
                              ),
                            ))
                          ],
                        ),
                      ],
                    )
                  : const Center(
                      child: Text('Loading...'),
                    );
            }),
      ),
    );
  }
}
