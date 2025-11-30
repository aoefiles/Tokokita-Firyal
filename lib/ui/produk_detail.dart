import 'package:flutter/material.dart';
import 'package:tokokita/model/produk.dart';
import 'package:tokokita/ui/produk_form.dart';

class ProdukDetail extends StatefulWidget {
  Produk? produk;
  ProdukDetail({Key? key, this.produk}) : super(key: key);
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
        title: const Text('Detail Produk Firyal', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
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
                child: Icon(Icons.shopping_bag_outlined, size: 150, color: _primaryColor.withOpacity(0.5)),
              ),
            ),
          ),
         
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(30),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 20, offset: Offset(0, -5))],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          widget.produk!.namaProduk!,
                          style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ),
                      Text(
                        "Rp ${widget.produk!.hargaProduk}",
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: _primaryColor),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text("Kode: ${widget.produk!.kodeProduk}", style: TextStyle(color: Colors.grey[500], fontSize: 16)),
                  const SizedBox(height: 30),
                  const Text("Description", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Text(
                    "Produk Berkualitas. Harga Bersahabat",
                    style: TextStyle(color: Colors.grey[600], height: 1.5),
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

  Widget _tombolAksi() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 15),
              side: BorderSide(color: _primaryColor),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            ),
            child: Text("EDIT", style: TextStyle(color: _primaryColor, fontWeight: FontWeight.bold)),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ProdukForm(produk: widget.produk!)));
            },
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 15),
              backgroundColor: Colors.redAccent,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            ),
            child: const Text("DELETE", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            onPressed: () => confirmHapus(),
          ),
        ),
      ],
    );
  }

  void confirmHapus() {
    AlertDialog alertDialog = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: const Text("Hapus Produk?", style: TextStyle(fontWeight: FontWeight.bold)),
      content: const Text("Yakin ingin menghapus data ini?"),
      actions: [
        TextButton(child: const Text("Batal"), onPressed: () => Navigator.pop(context)),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
          child: const Text("Hapus", style: TextStyle(color: Colors.white)),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => ProdukForm(produk: widget.produk!))); // Dummy Action
          },
        )
      ],
    );
    showDialog(builder: (context) => alertDialog, context: context);
  }
}