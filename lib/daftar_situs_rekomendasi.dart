import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DaftarSitusRekomendasi extends StatefulWidget {
  final List<Map<String, String>> favorites; // Menyimpan daftar favorit

  DaftarSitusRekomendasi({required this.favorites}); // Konstruktor dengan parameter favorites

  @override
  _DaftarSitusRekomendasiState createState() => _DaftarSitusRekomendasiState();
}

class _DaftarSitusRekomendasiState extends State<DaftarSitusRekomendasi> {
  // Daftar situs web yang akan ditampilkan
  final List<Map<String, String>> _sites = [
    {
      'title': 'Flutter',
      'url': 'https://flutter.dev',
      'image': 'https://cdn.worldvectorlogo.com/logos/flutter.svg',
    },
    {
      'title': 'Dart',
      'url': 'https://dart.dev',
      'image': 'https://upload.wikimedia.org/wikipedia/commons/7/7e/Dart-logo.png',
    },
    {
      'title': 'Firebase',
      'url': 'https://firebase.google.com',
      'image': 'https://firebase.google.com/images/brand-guidelines/logo-vertical.png',
    },
    {
      'title': 'Stack Overflow',
      'url': 'https://stackoverflow.com',
      'image': 'https://cdn.sstatic.net/Sites/stackoverflow/company/img/logos/so/so-logo.svg?v=9c558ec15d8a',
    },
  ];

  // Fungsi untuk membuka tautan di browser
  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Situs Rekomendasi'),
        backgroundColor: Colors.brown[200],
      ),
      body: Container(
        color: Colors.lightBlue[100],
        child: ListView.builder(
          itemCount: _sites.length,
          itemBuilder: (context, index) {
            final site = _sites[index];
            final isFavorite = widget.favorites.any((fav) => fav['title'] == site['title']); // Cek apakah situs adalah favorit

            return Card(
              margin: EdgeInsets.all(10),
              child: ListTile(
                contentPadding: EdgeInsets.all(10),
                leading: Image.network(
                  site['image']!,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                  loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                            : null,
                      ),
                    );
                  },
                  errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                    return Icon(Icons.error); // Tampilkan ikon error jika gambar gagal dimuat
                  },
                ),
                title: Text(site['title']!),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : null, // Mengubah warna tombol favorit
                      ),
                      onPressed: () {
                        setState(() {
                          if (isFavorite) {
                            // Jika sudah favorit, hapus dari daftar favorit
                            widget.favorites.removeWhere((fav) => fav['title'] == site['title']);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('${site['title']} dihapus dari favorit')),
                            );
                          } else {
                            // Jika belum favorit, tambahkan ke daftar favorit
                            widget.favorites.add({
                              'title': site['title']!,
                              'url': site['url']!,
                              'image': site['image']!,
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('${site['title']} ditambahkan ke favorit')),
                            );
                          }
                        });
                      },
                    ),
                    Icon(Icons.arrow_forward),
                  ],
                ),
                onTap: () => _launchURL(site['url']!), // Membuka tautan saat di-tap
              ),
            );
          },
        ),
      ),
    );
  }
}
