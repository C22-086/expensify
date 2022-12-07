import 'package:core/core.dart';
import 'package:core/presentation/widgets/form_input_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class AddIncomePage extends StatefulWidget {
  static const routeName = '/add_income_page';

  final dynamic user;

  const AddIncomePage({super.key, required this.user});

  @override
  State<AddIncomePage> createState() => _AddIncomePageState();
}

class _AddIncomePageState extends State<AddIncomePage> {
  final TextEditingController _incomeTextController = TextEditingController();

  final TextEditingController _noteTextController = TextEditingController();

  dynamic category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                SizedBox(
                  height: MediaQuery.of(context).size.height - 130,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: buildBody(),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                width: double.infinity,
                decoration: const BoxDecoration(color: kWhite, boxShadow: [
                  BoxShadow(
                    offset: Offset(3, 15),
                    spreadRadius: -17,
                    blurRadius: 49,
                    color: Color.fromRGBO(139, 139, 139, 1),
                  )
                ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<DatabaseBloc>(context).add(
                            DatabasePushIncomeUser(
                                name: widget.user['name'],
                                uid: widget.user['uid'],
                                category: category,
                                nominal: int.parse(_incomeTextController.text),
                                note: _noteTextController.text));
                      },
                      style: ElevatedButton.styleFrom(
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
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildBody() {
    return ListView(
      children: [
        Form(
          child: Column(
            children: [
              FormInputData(
                controller: _incomeTextController,
                chipLabel: 'Income',
                hintText: 'Masukkan jumlah income',
              ),
              Container(
                margin: const EdgeInsets.only(top: 24),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
                decoration: BoxDecoration(
                  color: kWhite,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(3, 3),
                      spreadRadius: -10,
                      blurRadius: 49,
                      color: Color.fromARGB(255, 169, 169, 169),
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
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: kGreen,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.keyboard_arrow_down,
                          color: kWhite,
                        ),
                      ),
                      hint: const Text('Pilih kategori'),
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: kRichBlack,
                      ),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        filled: true,
                        fillColor: const Color(0xffF7F8F8),
                      ),
                      items: const [
                        DropdownMenuItem(
                          enabled: false,
                          child: Text('Pilih kategori'),
                        ),
                        DropdownMenuItem(
                          value: 'Gaji',
                          child: Text('Gaji'),
                        ),
                        DropdownMenuItem(
                          value: 'Penjualan',
                          child: Text('Penjualan'),
                        ),
                        DropdownMenuItem(
                          value: 'Tabungan',
                          child: Text('Tabungan'),
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
              FormInputData(
                controller: _noteTextController,
                chipLabel: 'Note',
                hintText: 'Tambahkan catatan',
              )
            ],
          ),
        )
      ],
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
              child: const Icon(Icons.arrow_back_ios_new_rounded, size: 14),
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
