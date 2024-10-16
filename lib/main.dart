import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'home_screen.dart';
import 'daftar_situs_rekomendasi.dart';
import 'register_screen.dart';
import 'favorit.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyBxYvTEz_pCKp7qGvsP5E7ryyufxmefMqg",
      authDomain: "tugas2-6b646.firebaseapp.com",
      projectId: "tugas2-6b646",
      storageBucket: "tugas2-6b646.appspot.com",
      messagingSenderId: "1097326285361",
      appId: "1:1097326285361:web:79d8df32e532b45e6ffb10",
      measurementId: "G-Q3YFL6M4ZD",
    ),
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(), // Halaman login
        '/home': (context) => HomeScreen(), // Halaman utama
        '/register': (context) => RegisterScreen(), // Halaman registrasi
      },
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/daftarSitus':
            final args = settings.arguments as List<Map<String, String>>;
            return MaterialPageRoute(
              builder: (context) => DaftarSitusRekomendasi(favorites: args),
            );
          case '/favorit':
            final args = settings.arguments as List<Map<String, String>>;
            return MaterialPageRoute(
              builder: (context) => Favorit(favorites: args),
            );
          default:
            return null;
        }
      },
    );
  }
}
