import 'package:flutter/material.dart';
import 'package:tokokita/bloc/produk_bloc.dart';
import 'package:tokokita/model/produk.dart';
import 'package:tokokita/ui/produk_page.dart';
import 'package:tokokita/widget/warning_dialog.dart';

class ProdukForm extends StatefulWidget {
  Produk? produk;
  ProdukForm({Key? key, this.produk}) : super(key: key);
  @override
  _ProdukFormState createState() => _ProdukFormState();
}

class _ProdukFormState extends State<ProdukForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "Tambah Produk Firyal";
  String tombolSubmit = "SIMPAN";
  final _kodeProdukTextboxController = TextEditingController();
  final _namaProdukTextboxController = TextEditingController();
  final _hargaProdukTextboxController = TextEditingController();
  final Color _primaryColor = const Color(0xFF673AB7);

  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  isUpdate() {
    if (widget.produk != null) {
      setState(() {
        judul = "Ubah Produk Firyal";
        tombolSubmit = "UBAH";
        _kodeProdukTextboxController.text = widget.produk!.kodeProduk!;
        _namaProdukTextboxController.text = widget.produk!.namaProduk!;
        _hargaProdukTextboxController.text =
            widget.produk!.hargaProduk.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(judul,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Informasi Produk",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey)),
                const SizedBox(height: 20),
                _customTextField(
                    "Kode Produk", Icons.qr_code, _kodeProdukTextboxController),
                const SizedBox(height: 20),
                _customTextField("Nama Produk", Icons.local_offer,
                    _namaProdukTextboxController),
                const SizedBox(height: 20),
                _customTextField(
                    "Harga", Icons.attach_money, _hargaProdukTextboxController,
                    isNumber: true),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      elevation: 5,
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(tombolSubmit,
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                    onPressed: () {
                      if (!_isLoading) {
                        var validate = _formKey.currentState!.validate();
                        if (validate) {
                          if (widget.produk != null) {
                            ubah();
                          } else {
                            simpan();
                          }
                        }
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _customTextField(
      String label, IconData icon, TextEditingController controller,
      {bool isNumber = false}) {
    return TextFormField(
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: _primaryColor),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        filled: true,
        fillColor: Colors.white,
      ),
      validator: (value) => value!.isEmpty ? "$label harus diisi" : null,
    );
  }

  void simpan() {
    setState(() {
      _isLoading = true;
    });
    Produk createProduk = Produk(id: null);
    createProduk.kodeProduk = _kodeProdukTextboxController.text;
    createProduk.namaProduk = _namaProdukTextboxController.text;
    createProduk.hargaProduk = int.parse(_hargaProdukTextboxController.text);
    ProdukBloc.addProduk(produk: createProduk).then((value) {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) => const ProdukPage()));
    }, onError: (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
                description: "Simpan gagal, silahkan coba lagi",
              ));
    });
    setState(() {
      _isLoading = false;
    });
  }

  void ubah() {
    setState(() {
      _isLoading = true;
    });
    Produk updateProduk = Produk(id: widget.produk!.id!);
    updateProduk.kodeProduk = _kodeProdukTextboxController.text;
    updateProduk.namaProduk = _namaProdukTextboxController.text;
    updateProduk.hargaProduk = int.parse(_hargaProdukTextboxController.text);
    ProdukBloc.updateProduk(produk: updateProduk).then((value) {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) => const ProdukPage()));
    }, onError: (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
                description: "Permintaan ubah data gagal, silahkan coba lagi",
              ));
    });
    setState(() {
      _isLoading = false;
    });
  }
}