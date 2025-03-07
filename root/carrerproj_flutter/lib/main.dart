import 'package:authinticationproj_flutter/screens/landing.dart';
import 'package:authinticationproj_flutter/src/serverpod_client.dart';
import 'package:authinticationproj_flutter/screens/consultant/homepage.dart';
import 'package:flutter/material.dart';
import '../../carrerproj_client/lib/carrer_consilting_website_client.dart';


var client = Client('http://localhost:8080/')
  ..connectivityMonitor = FlutterConnectivityMonitor();
  
class ArticlesPage extends StatefulWidget {
    const ArticlesPage({super.key});

    @override
    ArticlesPageState createState() => ArticlesPageState();
}

class ArticlesPageState extends State<ArticlesPage> {
  List<Article>? _articles;
  Exception? _connectionException;

  void initState() {
    super.initState();
    _FetchArticles();
  }

  Future<void> _FetchArticles(Session session, int consultantId ) async {
    try {
        var articles = await client.fetchArticlesByConsultant(session, consultantId);
        setState(() {
            _articles = articles;
        });
    } catch (e) {
        _connectionFailed(e);
    }
  }
  
  
  void _connectionFailed(dynamic exception) {
    setState(() {
        _articles = null;
        _connectionException = exception;
    });


}
  
void main() async{
  // Need to call this as SessionManager is using Flutter bindings before runApp
  // is called.
  WidgetsFlutterBinding.ensureInitialized();

  await initializeServerpodClient();

 runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Career Consulting',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
void initState() {
  super.initState();

  // Make sure that we rebuild the page if signed in status changes.
  sessionManager.addListener(() {
    setState(() {});
  });
}


  @override
   Widget build(BuildContext context) {
    return Scaffold(
      body: sessionManager.isSignedIn ? const DashboardPage() : const LandingPage(),
    );
  }
}
