import 'package:flutter/material.dart';
import 'package:tokokita/ui/registrasi_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tokokita/ui/produk_page.dart';
import 'package:tokokita/model/login.dart';

// Ganti sesuai konfigurasi Anda. Gunakan 10.0.2.2 untuk emulator Android.
const String baseURL = "http://10.0.2.2/toko-api/public"; 

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  
  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formkey = GlobalKey<FormState>();
  bool isLoading = false;

  final _emailTextboxController = TextEditingController();
  final _passwordTextboxController = TextEditingController();

  void _submit() async {
    final email = _emailTextboxController.text;
    final password = _passwordTextboxController.text;
    
    // API CALL TANPA HELPER
    final response = await http.post(
      Uri.parse("$baseURL/login"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        "email": email,
        "password": password
      }),
    );
    
    setState(() {
      isLoading = false;
    });

    try {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      Login loginResult = Login.fromJson(json);

      if (loginResult.status == true && loginResult.token != null) {
        // Simpan Token Sesi ke SharedPreferences
        final pref = await SharedPreferences.getInstance();
        await pref.setString("token", loginResult.token!);
        
        // Login Sukses, pindah ke halaman Produk
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(context, 
          MaterialPageRoute(builder: (context) => const ProdukPage()));
      } else {
        // Login Gagal
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Login Gagal: ${json['data'] ?? 'Email atau password salah'}"))
        );
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error koneksi atau data: $e"))
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Firyal'), 
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                const SizedBox(height: 50),
                _emailTextField(),
                const SizedBox(height: 15),
                _passwordTextField(),
                const SizedBox(height: 25),
                _buttonLogin(),
                const SizedBox(
                  height: 30,
                ),
                _menuRegistrasi()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _emailTextField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Email",
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.email),
      ),
      keyboardType: TextInputType.emailAddress,
      controller: _emailTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Email harus diisi';
        }
        return null;
      },
    );
  }

  Widget _passwordTextField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Password",
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.lock),
      ),
      keyboardType: TextInputType.text,
      obscureText: true,
      controller: _passwordTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Password harus diisi";
        }
        return null;
      },
    );
  }

  Widget _buttonLogin() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        backgroundColor: Colors.blueAccent
      ),
      child: isLoading
          ? const CircularProgressIndicator(color: Colors.white)
          : const Text("Login", style: TextStyle(fontSize: 16, color: Colors.white)),
      onPressed: () {
        if (_formkey.currentState!.validate()) {
          setState(() {
            isLoading = true;
          });
          _submit();
        }
      },
    );
  }

  Widget _menuRegistrasi() {
    return Center(
      child: InkWell(
        child: const Text(
          "Belum punya akun? Daftar di sini!",
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const RegistrasiPage()));
        },
      ),
    );
  }
}