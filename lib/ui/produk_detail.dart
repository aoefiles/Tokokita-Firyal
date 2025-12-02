import 'package:flutter/material.dart';
import 'package:tokokita/bloc/produk_bloc.dart';
import 'package:tokokita/model/produk.dart';
import 'package:tokokita/ui/produk_form.dart';
import 'package:tokokita/ui/produk_page.dart';
import 'package:tokokita/widget/warning_dialog.dart';

class ProdukDetail extends StatefulWidget {
  final Produk? produk;
  const ProdukDetail({Key? key, this.produk}) : super(key: key);
  @override
  _ProdukDetailState createState() => _ProdukDetailState();
}

class _ProdukDetailState extends State<ProdukDetail> {
  final Color _primaryColor = const Color(0xFF673AB7);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      appBar: AppBar(
        title: const Text('Detail Produk Firyal',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 250,
            child: Center(
              child: Hero(
                tag: widget.produk!.id!,
                child: _getIconForProduct(widget.produk!.namaProduk!),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(30),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 20,
                      offset: Offset(0, -5))
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          widget.produk!.namaProduk!,
                          style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      Text(
                        "Rp ${widget.produk!.hargaProduk}",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: _primaryColor),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text("Kode: ${widget.produk!.kodeProduk}",
                        style:
                            TextStyle(color: Colors.grey[600], fontSize: 14)),
                  ),
                  const SizedBox(height: 30),
                  const Text("Deskripsi Produk",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Text(
                    _getDescription(widget.produk!.namaProduk!),
                    style: TextStyle(
                        color: Colors.grey[600], height: 1.5, fontSize: 15),
                    textAlign: TextAlign.justify,
                  ),
                  const Spacer(),
                  _tombolAksi()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getIconForProduct(String name) {
    IconData icon;
    if (name.toLowerCase().contains('kamera')) {
      icon = Icons.camera_alt;
    } else if (name.toLowerCase().contains('kulkas')) {
      icon = Icons.kitchen;
    } else if (name.toLowerCase().contains('mesin cuci')) {
      icon = Icons.local_laundry_service;
    } else {
      icon = Icons.shopping_bag_outlined;
    }
    return Icon(icon, size: 150, color: _primaryColor.withOpacity(0.8));
  }

  String _getDescription(String name) {
    if (name.toLowerCase().contains('kamera')) {
      return "Abadikan momen terbaik Anda dengan Kamera Digital resolusi tinggi ini. Dilengkapi fitur autofocus cepat, lensa tajam, dan kemampuan merekam video 4K.";
    } else if (name.toLowerCase().contains('kulkas')) {
      return "Lemari es 2 pintu dengan teknologi pendingin mutakhir yang hemat energi. Menjaga kesegaran makanan dan sayuran lebih lama.";
    } else if (name.toLowerCase().contains('mesin cuci')) {
      return "Mesin cuci otomatis dengan kapasitas besar dan teknologi peredam suara. Membersihkan noda membandel secara efektif.";
    } else {
      return "Produk berkualitas tinggi dari TokoKita Firyal yang siap memenuhi kebutuhan harian Anda.";
    }
  }

  Widget _tombolAksi() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 15),
              side: BorderSide(color: _primaryColor),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
            ),
            child: Text("UBAH",
                style: TextStyle(
                    color: _primaryColor, fontWeight: FontWeight.bold)),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ProdukForm(produk: widget.produk!)));
            },
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 15),
              backgroundColor: Colors.redAccent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
            ),
            child: const Text("HAPUS",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
            onPressed: () => confirmHapus(),
          ),
        ),
      ],
    );
  }

  void confirmHapus() {
    AlertDialog alertDialog = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: const Text("Hapus Produk?",
          style: TextStyle(fontWeight: FontWeight.bold)),
      content: const Text("Yakin ingin menghapus data ini secara permanen?"),
      actions: [
        TextButton(
            child: const Text("Batal", style: TextStyle(color: Colors.grey)),
            onPressed: () => Navigator.pop(context)),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
          child: const Text("Hapus", style: TextStyle(color: Colors.white)),
          onPressed: () {
            ProdukBloc.deleteProduk(id: int.parse(widget.produk!.id!)).then(
                (value) => {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ProdukPage()))
                    }, onError: (error) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => const WarningDialog(
                        description: "Hapus gagal, silahkan coba lagi",
                      ));
            });
          },
        )
      ],
    );
    showDialog(builder: (context) => alertDialog, context: context);
  }
}