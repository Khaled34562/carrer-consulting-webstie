import 'dart:io';
import 'dart:typed_data';
import 'package:carrerproj_client/carrerproj_client.dart';
import 'package:carrerproj_flutter/src/serverpod_client.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:intl/intl.dart';
import 'dart:html' as html show AnchorElement, Blob, Url;

class CVPage extends StatefulWidget {
  @override
  _CVPageState createState() => _CVPageState();
}

class _CVPageState extends State<CVPage> {
  List<CVGeneration> generatedCVs = [];
  List<CVReview> reviews = [];
  File? selectedFile;
  String? cvTextToReview;
  int userId = sessionManager.signedInUser!.id!;
  bool isExtracting = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final userGenerations = await client.cVGeneration
          .getUserGenerations(userId, limit: 10, offset: 0);
      final userReviews =
          await client.cVReview.getUserReviews(userId, limit: 10, offset: 0);
      setState(() {
        generatedCVs = userGenerations;
        reviews = userReviews;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load data: $e')),
      );
    }
  }

  Future<String> extractText(Uint8List bytes) async {
    PdfDocument? document;
    try {
      document = PdfDocument(inputBytes: bytes);

      if (document.pages.count == 0) {
        throw Exception('PDF file is empty');
      }

      String text = '';
      for (int i = 0; i < document.pages.count; i++) {
        final pageText =
            await PdfTextExtractor(document).extractText(startPageIndex: i);
        text += pageText;
      }

      if (text.trim().isEmpty) {
        throw Exception('PDF does not contain extractable text');
      }
      return text;
    } catch (e) {
      throw Exception('PDF error');
    } finally {
      document?.dispose();
    }
  }

  Future<CVGeneration> generateCV() async {
    return await client.cVGeneration.generateCV(userId);
  }

  Future<void> createAndDownloadCVPdf(CVGeneration generation) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Generating your CV...'),
          ],
        ),
      ),
    );

    try {
      final String cvText = generation.generatedCV ?? 'No CV content available';
      final PdfDocument document = PdfDocument();
      PdfPage page = document.pages.add();
      final PdfStandardFont nameFont = PdfStandardFont(
          PdfFontFamily.timesRoman, 16,
          style: PdfFontStyle.bold);
      final PdfStandardFont sectionHeaderFont = PdfStandardFont(
          PdfFontFamily.timesRoman, 12,
          style: PdfFontStyle.bold);
      final PdfStandardFont subHeaderFont = PdfStandardFont(
          PdfFontFamily.timesRoman, 10,
          style: PdfFontStyle.bold);
      final PdfStandardFont bodyFont =
          PdfStandardFont(PdfFontFamily.timesRoman, 10);
      final PdfStandardFont italicFont = PdfStandardFont(
          PdfFontFamily.timesRoman, 10,
          style: PdfFontStyle.italic);

      final List<String> lines = cvText.split('\n');
      double yPosition = 50;
      bool isFirstLine = true;
      bool inList = false;
      String? currentSection;
      bool isSectionStart = true;
      const double pageHeight = 698;

      for (int i = 0; i < lines.length; i++) {
        String trimmedLine = lines[i].trim();
        if (trimmedLine.isEmpty) continue;

        PdfFont font = bodyFont;
        String text = trimmedLine;
        double fontSize = 10;
        PdfStringFormat format = PdfStringFormat(lineSpacing: 5);
        bool isBullet = false;

        if (isFirstLine &&
            trimmedLine.startsWith('**') &&
            trimmedLine.endsWith('**')) {
          font = nameFont;
          fontSize = 16;
          text = trimmedLine.substring(2, trimmedLine.length - 2);
          format = PdfStringFormat(
              lineSpacing: 5, alignment: PdfTextAlignment.center);
          isSectionStart = false;
        } else if (trimmedLine.startsWith('[') && trimmedLine.endsWith(']')) {
          text = trimmedLine.substring(1, trimmedLine.length - 1);
          format = PdfStringFormat(
              lineSpacing: 5, alignment: PdfTextAlignment.center);
        } else if (trimmedLine.startsWith('---')) {
          isSectionStart = true;
          inList = false;
          continue;
        } else if (trimmedLine.startsWith('**') && trimmedLine.endsWith('**')) {
          text = trimmedLine.substring(2, trimmedLine.length - 2);
          if (isSectionStart) {
            font = sectionHeaderFont;
            fontSize = 12;
            text = text.toUpperCase();
            currentSection = text;
            isSectionStart = false;
            yPosition += 10;
          } else {
            font = subHeaderFont;
            fontSize = 10;
            if (currentSection == 'PROFESSIONAL EXPERIENCE') {
              font = italicFont;
            }
          }
          inList = false;
        } else if (trimmedLine.startsWith('- ') ||
            trimmedLine.startsWith('* ')) {
          text = '• ${trimmedLine.substring(2)}';
          isBullet = true;
          inList = true;
        } else if (inList &&
            (trimmedLine.startsWith('  - ') ||
                trimmedLine.startsWith('  * '))) {
          text = '    • ${trimmedLine.substring(4)}';
          isBullet = true;
        } else if (inList &&
            currentSection == 'PROFESSIONAL EXPERIENCE' &&
            !trimmedLine.startsWith('[')) {
          font = italicFont;
          text = trimmedLine;
          inList = true;
        } else {
          text = trimmedLine;
          inList = false;
        }

        double remainingHeight = pageHeight - yPosition;
        final PdfTextElement textElement = PdfTextElement(
          text: text,
          font: font,
          brush: PdfSolidBrush(PdfColor(0, 0, 0)),
          format: format,
        );

        double xPosition = isBullet ? 60 : 50;
        if (text.startsWith('    •')) xPosition = 70;

        final Size textSize = font.measureString(text, format: format);
        if (yPosition + textSize.height > pageHeight) {
          page = document.pages.add();
          yPosition = 50;
          remainingHeight = pageHeight - yPosition;
        }

        final PdfLayoutResult layoutResult = textElement.draw(
          page: page,
          bounds: Rect.fromLTWH(
              xPosition, yPosition, 495 - xPosition, remainingHeight),
          format: PdfLayoutFormat(breakType: PdfLayoutBreakType.fitPage),
        )!;

        yPosition += layoutResult.bounds.height + (isBullet ? 5 : 8);
        isFirstLine = false;
      }

      final Uint8List pdfBytes = Uint8List.fromList(await document.save());
      document.dispose();

      final blob = html.Blob([pdfBytes], 'application/pdf');
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.AnchorElement(href: url)
        ..setAttribute('download', 'cv_${generation.id}.pdf')
        ..click();
      html.Url.revokeObjectUrl(url);

      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Your CV is Ready!'),
          content: Text('CV #${generation.id} has been downloaded.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } catch (e) {
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: Text('Failed to generate CV: $e'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  Future<void> _generateAndDownloadCV() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Generating CV content...'),
          ],
        ),
      ),
    );

    try {
      final generation = await generateCV();
      Navigator.pop(context);
      await createAndDownloadCVPdf(generation);
      await _loadData();
    } catch (e) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to generate CV: $e')),
      );
    }
  }

  Widget _buildSectionCard(String title, Widget content) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(child: content),
          ],
        ),
      ),
    );
  }

  Widget _buildCVCard(CVGeneration gen) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        title: Text('CV #${gen.id}'),
        subtitle: Text(
          DateFormat('yyyy-MM-dd HH:mm').format(gen.createdAt),
          style: TextStyle(color: Colors.grey),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () async {
            try {
              await client.cVGeneration.deleteGeneration(gen.id!);
              await _loadData();
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Failed to delete CV: $e')),
              );
            }
          },
        ),
        onTap: () async {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Fetching CV...'),
                ],
              ),
            ),
          );

          try {
            final cvGeneration =
                await client.cVGeneration.getGeneration(gen.id!);
            Navigator.pop(context);
            await createAndDownloadCVPdf(cvGeneration!);
          } catch (e) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed to regenerate CV: $e')),
            );
          }
        },
      ),
    );
  }

  Widget _buildReviewCard(CVReview review) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        title: Text('Review #${review.id}'),
        subtitle: Text(
          DateFormat('yyyy-MM-dd HH:mm').format(review.createdAt),
          style: TextStyle(color: Colors.grey),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () async {
            try {
              await client.cVReview.deleteReview(review.id!);
              await _loadData();
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Failed to delete review: $e')),
              );
            }
          },
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CVReviewViewPage(reviewId: review.id!),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.5,
          children: [
            _buildSectionCard(
                'Build CV',
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: _generateAndDownloadCV,
                          child: const Text('Build my CV'),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                            foregroundColor: Colors.white,
                            backgroundColor: Color(0xFF3AB8B5),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Generate a new CV based on your profile information',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey, fontSize: 12.0),
                        ),
                      ],
                    ),
                  ],
                )),
            _buildSectionCard(
                'Rate CV',
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            try {
                              final result =
                                  await FilePicker.platform.pickFiles(
                                type: FileType.custom,
                                allowedExtensions: ['pdf'],
                                withData: true,
                              );

                              if (result == null || result.files.isEmpty)
                                return;

                              final file = result.files.first;
                              Uint8List? bytes = file.bytes;

                              setState(() {
                                selectedFile =
                                    File(file.path ?? 'uploaded.pdf');
                                isExtracting = true;
                                cvTextToReview = null;
                              });

                              try {
                                if (bytes == null && file.path != null) {
                                  bytes = await File(file.path!).readAsBytes();
                                }

                                if (bytes == null) {
                                  throw Exception(
                                      'Failed to read file contents');
                                }

                                final text = await extractText(bytes);

                                setState(() {
                                  cvTextToReview = text;
                                  isExtracting = false;
                                });
                              } catch (e) {
                                setState(() => isExtracting = false);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text('Error: ${e.toString()}')),
                                );
                              }
                            } catch (e) {
                              setState(() => isExtracting = false);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text('File picker error: $e')),
                              );
                            }
                          },
                          child: DottedBorder(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(8),
                            dashPattern: const [6, 3],
                            strokeWidth: 2,
                            child: Container(
                              height: 130,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: isExtracting
                                  ? const Center(
                                      child: CircularProgressIndicator())
                                  : selectedFile != null
                                      ? Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            Icon(Icons.description,
                                                color: Colors.red, size: 48),
                                            SizedBox(height: 8),
                                            Text(
                                              'Selected: PDF file',
                                              textAlign: TextAlign.center,
                                            ),
                                            SizedBox(height: 8),
                                            Text(
                                              'Tap to select a different file',
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                          ],
                                        )
                                      : const Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.file_upload,
                                                size: 48, color: Color(0xFF3AB8B5)),
                                            SizedBox(height: 16),
                                            Text(
                                                'Click here to upload your file'),
                                            Text(
                                              'Supported format: pdf',
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                          ],
                                        ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: isExtracting || cvTextToReview == null
                              ? null
                              : () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CVReviewPage(
                                        cvText: cvTextToReview!,
                                        userId: userId,
                                      ),
                                    ),
                                  );
                                },
                          child: const Text('Rate my CV'),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.blue,
                            disabledBackgroundColor: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
            _buildSectionCard(
              'Generated CVs',
              generatedCVs.isEmpty
                  ? const Center(child: Text('No generated CVs yet'))
                  : ListView.builder(
                      itemCount: generatedCVs.length,
                      itemBuilder: (context, index) =>
                          _buildCVCard(generatedCVs[index]),
                    ),
            ),
            _buildSectionCard(
              'CV Reviews',
              reviews.isEmpty
                  ? const Center(child: Text('No reviews yet'))
                  : ListView.builder(
                      itemCount: reviews.length,
                      itemBuilder: (context, index) =>
                          _buildReviewCard(reviews[index]),
                    ),
            )
          ],
        ),
      ),
    );
  }
}

class CVReviewPage extends StatefulWidget {
  final String cvText;
  final int userId;
  const CVReviewPage({required this.cvText, required this.userId, super.key});

  @override
  _CVReviewPageState createState() => _CVReviewPageState();
}

class _CVReviewPageState extends State<CVReviewPage> {
  CVReview? review;
  String? error;

  @override
  void initState() {
    super.initState();
    _reviewCV();
  }

  Future<void> _reviewCV() async {
    try {
      final rev = await client.cVReview.reviewCV(widget.cvText, widget.userId).timeout(const Duration(seconds: 60));
      setState(() {
        review = rev;
      });
    } catch (e) {
      setState(() {
        error = 'Failed to review CV: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CV Review'),
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: Center(
        child: review == null
            ? error != null
                ? Text(error!,
                    style: const TextStyle(color: Colors.red, fontSize: 16))
                : const CircularProgressIndicator()
            : SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 12,
                        spreadRadius: 3,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: MarkdownBody(
                    data: review!.feedback ?? 'No review feedback available',
                    styleSheet: MarkdownStyleSheet(
                      h1: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey,
                      ),
                      h2: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.blueGrey,
                      ),
                      h3: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.blueGrey,
                      ),
                      p: const TextStyle(
                        fontSize: 16,
                        height: 1.5,
                        color: Colors.grey,
                      ),
                      listBullet: const TextStyle(
                        fontSize: 16,
                        height: 1.5,
                        color: Colors.grey,
                      ),
                      code: TextStyle(
                        backgroundColor: Colors.grey[200],
                        fontFamily: 'monospace',
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}

class CVReviewViewPage extends StatefulWidget {
  final int reviewId;
  const CVReviewViewPage({required this.reviewId, super.key});

  @override
  _CVReviewViewPageState createState() => _CVReviewViewPageState();
}

class _CVReviewViewPageState extends State<CVReviewViewPage> {
  CVReview? review;
  String? error;

  @override
  void initState() {
    super.initState();
    _loadReview();
  }

  Future<void> _loadReview() async {
    try {
      final rev = await client.cVReview.getReview(widget.reviewId);
      setState(() {
        review = rev;
      });
    } catch (e) {
      setState(() {
        error = 'Failed to load review: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CV Review Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: Center(
        child: review == null
            ? error != null
                ? Text(error!,
                    style: const TextStyle(color: Colors.red, fontSize: 16))
                : const CircularProgressIndicator()
            : SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 12,
                        spreadRadius: 3,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: MarkdownBody(
                    data: review!.feedback ?? 'No review feedback available',
                    styleSheet: MarkdownStyleSheet(
                      h1: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey,
                      ),
                      h2: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.blueGrey,
                      ),
                      h3: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.blueGrey,
                      ),
                      p: const TextStyle(
                        fontSize: 16,
                        height: 1.5,
                        color: Colors.grey,
                      ),
                      listBullet: const TextStyle(
                        fontSize: 16,
                        height: 1.5,
                        color: Colors.grey,
                      ),
                      code: TextStyle(
                        backgroundColor: Colors.grey[200],
                        fontFamily: 'monospace',
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
