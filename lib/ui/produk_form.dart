import 'package:flutter/material.dart';
import 'package:tokokita/model/produk.dart';
// import 'package:http/http.dart' as http; // Akan digunakan nanti

// Ganti sesuai konfigurasi Anda.
const String baseURL = "http://10.0.2.2/toko-api/public"; 

// ignore: must_be_immutable
class ProdukForm extends StatefulWidget {
  Produk? produk;
  ProdukForm({Key? key, this.produk}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ProdukFormState createState() => _ProdukFormState();
}

class _ProdukFormState extends State<ProdukForm> {
  final _formkey = GlobalKey<FormState>();
  bool isLoading = false;
  String judul = "TAMBAH PRODUK FIRYAL"; 
  String tombolSubmit = "SIMPAN"; 

  final _kodeProdukTextboxController = TextEditingController();
  final _namaProdukTextboxController = TextEditingController();
  final _hargaProdukTextboxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  isUpdate() {
    if (widget.produk != null) {
      setState(() {
        judul = "UBAH PRODUK FIRYAL"; 
        tombolSubmit = "UBAH";
        _kodeProdukTextboxController.text =
            widget.produk!.kodeProduk!;
        _namaProdukTextboxController.text =
            widget.produk!.namaProduk!;
        _hargaProdukTextboxController.text =
            widget.produk!.hargaProduk.toString();
      });
    } else {
      judul = "TAMBAH PRODUK FIRYAL"; 
      tombolSubmit = "SIMPAN";
    }
  }

  // Logika _submit() untuk CRUD akan ditambahkan di pertemuan selanjutnya

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(judul),
        backgroundColor: Colors.blueAccent, 
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                _kodeProdukTextField(),
                const SizedBox(height: 15),
                _namaProdukTextField(),
                const SizedBox(height: 15),
                _hargaProdukTextField(),
                const SizedBox(height: 25),
                _buttonSubmit()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _kodeProdukTextField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Kode Produk",
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.qr_code_2),
      ),
      keyboardType: TextInputType.text,
      controller: _kodeProdukTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Kode Produk harus diisi";
        }
        return null;
      },
    );
  }

  Widget _namaProdukTextField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Nama Produk",
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.inventory),
      ),
      keyboardType: TextInputType.text,
      controller: _namaProdukTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Nama Produk harus diisi";
        }
        return null;
      },
    );
  }

  Widget _hargaProdukTextField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Harga",
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.attach_money),
      ),
      keyboardType: TextInputType.number,
      controller: _hargaProdukTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Harga harus diisi";
        }
        return null;
      },
    );
  }

  Widget _buttonSubmit() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        backgroundColor: Colors.blueAccent
      ),
      child: Text(
        tombolSubmit,
        style: const TextStyle(fontSize: 16, color: Colors.white),
      ),
      onPressed: () {
        if (_formkey.currentState!.validate()) {
          setState(() {
            isLoading = true;
          });
          
        }
      },
    );
  }
}