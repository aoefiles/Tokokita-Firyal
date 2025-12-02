import 'package:flutter/material.dart';
import 'package:tokokita/bloc/registrasi_bloc.dart';
import 'package:tokokita/widget/success_dialog.dart';
import 'package:tokokita/widget/warning_dialog.dart';

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
        title: Text("Registrasi Firyal",
            style: TextStyle(color: _primaryColor, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              const Icon(Icons.person_add_alt_1,
                  size: 80, color: Colors.deepPurple),
              const SizedBox(height: 20),
              Text("Buat Akun Baru",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800])),
              const SizedBox(height: 30),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    _customTextField(
                        "Nama", Icons.person, _namaTextboxController),
                    const SizedBox(height: 20),
                    _customTextField(
                        "Email", Icons.email, _emailTextboxController,
                        isEmail: true),
                    const SizedBox(height: 20),
                    _customTextField(
                        "Password", Icons.lock, _passwordTextboxController,
                        isPassword: true),
                    const SizedBox(height: 20),
                    _customTextField(
                        "Konfirmasi Password", Icons.lock_outline, null,
                        isPassword: true, isConfirm: true),
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

  Widget _customTextField(
      String label, IconData icon, TextEditingController? controller,
      {bool isPassword = false, bool isEmail = false, bool isConfirm = false}) {
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
        if (isConfirm && value != _passwordTextboxController.text) {
          return "Password tidak sama";
        }
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
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 5,
        ),
        child: _isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : const Text("DAFTAR SEKARANG",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
        onPressed: () {
          if (!_isLoading) {
            var validate = _formKey.currentState!.validate();
            if (validate) _submit();
          }
        },
      ),
    );
  }

  void _submit() {
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });

    
    RegistrasiBloc.registrasi(
            nama: _namaTextboxController.text,
            email: _emailTextboxController.text,
            password: _passwordTextboxController.text)
        .then((value) {
      
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => SuccessDialog(
                description: "Registrasi berhasil, silahkan login",
                okClick: () {
                  Navigator.pop(context); 
                  Navigator.pop(context); 
                },
              ));
    }, onError: (error) {
      
      print("ERROR REGISTRASI: $error"); 
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => const WarningDialog(
                description: "Registrasi gagal, silahkan coba lagi",
              ));
    });

    setState(() {
      _isLoading = false;
    });
  }
}