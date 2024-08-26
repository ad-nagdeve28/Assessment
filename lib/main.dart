import 'package:assessment/components/signout.dart';
import 'package:assessment/screens/dashboard.dart';
import 'package:assessment/screens/signinscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final isLoggedIn = await _checkLoginStatus();
  runApp(ChangeNotifierProvider(
    create: (context) => SignOut(),
    child: MyApp(isLoggedIn: isLoggedIn),
  ));
  // runApp(MyApp(isLoggedIn: isLoggedIn));
}

Future<bool> _checkLoginStatus() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool('isLoggedIn') ?? false;
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  MyApp({required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Assessment',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: isLoggedIn ? DashboardScreen() : SignInScreen(),
    );
  }
}
