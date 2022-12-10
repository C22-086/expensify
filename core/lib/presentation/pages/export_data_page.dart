// ignore_for_file: depend_on_referenced_packages

import 'package:core/core.dart';
import 'package:core/presentation/widgets/custom_button.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class ExportDataPage extends StatefulWidget {
  static const routeName = '/export-data';
  final dynamic user;
  const ExportDataPage({super.key, required this.user});

  @override
  State<ExportDataPage> createState() => _ExportDataPageState();
}

class _ExportDataPageState extends State<ExportDataPage> {
  TextEditingController dateController = TextEditingController();
  String category = 'kosong';
  String format = 'kosong';

  @override
  void initState() {
    super.initState();
    dateController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<dynamic>(
          stream: FirebaseDatabase.instance
              .ref('transaction/${widget.user['uid']}')
              .onValue,
          builder: (context, snapshot) {
            return Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildHeader(context),
                    SizedBox(
                      height: MediaQuery.of(context).size.height - 130,
                      child: buildBody(),
                    ),
                  ],
                ),
              ],
            );
          }),
    );
  }

  Future<void> _createPdf() async {
    final pdf = pw.Document();

    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Text("Hello World"),
          );
        }));

    Uint8List bytes = await pdf.save();

    await saveAndLaunchFile(bytes, 'document.pdf');
  }

  Widget buildBody() {
    return Container(
        padding:
            const EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Pilih Kategori", style: kHeading6),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      category = 'pendapatan';
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 17, vertical: 10),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: category == 'pendapatan' ? kGreen : kGrey,
                            width: 2),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8))),
                    child: Text(
                      "Pendapatan",
                      style: kHeading7.copyWith(color: kSoftBlack),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      category = 'pemasukan';
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 17, vertical: 10),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: category == 'pemasukan' ? kGreen : kGrey,
                            width: 2),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8))),
                    child: Text(
                      "Pemasukan",
                      style: kHeading7.copyWith(color: kSoftBlack),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text("Pilih Tanggal", style: kHeading6),
            const SizedBox(
              height: 10,
            ),
            Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Center(
                    child: TextFormField(
                  controller: dateController,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.calendar_today),
                      hintText: "Masukkan Tanggal",
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: kGreen, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: kGrey, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(8)))),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (pickedDate != null) {
                      String formattedDate =
                          DateFormat("yyyy-MM-dd").format(pickedDate);

                      setState(() {
                        dateController.text = formattedDate.toString();
                      });
                    } else {}
                  },
                ))),
            const SizedBox(
              height: 20,
            ),
            Text("Pilih Format", style: kHeading6),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  format = 'PDF';
                });
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 17, vertical: 10),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: format == 'PDF' ? kGreen : kGrey, width: 2),
                    borderRadius: const BorderRadius.all(Radius.circular(8))),
                child: Text(
                  "PDF",
                  style: kHeading7.copyWith(color: kSoftBlack),
                ),
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: SizedBox(
                width: 150,
                height: 50,
                child: CustomButton(
                    title: "Ekspor",
                    onPressed: () {
                      _createPdf();
                    }),
              ),
            )
          ],
        ));
  }

  Widget buildTextField(String placeholder) {
    return Container(
        padding: const EdgeInsets.only(bottom: 35.0),
        child: TextFormField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: kRichBlack, width: 2),
              borderRadius: BorderRadius.circular(14),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(14),
            ),
            fillColor: const Color.fromARGB(255, 231, 231, 231),
            hintText: placeholder,
            filled: true,
            hintStyle:
                GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600),
          ),
        ));
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
            'Ekspor Data',
            style: kHeading6.copyWith(color: kWhite),
          ),
          const SizedBox(width: 24),
        ],
      ),
    );
  }
}
