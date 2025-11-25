import 'package:flutter/material.dart';
import 'package:tokokita/model/produk.dart';
import 'package:tokokita/ui/produk_detail.dart';
import 'package:tokokita/ui/produk_form.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tokokita/ui/login_page.dart';

class ProdukPage extends StatefulWidget {
  const ProdukPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ProdukPageState createState() => _ProdukPageState();
}

class _ProdukPageState extends State<ProdukPage> {
  // Fungsi Logout (tanpa helper)
  void _logout() async {
    final pref = await SharedPreferences.getInstance();
    await pref.clear();
    
    // Kembali ke halaman Login
    // ignore: use_build_context_synchronously
    Navigator.pushAndRemoveUntil(
      context, 
      MaterialPageRoute(builder: (context) => const LoginPage()), 
      (route) => false // Menghapus semua rute sebelumnya
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Produk Firyal'),
        backgroundColor: Colors.blueAccent, 
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              child: const Icon(Icons.add_circle, size: 28.0, color: Colors.white),
              onTap: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProdukForm()));
              },
            ),
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const UserAccountsDrawerHeader( 
              accountName: Text("Firyal", style: TextStyle(fontWeight: FontWeight.bold)), 
              accountEmail: Text("firyal@toko.kita"),
              decoration: BoxDecoration(color: Colors.blueAccent),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () => _logout(),
            )
          ],
        ),
      ),
      // DATA LIST STATIS SESUAI MODUL
      body: ListView( 
        children: [
          ItemProduk(
            produk: Produk(
              id: '1', 
              kodeProduk: 'A001',
              namaProduk: 'Kamera',
              hargaProduk: 5000000,
            ),
          ),
          const Divider(height: 1, thickness: 1), 
          ItemProduk(
            produk: Produk(
              id: '2',
              kodeProduk: 'A002',
              namaProduk: 'Kulkas',
              hargaProduk: 2500000,
            ),
          ),
          const Divider(height: 1, thickness: 1),
          ItemProduk(
            produk: Produk(
              id: '3',
              kodeProduk: 'A003',
              namaProduk: 'Mesin Cuci',
              hargaProduk: 2000000,
            ),
          ),
          const Divider(height: 1, thickness: 1),
        ],
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
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProdukDetail(
              produk: produk,
            ),
          ),
        );
      },
      child: Card(
        elevation: 0, 
        margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0), 
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          title: Text(
            produk.namaProduk!,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18), 
          ),
          subtitle: Text(
            "Rp. ${produk.hargaProduk.toString()}", 
            style: const TextStyle(color: Colors.green, fontWeight: FontWeight.w500),
          ),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        ),
      ),
    );
  }
}