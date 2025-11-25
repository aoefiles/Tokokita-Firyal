import 'package:flutter/material.dart';
import 'package:tokokita/model/produk.dart';
import 'package:tokokita/ui/produk_form.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tokokita/ui/login_page.dart';

// Ganti sesuai konfigurasi Anda.
const String baseURL = "http://10.0.2.2/toko-api/public"; 

// ignore: must_be_immutable
class ProdukDetail extends StatefulWidget {
  Produk? produk;
  ProdukDetail({Key? key, this.produk}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ProdukDetailState createState() => _ProdukDetailState();
}

class _ProdukDetailState extends State<ProdukDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Produk Firyal'), 
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              Text(
                "Kode: ${widget.produk!.kodeProduk}",
                style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              Text(
                "Nama: ${widget.produk!.namaProduk}",
                style: const TextStyle(fontSize: 20.0),
              ),
              const SizedBox(height: 15),
              Text(
                "Harga: Rp. ${widget.produk!.hargaProduk.toString()}",
                style: const TextStyle(fontSize: 20.0, color: Colors.green), 
              ),
              const SizedBox(height: 40),
              _tombolHapusEdit()
            ],
          ),
        ),
      ),
    );
  }

  Widget _tombolHapusEdit() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Tombol Edit
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange, 
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10)
          ),
          icon: const Icon(Icons.edit, size: 20, color: Colors.white),
          label: const Text(
            "EDIT",
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProdukForm(
                  produk: widget.produk!,
                ),
              ),
            );
          },
        ),
        const SizedBox(width: 16), 

        // Tombol Hapus
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red, 
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10)
          ),
          icon: const Icon(Icons.delete, size: 20, color: Colors.white),
          label: const Text(
            "DELETE",
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
          onPressed: () => confirmHapus(),
        ),
      ],
    );
  }

  void confirmHapus() {
    AlertDialog alertDialog = AlertDialog(
      title: const Text("Konfirmasi Hapus"),
      content: Text("Yakin ingin menghapus produk ${widget.produk!.namaProduk}?"),
      actions: [
        //tombol hapus
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          child: const Text("Ya", style: TextStyle(color: Colors.white)),
          onPressed: () {
            // Logika delete API akan ditambahkan
            Navigator.pop(context); 
          },
        ),
        //tombol batal
        OutlinedButton(
          child: const Text("Batal"),
          onPressed: () => Navigator.pop(context),
        )
      ],
    );

    showDialog(builder: (context) => alertDialog, context: context);
  }
}