import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class Terms extends StatefulWidget {
  const Terms({super.key});

  @override
  State<Terms> createState() => _TermsState();
}

class _TermsState extends State<Terms> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SfPdfViewer.network(
        'https://www.termsfeed.com/public/uploads/2021/12/sample-terms-conditions-agreement.pdf',
        scrollDirection: PdfScrollDirection.vertical,
      ),
    );
  }
}
