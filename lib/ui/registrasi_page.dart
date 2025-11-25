import 'package:flutter/material.dart';
import 'package:tokokita/ui/login_page.dart'; 
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tokokita/model/registrasi.dart';

// Ganti sesuai konfigurasi Anda. Gunakan 10.0.2.2 untuk emulator Android.
const String baseURL = "http://10.0.2.2/toko-api/public"; 

class RegistrasiPage extends StatefulWidget {
  const RegistrasiPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _RegistrasiPageState createState() => _RegistrasiPageState();
}

class _RegistrasiPageState extends State<RegistrasiPage> {
  final _formkey = GlobalKey<FormState>();
  bool isLoading = false;
  
  final _namaTextboxController = TextEditingController();
  final _emailTextboxController = TextEditingController();
  final _passwordTextboxController = TextEditingController();

  void _submit() async {
    final nama = _namaTextboxController.text;
    final email = _emailTextboxController.text;
    final password = _passwordTextboxController.text;
    
    // API CALL TANPA HELPER
    final response = await http.post(
      Uri.parse("$baseURL/registrasi"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        "nama": nama,
        "email": email,
        "password": password
      }),
    );
    
    setState(() {
      isLoading = false;
    });

    try {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      Registrasi registrasiResult = Registrasi.fromJson(json);

      if (registrasiResult.status == true) {
        // Registrasi Sukses, pindah ke halaman Login
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(context, 
          MaterialPageRoute(builder: (context) => const LoginPage()));
      } else {
        // Registrasi Gagal
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Registrasi Gagal: ${registrasiResult.data ?? 'Terjadi kesalahan'}"))
        );
      }
    } catch (e) {
       // ignore: use_build_context_synchronously
       ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error koneksi: $e"))
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registrasi Firyal"),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _namaTextField(),
                const SizedBox(height: 15),
                _emailTextField(),
                const SizedBox(height: 15),
                _passwordTextField(),
                const SizedBox(height: 15),
                _passwordKonfirmasiTextField(),
                const SizedBox(height: 25),
                _buttonRegistrasi()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _namaTextField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Nama",
        border: OutlineInputBorder(), 
        prefixIcon: Icon(Icons.person),
      ),
      keyboardType: TextInputType.text,
      controller: _namaTextboxController,
      validator: (value) {
        if (value!.length < 3) {
          return "Nama harus diisi minimal 3 karakter";
        }
        return null;
      },
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
        Pattern pattern =
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))\$';
        RegExp regex = RegExp(pattern.toString());
        if (!regex.hasMatch(value)) {
          return "Email tidak valid";
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
        if (value!.length < 6) {
          return "Password harus diisi minimal 6 karakter";
        }
        return null;
      },
    );
  }

  Widget _passwordKonfirmasiTextField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Konfirmasi Password",
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.lock_reset),
      ),
      keyboardType: TextInputType.text,
      obscureText: true,
      validator: (value) {
        if (value != _passwordTextboxController.text) {
          return "Konfirmasi Password tidak sama";
        }
        return null;
      },
    );
  }

  Widget _buttonRegistrasi() {
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
          : const Text("Registrasi", style: TextStyle(fontSize: 16, color: Colors.white)),
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
}