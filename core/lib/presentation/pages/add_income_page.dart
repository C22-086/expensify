// ignore_for_file: depend_on_referenced_packages

import 'package:core/core.dart';
import 'package:core/presentation/widgets/form_input_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AddIncomePage extends StatefulWidget {
  static const routeName = '/add_income_page';

  final dynamic user;

  const AddIncomePage({super.key, required this.user});

  @override
  State<AddIncomePage> createState() => _AddIncomePageState();
}

class _AddIncomePageState extends State<AddIncomePage> {
  final TextEditingController _incomeTextController = TextEditingController();

  final TextEditingController _titleTextController = TextEditingController();

  final TextEditingController _dateController = TextEditingController();

  dynamic category;

  bool isButtonEnable = false;

  @override
  void initState() {
    super.initState();
    _dateController.text = "";
  }

  @override
  void dispose() {
    _incomeTextController.dispose();
    _titleTextController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  addIncome() async {
    final ref = FirebaseDatabase.instance
        .ref('users/${FirebaseAuth.instance.currentUser!.uid}');
    final snapshot = await FirebaseDatabase.instance
        .ref('users/${FirebaseAuth.instance.currentUser!.uid}')
        .child('balance')
        .get();
    if (snapshot.exists) {
      final balance = snapshot.value as int;
      ref.update({'balance': balance + int.parse(_incomeTextController.text)});
    }
    if (!mounted) return;

    BlocProvider.of<DatabaseBloc>(context).add(
      DatabasePushIncomeUser(
        name: widget.user['name'],
        uid: widget.user['uid'],
        category: category,
        amount: int.parse(_incomeTextController.text),
        title: _titleTextController.text,
        date: _dateController.text,
      ),
    );
    Navigator.pushReplacementNamed(context, MainPage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: buttonAddIncome(context),
      resizeToAvoidBottomInset: false,
      body: BlocListener<DatabaseBloc, DatabaseState>(
        listener: (context, state) {
          if (state is DatabaseSuccess) {
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Success menambah income')));
          }
          if (state is DatabaseError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        child: Stack(
          children: [
            Column(
              children: [
                buildHeader(context),
                Expanded(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height - 130,
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: buildBody(),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Container buttonAddIncome(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 16,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.watch<ThemeBloc>().state ? kDark : kWhite,
        boxShadow: const [
          BoxShadow(
            offset: Offset(3, 15),
            spreadRadius: -17,
            blurRadius: 49,
            color: Color.fromRGBO(139, 139, 139, 1),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Pemasukkan :'),
              const SizedBox(height: 5),
              Text(
                'Rp. +${_incomeTextController.text}',
                style: kHeading6.copyWith(fontSize: 24, color: kGreen),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: isButtonEnable ? addIncome : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: kGreen,
              padding: const EdgeInsets.all(14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: Text(
              'Tambahkan',
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: kWhite,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBody() {
    return BlocBuilder<ThemeBloc, bool>(
      builder: (context, state) {
        return Column(
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                ),
                child: Form(
                  onChanged: () {
                    if (_incomeTextController.text.isNotEmpty &&
                        _titleTextController.text.isNotEmpty &&
                        _dateController.text.isNotEmpty) {
                      setState(() {
                        isButtonEnable = true;
                      });
                    } else {
                      setState(() {
                        isButtonEnable = false;
                      });
                    }
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: [
                      FormInputData(
                        controller: _titleTextController,
                        chipLabel: 'Judul',
                        hintText: 'Tambahkan judul, contoh: Jual Motor',
                      ),
                      FormInputData(
                        controller: _incomeTextController,
                        chipLabel: 'Income',
                        hintText: 'Masukkan jumlah income',
                        keyboardType: TextInputType.number,
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 24),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),
                        decoration: BoxDecoration(
                          color: state ? kDark : kWhite,
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(3, 3),
                              spreadRadius: -10,
                              blurRadius: 49,
                              color: state
                                  ? kDark
                                  : const Color.fromARGB(255, 236, 236, 236),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Chip(
                              backgroundColor: Colors.transparent,
                              labelStyle: GoogleFonts.poppins(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: kGreen,
                              ),
                              shape: const RoundedRectangleBorder(
                                side: BorderSide(color: kGreen, width: 2),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30),
                                ),
                              ),
                              label: const Text('Kategori'),
                            ),
                            const SizedBox(height: 9),
                            DropdownButtonFormField(
                              icon: Container(
                                width: 40,
                                decoration: BoxDecoration(
                                  color: kGreen,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Icon(
                                  Icons.keyboard_arrow_down,
                                  color: kWhite,
                                ),
                              ),
                              hint: const Text('Pilih kategori'),
                              style: kHeading6.copyWith(
                                fontSize: 12,
                                color: state ? kWhite : kDark,
                              ),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                filled: true,
                                fillColor:
                                    state ? kSoftDark : const Color(0xffF7F8F8),
                              ),
                              items: const [
                                DropdownMenuItem(
                                  enabled: false,
                                  child: Text(
                                    'Pilih kategori',
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: 'Gaji',
                                  child: Text(
                                    'Gaji',
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: 'Penjualan Barang',
                                  child: Text(
                                    'Penjualan',
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: 'Tabungan',
                                  child: Text(
                                    'Tabungan',
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: 'Penerimaan Piutang',
                                  child: Text(
                                    'Penerimaan Piutang',
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: 'Komisi',
                                  child: Text(
                                    'Komisi',
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: 'Pendapatan Jasa',
                                  child: Text(
                                    'Pendapatan Jasa',
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: 'Pendapatan Bunga',
                                  child: Text(
                                    'Pendapatan Bunga',
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: 'Pendapatan Sewa',
                                  child: Text(
                                    'Pendapatan Sewa',
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: 'Pendapatan lain',
                                  child: Text(
                                    'Pendapatan lain',
                                  ),
                                ),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  category = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 24),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),
                        decoration: BoxDecoration(
                          color: state ? kDark : kWhite,
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(3, 3),
                              spreadRadius: -10,
                              blurRadius: 49,
                              color: state
                                  ? kDark
                                  : const Color.fromARGB(255, 236, 236, 236),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Chip(
                              backgroundColor: Colors.transparent,
                              labelStyle: GoogleFonts.poppins(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: kGreen,
                              ),
                              shape: const RoundedRectangleBorder(
                                side: BorderSide(color: kGreen, width: 2),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30),
                                ),
                              ),
                              label: const Text('Tanggal'),
                            ),
                            const SizedBox(height: 9),
                            TextFormField(
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return 'Tanggal tidak boleh kosong';
                                }
                                return null;
                              },
                              controller: _dateController,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.calendar_today,
                                  color: kGreen,
                                ),
                                hintText: "Pilih Tanggal",
                                hintStyle: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                filled: true,
                                fillColor:
                                    state ? kSoftDark : const Color(0xffF7F8F8),
                              ),
                              readOnly: true,
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2101),
                                  builder: (context, child) {
                                    return Theme(
                                      data: Theme.of(context).copyWith(
                                        colorScheme: const ColorScheme.light(
                                          primary:
                                              kGreen, // header background color
                                          onPrimary:
                                              kWhite, // header text color
                                          onSurface: kGreen, // body text color
                                        ),
                                        textButtonTheme: TextButtonThemeData(
                                          style: TextButton.styleFrom(
                                            foregroundColor:
                                                kGreen, // button text color
                                          ),
                                        ),
                                      ),
                                      child: child!,
                                    );
                                  },
                                );
                                if (pickedDate != null) {
                                  String formattedDate =
                                      DateFormat("yyyy-MM-dd")
                                          .format(pickedDate);

                                  setState(() {
                                    _dateController.text =
                                        formattedDate.toString();
                                  });
                                } else {}
                              },
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 100,
                      )
                    ],
                  ),
                ))
          ],
        );
      },
    );
  }

  Container buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        right: 30,
        left: 30,
        bottom: 30,
        top: 50,
      ),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
        ),
        color: kGreen,
        image: DecorationImage(
            image: AssetImage('assets/green_substract.png'), fit: BoxFit.cover),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 14,
                color: kDark,
              ),
            ),
          ),
          Text(
            'Add Income',
            style: kHeading6.copyWith(color: kWhite),
          ),
          const SizedBox(width: 24),
        ],
      ),
    );
  }
}
