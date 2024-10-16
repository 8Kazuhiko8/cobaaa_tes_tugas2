import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'daftar_situs_rekomendasi.dart';
import 'stopwatch.dart';
import 'favorit.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  int _selectedIndex = 0;
  List<Map<String, String>> favorites = []; // Mengubah tipe data untuk menyimpan daftar favorit

  void _logout() async {
    await _auth.signOut();
    Navigator.of(context).pushReplacementNamed('/');
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Halaman Utama'),
        backgroundColor: Colors.brown[200], // Mengubah warna AppBar menjadi coklat muda
      ),
      body: Container(
        color: Colors.lightBlue[100], // Mengubah warna latar belakang menjadi biru muda
        child: Center(
          child: _selectedIndex == 0 ? _buildMainMenu() : HelpScreen(logoutCallback: _logout),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help),
            label: 'Bantuan',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.brown[200],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black54, // Mengubah warna item yang tidak dipilih menjadi hitam transparan
      ),
    );
  }

  Widget _buildMainMenu() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ElevatedButton(
          onPressed: () => _showMembers(context),
          child: Text('Daftar Anggota'),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            // Navigasi ke aplikasi Stopwatch
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => StopwatchScreen()), // Ganti dengan layar Stopwatch
            );
          },
          child: Text('Aplikasi Stopwatch'),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            // Navigasi ke halaman Daftar Situs Rekomendasi
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DaftarSitusRekomendasi(favorites: favorites)), // Kirim daftar favorit
            );
          },
          child: Text('Daftar Situs Rekomendasi'),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            // Navigasi ke halaman Favorit
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Favorit(favorites: favorites)), // Kirim daftar favorit
            );
          },
          child: Text('Favorit'),
        ),
      ],
    );
  }

  void _showMembers(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Daftar Anggota"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text("Dimas Rahmadhan (124220024)"),
                Text("Muhammad Salman Mahdi (12422002414)"),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }
}

class HelpScreen extends StatelessWidget {
  final VoidCallback logoutCallback;

  HelpScreen({required this.logoutCallback});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bantuan'),
        backgroundColor: Colors.brown[200],
      ),
      body: Container(
        color: Colors.lightBlue[100],
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center( // Membungkus Column dalam Center untuk memastikan semua isi berada di tengah
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Cara penggunaan aplikasi:",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Text(
                  "1. Untuk mendaftar, tekan tombol Register di halaman login.",
                  textAlign: TextAlign.center,
                ),
                Text(
                  "2. Setelah berhasil mendaftar, Anda dapat login menggunakan email dan password.",
                  textAlign: TextAlign.center,
                ),
                Text(
                  "3. Gunakan menu Daftar Anggota untuk melihat anggota.",
                  textAlign: TextAlign.center,
                ),
                Text(
                  "4. Gunakan menu Stopwatch untuk menggunakan aplikasi stopwatch.",
                  textAlign: TextAlign.center,
                ),
                Text(
                  "5. Gunakan menu daftar situs rekomendasi untuk melihat beberapa situs yang kami rekomendasikan.",
                  textAlign: TextAlign.center,
                ),
                Text(
                  "6. Gunakan menu favorit untuk melihat list favorit yang sudah ditandai pada menu sebelumnya.",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: logoutCallback,
                  child: Text('Logout'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
