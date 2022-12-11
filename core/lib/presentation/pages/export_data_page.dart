// ignore_for_file: depend_on_referenced_packages

import 'package:core/core.dart';
import 'package:core/presentation/widgets/back_button.dart';
import 'package:core/presentation/widgets/custom_button.dart';
import 'package:core/utils/format_currency.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class ExportDataPage extends StatefulWidget {
  static const routeName = '/export-data';
  final dynamic user;
  const ExportDataPage({super.key, required this.user});

  @override
  State<ExportDataPage> createState() => _ExportDataPageState();
}

class _ExportDataPageState extends State<ExportDataPage> {
  String category = 'kosong';
  String format = 'kosong';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<dynamic>(
          stream: FirebaseDatabase.instance
              .ref('transaction/${widget.user['uid']}')
              .onValue,
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final result = snapshot.data;
            final user = result.snapshot.value;
            return snapshot.hasData
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildHeader(context),
                      Expanded(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Container(
                            child: buildBody(user),
                          ),
                        ),
                      ),
                    ],
                  )
                : const Center(child: CircularProgressIndicator());
          }),
    );
  }

  Future<void> _createPdf(data) async {
    final Map<dynamic, dynamic> transactions = data ?? {};
    final listData = transactions.values.toList();

    final dataIncome = [];
    final incomesAmount = [];

    final dataExpanse = [];
    final expansesAmount = [];

    if (category == 'pendapatan') {
      for (var e in listData) {
        if (e['type'] == 'income') {
          dataIncome.add(e);
          incomesAmount.add(e['amount']);
        }
      }

      final total = incomesAmount.length >= 2
          ? incomesAmount.reduce((a, b) => a + b)
          : incomesAmount.isEmpty
              ? 0
              : incomesAmount.first;

      _savePdf(dataIncome, total);
    } else if (category == 'pengeluaran') {
      for (var e in listData) {
        if (e['type'] == 'expanse') {
          dataExpanse.add(e);
          expansesAmount.add(e['amount']);
        }
      }

      final total = expansesAmount.length >= 2
          ? expansesAmount.reduce((a, b) => a + b)
          : expansesAmount.isEmpty
              ? 0
              : expansesAmount.first;

      _savePdf(dataExpanse, total);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Ada Kesalahan !!')));
    }
  }

  Future<void> _savePdf(List data, total) async {
    const tableHeader = ['No', 'Tanggal', 'Judul', 'Kategori', 'Nominal'];
    int no = 1;
    final dataTable = data
        .map((e) => [
              no++,
              if (e['type'] == 'income') e['incomeDate'] else e['expanseDate'],
              e['title'],
              e['category'],
              formatCurrency.format(e['amount']),
            ])
        .toList();

    final pdf = pw.Document();

    final netImage = await networkImage(
        'https://firebasestorage.googleapis.com/v0/b/expensify-3fd31.appspot.com/o/images%2Fapp_icon.png?alt=media&token=8e2b3497-550a-4409-90cc-e70f84d736f9');

    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(children: [
            pw.Image(netImage, height: 60, width: 60),
            pw.Text('Expensify',
                style: pw.TextStyle(
                  fontSize: 20,
                  fontWeight: pw.FontWeight.bold,
                )),
            pw.SizedBox(height: 30),
            pw.Divider(),
            pw.Row(
              children: [
                pw.Text(
                  'Nama : ',
                  style: const pw.TextStyle(fontSize: 12),
                ),
                pw.Text(
                  widget.user['name'],
                  style: const pw.TextStyle(fontSize: 12),
                )
              ],
            ),
            pw.Row(
              children: [
                pw.Text(
                  'Email : ',
                  style: const pw.TextStyle(fontSize: 12),
                ),
                pw.Text(
                  widget.user['email'],
                  style: const pw.TextStyle(fontSize: 12),
                )
              ],
            ),
            pw.SizedBox(height: 20),
            pw.Table.fromTextArray(
              data: dataTable,
              border: null,
              headers: tableHeader,
              headerStyle: pw.TextStyle(
                color: PdfColors.white,
                fontWeight: pw.FontWeight.bold,
              ),
              headerDecoration: const pw.BoxDecoration(
                color: PdfColor.fromInt(0xFF21DD73),
              ),
              rowDecoration: const pw.BoxDecoration(
                border: pw.Border(
                  bottom: pw.BorderSide(
                    color: PdfColors.grey300,
                    width: .5,
                  ),
                ),
              ),
            ),
            pw.SizedBox(height: 20),
            pw.Row(
              children: [
                pw.Text(
                  category == 'pendapatan'
                      ? 'Jumlah Pendapatan : '
                      : 'Jumlah Pengeluaran : ',
                  style: pw.TextStyle(
                      fontSize: 12, fontBold: pw.Font.courierBold()),
                ),
                pw.Text(
                  formatCurrency.format(total),
                  style: const pw.TextStyle(fontSize: 12),
                )
              ],
            ),
            pw.SizedBox(height: 20),
          ]);
        }));

    Uint8List bytes = await pdf.save();

    await saveAndLaunchFile(bytes, '${widget.user['email']}.pdf');
  }

  Widget buildBody(user) {
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
                    child: Text("Pendapatan", style: kHeading7),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      category = 'pengeluaran';
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 17, vertical: 10),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: category == 'pengeluaran' ? kGreen : kGrey,
                            width: 2),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8))),
                    child: Text(
                      "Pengeluaran",
                      style: kHeading7,
                    ),
                  ),
                )
              ],
            ),
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
                  style: kHeading7,
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
                      if (category == 'kosong') {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Pilih Kategori !!')));
                      } else if (format == 'kosong') {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Pilih Format !!')));
                      } else {
                        _createPdf(user);
                      }
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
          CustomBackButton(
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          Text('Ekspor Data', style: kHeading6.copyWith(color: kWhite)),
          const SizedBox(width: 24),
        ],
      ),
    );
  }
}
