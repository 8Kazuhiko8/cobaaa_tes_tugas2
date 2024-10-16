import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  void _register() async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      // Tampilkan pop-up saat registrasi berhasil
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Registrasi Berhasil!"),
            content: Text("Akun Anda telah berhasil dibuat."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Tutup dialog
                  Navigator.of(context).pop(); // Kembali ke halaman login
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      // Menampilkan pesan kesalahan
      String message;
      if (e.code == 'weak-password') {
        message = 'Password yang Anda masukkan terlalu lemah.';
      } else if (e.code == 'email-already-in-use') {
        message = 'Email sudah terdaftar.';
      } else {
        message = 'Terjadi kesalahan: ${e.message}';
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        backgroundColor: Colors.brown[200], // Mengubah warna AppBar menjadi coklat muda
      ),
      body: Container(
        color: Colors.lightBlue[100], // Mengubah warna latar belakang menjadi biru muda
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Align to center vertically
          children: <Widget>[
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _register,
              child: Text('Register'),
            ),
            SizedBox(height: 20), // Add spacing between buttons
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Kembali ke halaman login
              },
              child: Text('Sudah punya akun? Masuk'),
            ),
          ],
        ),
      ),
    );
  }
}
