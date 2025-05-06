import 'package:carrerproj_flutter/screens/landing.dart';
import 'package:carrerproj_flutter/src/serverpod_client.dart';
import 'package:carrerproj_flutter/screens/consultant/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_quill/flutter_quill.dart';




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
      title: 'Aoun',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF3AB8B5)),
        useMaterial3: true,
      ),
      home: MyHomePage(),
      localizationsDelegates: const [
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    FlutterQuillLocalizations.delegate,
  ]
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
