import 'package:flutter/material.dart';
import 'package:syahreza_ia/models/pasien.dart';
import 'package:syahreza_ia/models/pegawai.dart';
import 'package:syahreza_ia/screens/pasien/pasien_form_screen.dart';
import 'package:syahreza_ia/screens/pegawai/pegawai_form_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/poli/poli_list_screen.dart';
import 'screens/poli/poli_form_screen.dart';
import 'models/poli.dart';

void main() {
  runApp(MyApp());
}

// Ini adalah widget utama dari aplikasi.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Klinik App',
      theme: ThemeData(
        primarySwatch: Colors.blue, // Mengatur tema warna aplikasi
      ),
      initialRoute: '/', // Mengatur rute awal aplikasi
      routes: {
        '/': (context) => HomeScreen(),
        '/list-poli': (context) => PoliListScreen(), // Rute untuk menampilkan daftar poli (Read)
        '/add-poli': (context) => PoliFormScreen(), // Rute untuk form menambah Poli (Create)
        '/edit-poli': (context) => PoliFormScreen(poli: ModalRoute.of(context)?.settings.arguments as Poli?), // Rute untuk form edit Poli (Update)
        '/add-pasien': (context) => PasienFormScreen(),
        '/edit-pasien': (context) => PasienFormScreen(pasien: ModalRoute.of(context)?.settings.arguments as Pasien?),
        '/add-pegawai': (context) => PegawaiFormScreen(),
        '/edit-pegawai': (context) => PegawaiFormScreen(pegawai: ModalRoute.of(context)?.settings.arguments as Pegawai?)
      },
    );
  }
}