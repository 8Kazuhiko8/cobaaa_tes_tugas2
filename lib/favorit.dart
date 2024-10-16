import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Favorit extends StatelessWidget {
  final List<Map<String, String>> favorites; // Mengubah tipe data untuk menyimpan informasi lengkap

  Favorit({required this.favorites}); // Konstruktor dengan parameter favorites

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorit'),
        backgroundColor: Colors.brown[200],
      ),
      body: Container(
        color: Colors.lightBlue[100], // Mengubah warna latar belakang menjadi biru muda
        child: favorites.isNotEmpty
            ? ListView.builder(
          itemCount: favorites.length,
          itemBuilder: (context, index) {
            final favorite = favorites[index]; // Ambil detail favorit
            return Card(
              margin: EdgeInsets.all(10),
              child: ListTile(
                contentPadding: EdgeInsets.all(10),
                leading: Image.network(
                  favorite['image']!,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
                title: Text(favorite['title']!), // Menampilkan judul
                onTap: () {
                  // Logika untuk membuka tautan
                  launchURL(favorite['url']!);
                },
              ),
            );
          },
        )
            : Center(
          child: Text('Belum ada favorit ditambahkan.'),
        ),
      ),
    );
  }

  void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
