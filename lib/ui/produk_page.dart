import 'package:flutter/material.dart';
import 'package:tokokita/model/produk.dart';
import 'package:tokokita/ui/produk_detail.dart';
import 'package:tokokita/ui/produk_form.dart';

class ProdukPage extends StatefulWidget {
  const ProdukPage({Key? key}) : super(key: key);
  @override
  _ProdukPageState createState() => _ProdukPageState();
}

class _ProdukPageState extends State<ProdukPage> {
  
  final Color _primaryColor = const Color(0xFF673AB7);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7), 
      appBar: AppBar(
        
        title: Text('List Produk Firyal', 
            style: TextStyle(color: Colors.grey[900], fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: IconButton(
              icon: Icon(Icons.add_circle, size: 32, color: _primaryColor),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProdukForm()));
              },
            ),
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: _primaryColor),
              accountName: const Text("Firyal Admin"),
              accountEmail: const Text("firyal@tokokita.com"),
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Colors.white, 
                child: Icon(Icons.person, color: Colors.deepPurple)
              ),
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Logout', style: TextStyle(color: Colors.red)),
              onTap: () async {},
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: ListView(
          children: [
            
            ItemProduk(
              produk: Produk(
                id: "1", 
                kodeProduk: 'A001', 
                namaProduk: 'Kamera', 
                hargaProduk: 5000000
              )
            ),
            ItemProduk(
              produk: Produk(
                id: "2", 
                kodeProduk: 'A002', 
                namaProduk: 'Kulkas', 
                hargaProduk: 2500000
              )
            ),
            ItemProduk(
              produk: Produk(
                id: "3", 
                kodeProduk: 'A003', 
                namaProduk: 'Mesin Cuci', 
                hargaProduk: 2000000
              )
            ),
          ],
        ),
      ),
    );
  }
}

class ItemProduk extends StatelessWidget {
  final Produk produk;
  const ItemProduk({Key? key, required this.produk}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ProdukDetail(produk: produk)));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1), 
              spreadRadius: 2, 
              blurRadius: 10, 
              offset: const Offset(0, 3)
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.deepPurple[50],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: getIconForProduct(produk.namaProduk!), 
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      produk.namaProduk!,
                      style: const TextStyle(
                        fontSize: 16, 
                        fontWeight: FontWeight.bold, 
                        color: Colors.black87
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Kode: ${produk.kodeProduk}", 
                      style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Rp ${produk.hargaProduk}",
                      style: const TextStyle(
                        fontSize: 15, 
                        fontWeight: FontWeight.w700, 
                        color: Colors.black
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  "Detail", 
                  style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  
  Widget getIconForProduct(String name) {
    IconData icon;
    if (name.toLowerCase().contains('kamera')) {
      icon = Icons.camera_alt;
    } else if (name.toLowerCase().contains('kulkas')) {
      icon = Icons.kitchen;
    } else if (name.toLowerCase().contains('mesin cuci')) {
      icon = Icons.local_laundry_service;
    } else {
      icon = Icons.shopping_bag;
    }
    return Icon(icon, color: Colors.deepPurple, size: 30);
  }
}