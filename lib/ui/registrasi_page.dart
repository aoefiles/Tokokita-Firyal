import 'package:flutter/material.dart';

class RegistrasiPage extends StatefulWidget {
  const RegistrasiPage({Key? key}) : super(key: key);
  @override
  _RegistrasiPageState createState() => _RegistrasiPageState();
}

class _RegistrasiPageState extends State<RegistrasiPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  final _namaTextboxController = TextEditingController();
  final _emailTextboxController = TextEditingController();
  final _passwordTextboxController = TextEditingController();

  final Color _primaryColor = const Color(0xFF673AB7);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: _primaryColor),
        title: Text("Registrasi Firyal", style: TextStyle(color: _primaryColor, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              const Icon(Icons.person_add_alt_1, size: 80, color: Colors.deepPurple),
              const SizedBox(height: 20),
              Text("Buat Akun Baru", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.grey[800])),
              const SizedBox(height: 30),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    _customTextField("Nama", Icons.person, _namaTextboxController),
                    const SizedBox(height: 20),
                    _customTextField("Email", Icons.email, _emailTextboxController, isEmail: true),
                    const SizedBox(height: 20),
                    _customTextField("Password", Icons.lock, _passwordTextboxController, isPassword: true),
                    const SizedBox(height: 20),
                    _customTextField("Konfirmasi Password", Icons.lock_outline, null, isPassword: true, isConfirm: true),
                    const SizedBox(height: 40),
                    _buttonRegistrasi()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _customTextField(String label, IconData icon, TextEditingController? controller, {bool isPassword = false, bool isEmail = false, bool isConfirm = false}) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: _primaryColor),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: _primaryColor, width: 2),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) return "$label harus diisi";
        if (isConfirm && value != _passwordTextboxController.text) return "Password tidak sama";
        return null;
      },
    );
  }

  Widget _buttonRegistrasi() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: _primaryColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 5,
        ),
        child: const Text("DAFTAR SEKARANG", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
        onPressed: () {
          var validate = _formKey.currentState!.validate();
        },
      ),
    );
  }
}