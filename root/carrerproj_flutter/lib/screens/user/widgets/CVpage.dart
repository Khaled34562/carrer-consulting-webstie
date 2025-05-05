import 'dart:typed_data';
import 'package:carrerproj_client/carrerproj_client.dart';
import 'package:carrerproj_flutter/src/serverpod_client.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'dart:io';

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
      final userGenerations = await client.cVGeneration.getUserGenerations(userId, limit: 10, offset: 0);
      final userReviews = await client.cVReview.getUserReviews(userId, limit: 10, offset: 0);
      setState(() {
        generatedCVs = userGenerations;
        reviews = userReviews;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load data: $e', style: TextStyle(color: Color(0xFF1A2E44)))),
      );
    }
  }

  Future<String> extractText(Uint8List bytes) async {
    PdfDocument? document;
    try {
      document = PdfDocument(inputBytes: bytes);
      if (document.pages.count == 0) throw Exception('PDF file is empty');
      String text = '';
      for (int i = 0; i < document.pages.count; i++) {
        final pageText = await PdfTextExtractor(document).extractText(startPageIndex: i);
        text += pageText;
      }
      if (text.trim().isEmpty) throw Exception('PDF does not contain extractable text');
      return text;
    } catch (e) {
      throw Exception('PDF error');
    } finally {
      document?.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F8F8), // Grey background
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF1A2E44), Color(0xFF3AB8B5)],
              stops: [0.0, 0.7],
            ),
          ),
        ),
        title: Image.asset('lib/assets/white_logo.png', height: 50),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, spreadRadius: 2)],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text('Build a CV', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF1A2E44))),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CVGenerationPage(userId: userId)),
                        );
                      },
                      child: Text('Build my CV', style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF3AB8B5), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text('Generated CVs', style: TextStyle(fontSize: 18, color: Color(0xFF1A2E44))),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: generatedCVs.length,
                      itemBuilder: (context, index) {
                        final gen = generatedCVs[index];
                        return ListTile(
                          title: Text('CV #${gen.id} - ${gen.createdAt}', style: TextStyle(color: Color(0xFF1A2E44))),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => CVViewPage(generationId: gen.id!)),
                            );
                          },
                          trailing: IconButton(
                            icon: Icon(Icons.delete, color: Color(0xFF3AB8B5)),
                            onPressed: () async {
                              try {
                                await client.cVGeneration.deleteGeneration(gen.id!);
                                await _loadData();
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Failed to delete CV: $e', style: TextStyle(color: Color(0xFF1A2E44)))),
                                );
                              }
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text('Rate a CV', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF1A2E44))),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: GestureDetector(
                      onTap: () async {
                        try {
                          final result = await FilePicker.platform.pickFiles(
                            type: FileType.custom,
                            allowedExtensions: ['pdf'],
                            withData: true,
                          );
                          if (result == null || result.files.isEmpty) return;
                          final file = result.files.first;
                          Uint8List? bytes = file.bytes;
                          setState(() {
                            selectedFile = File(file.path ?? 'uploaded.pdf');
                            isExtracting = true;
                            cvTextToReview = null;
                          });
                          try {
                            if (bytes == null && file.path != null) bytes = await File(file.path!).readAsBytes();
                            if (bytes == null) throw Exception('Failed to read file contents');
                            final text = await extractText(bytes);
                            setState(() {
                              cvTextToReview = text;
                              isExtracting = false;
                            });
                          } catch (e) {
                            setState(() => isExtracting = false);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Error: ${e.toString()}', style: TextStyle(color: Color(0xFF1A2E44)))),
                            );
                          }
                        } catch (e) {
                          setState(() => isExtracting = false);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('File picker error: $e', style: TextStyle(color: Color(0xFF1A2E44)))),
                          );
                        }
                      },
                      child: DottedBorder(
                        borderType: BorderType.RRect,
                        radius: Radius.circular(8),
                        dashPattern: [6, 3],
                        strokeWidth: 2,
                        child: Container(
                          height: 200,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                          child: isExtracting
                              ? Center(child: CircularProgressIndicator())
                              : selectedFile != null
                                  ? Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.description, color: Color(0xFF3AB8B5), size: 48),
                                        SizedBox(height: 8),
                                        Text('Selected: ${selectedFile!.path.split('/').last}', textAlign: TextAlign.center, style: TextStyle(color: Color(0xFF1A2E44))),
                                        SizedBox(height: 8),
                                        Text('Tap to select a different file', style: TextStyle(color: Colors.grey)),
                                      ],
                                    )
                                  : Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.file_upload, size: 48, color: Color(0xFF3AB8B5)),
                                        SizedBox(height: 16),
                                        Text('Click here to upload your file', style: TextStyle(color: Color(0xFF1A2E44))),
                                        Text('Supported format: pdf', style: TextStyle(color: Colors.grey)),
                                      ],
                                    ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      onPressed: isExtracting || cvTextToReview == null ? null : () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CVReviewPage(cvText: cvTextToReview!, userId: userId)),
                        );
                      },
                      child: Text('Rate my CV', style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF3AB8B5),
                        disabledBackgroundColor: Colors.grey,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text('CV Reviews', style: TextStyle(fontSize: 18, color: Color(0xFF1A2E44))),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: reviews.length,
                      itemBuilder: (context, index) {
                        final review = reviews[index];
                        return ListTile(
                          title: Text('Review #${review.id} - ${review.createdAt}', style: TextStyle(color: Color(0xFF1A2E44))),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => CVReviewViewPage(reviewId: review.id!)),
                            );
                          },
                          trailing: IconButton(
                            icon: Icon(Icons.delete, color: Color(0xFF3AB8B5)),
                            onPressed: () async {
                              try {
                                await client.cVReview.deleteReview(review.id!);
                                await _loadData();
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Failed to delete review: $e', style: TextStyle(color: Color(0xFF1A2E44)))),
                                );
                              }
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CVGenerationPage extends StatefulWidget {
  final int userId;
  const CVGenerationPage({required this.userId, super.key});

  @override
  _CVGenerationPageState createState() => _CVGenerationPageState();
}

class _CVGenerationPageState extends State<CVGenerationPage> {
  CVGeneration? generation;
  String? error;

  @override
  void initState() {
    super.initState();
    _generateCV();
  }

  Future<void> _generateCV() async {
    try {
      final gen = await client.cVGeneration.generateCV(widget.userId);
      setState(() {
        generation = gen;
      });
    } catch (e) {
      setState(() {
        error = 'Failed to generate CV: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F8F8), // Grey background
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF1A2E44), Color(0xFF3AB8B5)],
              stops: [0.0, 0.7],
            ),
          ),
        ),
        title: Text('Generating CV', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: Icon(Icons.cancel, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, spreadRadius: 2)],
        ),
        child: Center(
          child: generation == null
              ? error != null
                  ? Text(error!, style: TextStyle(color: Colors.red, fontSize: 16))
                  : CircularProgressIndicator()
              : SingleChildScrollView(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    generation!.generatedCV ?? 'No CV content available',
                    style: TextStyle(fontSize: 16, color: Color(0xFF1A2E44)),
                  ),
                ),
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
      final rev = await client.cVReview.reviewCV(widget.cvText, widget.userId);
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
      backgroundColor: Color(0xFFF8F8F8), // Grey background
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF1A2E44), Color(0xFF3AB8B5)],
              stops: [0.0, 0.7],
            ),
          ),
        ),
        title: Text('Reviewing CV', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: Icon(Icons.cancel, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, spreadRadius: 2)],
        ),
        child: Center(
          child: review == null
              ? error != null
                  ? Text(error!, style: TextStyle(color: Colors.red, fontSize: 16))
                  : CircularProgressIndicator()
              : SingleChildScrollView(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    review!.feedback ?? 'No review feedback available',
                    style: TextStyle(fontSize: 16, color: Color(0xFF1A2E44)),
                  ),
                ),
        ),
      ),
    );
  }
}

class CVViewPage extends StatefulWidget {
  final int generationId;
  const CVViewPage({required this.generationId, super.key});

  @override
  _CVViewPageState createState() => _CVViewPageState();
}

class _CVViewPageState extends State<CVViewPage> {
  CVGeneration? generation;
  String? error;

  @override
  void initState() {
    super.initState();
    _loadGeneration();
  }

  Future<void> _loadGeneration() async {
    try {
      final gen = await client.cVGeneration.getGeneration(widget.generationId);
      setState(() {
        generation = gen;
      });
    } catch (e) {
      setState(() {
        error = 'Failed to load CV: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F8F8), // Grey background
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF1A2E44), Color(0xFF3AB8B5)],
              stops: [0.0, 0.7],
            ),
          ),
        ),
        title: Text('View CV', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: Icon(Icons.cancel, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, spreadRadius: 2)],
        ),
        child: Center(
          child: generation == null
              ? error != null
                  ? Text(error!, style: TextStyle(color: Colors.red, fontSize: 16))
                  : CircularProgressIndicator()
              : SingleChildScrollView(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    generation!.generatedCV ?? 'No CV content available',
                    style: TextStyle(fontSize: 16, color: Color(0xFF1A2E44)),
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
      backgroundColor: Color(0xFFF8F8F8), // Grey background
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF1A2E44), Color(0xFF3AB8B5)],
              stops: [0.0, 0.7],
            ),
          ),
        ),
        title: Text('View Review', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: Icon(Icons.cancel, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, spreadRadius: 2)],
        ),
        child: Center(
          child: review == null
              ? error != null
                  ? Text(error!, style: TextStyle(color: Colors.red, fontSize: 16))
                  : CircularProgressIndicator()
              : SingleChildScrollView(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    review!.feedback ?? 'No review feedback available',
                    style: TextStyle(fontSize: 16, color: Color(0xFF1A2E44)),
                  ),
                ),
        ),
      ),
    );
  }
}