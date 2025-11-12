import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PdfPrintPage extends StatefulWidget {
  const PdfPrintPage({super.key});

  @override
  State<PdfPrintPage> createState() => _PdfPrintPageState();
}

class _PdfPrintPageState extends State<PdfPrintPage> {
  pw.Font? font;

  Future<void> _t() async {
    font ??= pw.Font.ttf(
        await rootBundle.load('assets/font/SourceHanSansSC-VF.ttf'));
    final doc = pw.Document();
    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Text(
              '你好👋',
              style: pw.TextStyle(font: font, fontSize: 50),
            ),
          );
        },
      ),
    );
    Printing.layoutPdf(onLayout: (PdfPageFormat format) {
      return doc.save();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('pdf打印'),
        actions: [
          TextButton(
            onPressed: () {
              _t();
            },
            child: const Text('打印'),
          ),
        ],
      ),
    );
  }
}
