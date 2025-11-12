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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('pdf打印')),
      body: PdfPreview(
        build: (format) => _generatePdf(format),
      ),
    );
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
    font ??= pw.Font.ttf(
        await rootBundle.load('assets/font/SourceHanSansSC-VF.ttf'));

    pdf.addPage(pw.Page(
      pageFormat: format,
      build: (context) {
        return pw.Center(
          child: pw.Text('第一页', style: pw.TextStyle(font: font, fontSize: 100)),
        );
      },
    ));
    pdf.addPage(pw.Page(
      pageFormat: format,
      build: (context) {
        return pw.Column(
          children: [
            pw.SizedBox(
              width: double.infinity,
              child: pw.FittedBox(
                child: pw.Text('第二页', style: pw.TextStyle(font: font)),
              ),
            ),
            pw.SizedBox(height: 20),
            pw.Flexible(child: pw.FlutterLogo()),
          ],
        );
      },
    ));

    return pdf.save();
  }
}
