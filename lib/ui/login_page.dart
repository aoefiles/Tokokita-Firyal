import 'package:flutter/material.dart';
import 'package:tokokita/ui/registrasi_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  final _emailTextboxController = TextEditingController();
  final _passwordTextboxController = TextEditingController();

  final Color _primaryColor = const Color(0xFF673AB7); 
  final Color _accentColor = const Color(0xFF9575CD); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 250,
              decoration: BoxDecoration(
                color: _primaryColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.shopping_bag_outlined, size: 80, color: Colors.white),
                    const SizedBox(height: 10),
                    const Text(
                      "TokoKita Firyal",
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Text(
                          "Login Firyal",
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: _primaryColor),
                        ),
                        const SizedBox(height: 30),
                        _emailTextField(),
                        const SizedBox(height: 20),
                        _passwordTextField(),
                        const SizedBox(height: 30),
                        _buttonLogin(),
                        const SizedBox(height: 20),
                        _menuRegistrasi()
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _emailTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Email",
        prefixIcon: Icon(Icons.email, color: _primaryColor),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        filled: true,
        fillColor: Colors.purple.withOpacity(0.05),
      ),
      keyboardType: TextInputType.emailAddress,
      controller: _emailTextboxController,
      validator: (value) {
        if (value!.isEmpty) return 'Email harus diisi';
        return null;
      },
    );
  }

  Widget _passwordTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Password",
        prefixIcon: Icon(Icons.lock, color: _primaryColor),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        filled: true,
        fillColor: Colors.purple.withOpacity(0.05),
      ),
      obscureText: true,
      controller: _passwordTextboxController,
      validator: (value) {
        if (value!.isEmpty) return "Password harus diisi";
        return null;
      },
    );
  }

  Widget _buttonLogin() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: _primaryColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 5,
        ),
        child: const Text("LOGIN", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
        onPressed: () {
          var validate = _formKey.currentState!.validate();
        },
      ),
    );
  }

  Widget _menuRegistrasi() {
    return Center(
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const RegistrasiPage()));
        },
        child: Text(
          "Belum punya akun? Daftar disini",
          style: TextStyle(color: _primaryColor, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}