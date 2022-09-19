import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nosrah/features/ansar_magazine/domain/entities/ansar_magazine_issue.dart';

class AnsarMagazinePDFPage extends StatefulWidget {
  const AnsarMagazinePDFPage({
    Key? key,
    required this.ansarMagazineIssue,
  }) : super(key: key);

  final AnsarMagazineIssue ansarMagazineIssue;

  @override
  State<AnsarMagazinePDFPage> createState() => _AnsarMagazineStatePDFPage();
}

class _AnsarMagazineStatePDFPage extends State<AnsarMagazinePDFPage> {
  late PDFDocument document;
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    loadDocument();
  }

  loadDocument() async {
    document = await PDFDocument.fromURL(
      widget.ansarMagazineIssue.url,
    );

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFF0C262B),
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Image.asset(
            'assets/images/muhammad_peace_be_upon_him.png',
            width: 66.25.w,
            height: 52.31.h,
          ),
          backgroundColor: const Color(0xFF0C262B),
        ),
        body: Center(
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : PDFViewer(
                  document: document,
                  backgroundColor: const Color(0xFF0C262B),
                  scrollDirection: Axis.vertical,
                  progressIndicator: const CircularProgressIndicator(),
                  pickerButtonColor: Theme.of(context).colorScheme.secondary,
                ),
        ),
      ),
    );
  }
}
