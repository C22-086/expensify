import 'package:core/core.dart';
import 'package:core/presentation/widgets/form_input_data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddIncomePage extends StatefulWidget {
  static const routeName = '/add_income_page';
  const AddIncomePage({super.key});

  @override
  State<AddIncomePage> createState() => _AddIncomePageState();
}

class _AddIncomePageState extends State<AddIncomePage> {
  final TextEditingController _incomeTextController = TextEditingController();
  final TextEditingController _noteTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
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
                    onPressed: () {},
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
    );
  }

  Widget buildBody() {
    return ListView(
      children: [
        FormInputData(
          controller: _incomeTextController,
          chipLabel: 'Income',
          hintText: 'Masukkan jumlah income',
        ),
        FormInputData(
          controller: _noteTextController,
          chipLabel: 'Note',
          hintText: 'Tambahkan catatan',
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
