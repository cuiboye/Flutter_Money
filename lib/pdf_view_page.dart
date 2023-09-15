import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

///pdf预览
class PdfPreviewWidget extends StatelessWidget {
  final String pdfPath;

  const PdfPreviewWidget(this.pdfPath, {super.key});

  @override
  Widget build(BuildContext context) {
    return PDFView(
      filePath: pdfPath,
      //比如从Download中获取pdf文件路径：/storage/emulated/0/Download/wajiucrm1694749017632314.pdf
      enableSwipe: true,
      swipeHorizontal: false,
      autoSpacing: false,
      pageFling: false,
      onRender: (pages) {
        // setState(() {
        //   pages = pages;
        //   isReady = true;
        // });
      },
      onError: (error) {
        debugPrint(error.toString());
      },
      onPageError: (page, error) {
        debugPrint('$page: ${error.toString()}');
      },
      onViewCreated: (PDFViewController pdfViewController) {},
      onPageChanged: (int? page, int? total) {
        debugPrint('page change: $page/$total');
      },
    );
  }
}
