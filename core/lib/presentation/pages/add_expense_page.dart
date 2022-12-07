import 'package:core/core.dart';
import 'package:core/presentation/widgets/form_input_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AddExpensePage extends StatefulWidget {
  static const routeName = '/add_expense_page';

  final dynamic user;

  const AddExpensePage({super.key, required this.user});

  @override
  State<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  final TextEditingController _incomeTextController = TextEditingController();
  final TextEditingController _noteTextController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  dynamic category;

  @override
  void initState() {
    super.initState();
    dateController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocListener<DatabaseBloc, DatabaseState>(
        listener: (context, state) {
          if (state is DatabaseSuccess) {
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Success menambah expanse')));
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
                    child: ListView(
                      shrinkWrap: true,
                      children: [buildBody()],
                    ),
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
                            DatabasePushExpanseUser(
                                name: widget.user['name'],
                                uid: widget.user['uid'],
                                category: category,
                                nominal: int.parse(_incomeTextController.text),
                                note: _noteTextController.text));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kRed,
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
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Form(
            child: Column(
              children: [
                FormInputData(
                  controller: _incomeTextController,
                  chipLabel: 'Expense',
                  hintText: 'Masukkan jumlah Pengeluaran',
                  boderColor: kRed,
                  textColor: kRed,
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
                          color: kRed,
                        ),
                        shape: const RoundedRectangleBorder(
                          side: BorderSide(color: kRed, width: 2),
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
                            color: kRed,
                            borderRadius: BorderRadius.circular(6),
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
                  boderColor: kRed,
                  textColor: kRed,
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
                          color: kRed,
                        ),
                        shape: const RoundedRectangleBorder(
                          side: BorderSide(color: kRed, width: 2),
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                        label: const Text('Tanggal'),
                      ),
                      const SizedBox(height: 9),
                      TextFormField(
                        controller: dateController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.calendar_today,
                            color: kRed,
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
                          fillColor: const Color(0xffF7F8F8),
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
                                  colorScheme: ColorScheme.light(
                                    primary: kRed, // header background color
                                    onPrimary: kWhite, // header text color
                                    onSurface: kRed, // body text color
                                  ),
                                  textButtonTheme: TextButtonThemeData(
                                    style: TextButton.styleFrom(
                                      primary: kRed, // button text color
                                    ),
                                  ),
                                ),
                                child: child!,
                              );
                            },
                          );
                          if (pickedDate != null) {
                            String formattedDate =
                                DateFormat("yyyy-MM-dd").format(pickedDate);

                            setState(() {
                              dateController.text = formattedDate.toString();
                            });
                          } else {}
                        },
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 150,
                )
              ],
            ),
          ),
        ),
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
        color: kDarkRed,
        image: DecorationImage(
          image: AssetImage('assets/red_substract.png'),
          fit: BoxFit.cover,
        ),
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
            'Add Expense',
            style: kHeading6.copyWith(color: kWhite),
          ),
          const SizedBox(width: 24),
        ],
      ),
    );
  }
}
