import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tokokita/ui/produk_page.dart';
import 'package:tokokita/ui/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
 
  Widget page = const Center(child: CircularProgressIndicator()); 

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

 
  void checkLoginStatus() async {
    final pref = await SharedPreferences.getInstance();
    final token = pref.getString("token"); 
    
    setState(() {
      
      page = (token != null) ? const ProdukPage() : const LoginPage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Toko Kita Firyal', 
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: page, 
    );
  }
}