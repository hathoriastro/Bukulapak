
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewerPage extends StatelessWidget {
  final String title;
  final String pdfUrl;

  const PdfViewerPage({
    super.key,
    required this.title,
    required this.pdfUrl,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final sizeheight = size.height;
    final fullheight = 956;
    return Scaffold(
      appBar: 
      AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: sizeheight * 112 / fullheight,
        elevation: 4,
        shadowColor: Colors.grey.withOpacity(0.5),
        surfaceTintColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back),
        ),
        title:Text(
            (title),
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,),
          ),
        ),
      
      body: SfPdfViewer.network(pdfUrl),
    );
  }
}
