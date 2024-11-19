import 'package:flutter/material.dart';
// import 'screens/home/home_screen.dart';
// import 'screens/poli/poli_list_screen.dart';

class Sidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _createDrawerHeader(),
          _createDrawerItem(
            icon: Icons.home,
            text: 'Home',
            onTap: () => Navigator.pushNamed(context, '/'), // Navigasi ke halaman Home
          ),
          _createDrawerItem(
            icon: Icons.local_hospital,
            text: 'Poli',
            onTap: () => Navigator.pushNamed(context, '/list-poli'), // Navigasi ke halaman daftar Poli
          ),
          _createDrawerItem(
            icon: Icons.people,
            text: 'Pegawai',
            onTap: () => Navigator.pushNamed(context, '/list-pegawai'), // Navigasi ke halaman daftar Pegawai (sementara menggunakan rute Poli)
          ),
          _createDrawerItem(
            icon: Icons.person,
            text: 'Pasien',
            onTap: () => Navigator.pushNamed(context, '/list-pasien'), // Navigasi ke halaman daftar Pasien (sementara menggunakan rute Poli)
          ),
        ],
      ),
    );
  }

  // Membuat header untuk drawer
  Widget _createDrawerHeader() {
    return DrawerHeader(
      decoration: BoxDecoration(
        color: Colors.blue, // Memberikan warna biru pada header
      ),
      child: Text(
        'Klinik App', // Teks judul pada header
        style: TextStyle(
          color: Colors.white, // Warna teks putih
          fontSize: 24, // Ukuran font teks
        ),
      ),
    );
  }

  // Membuat item di dalam drawer
  Widget _createDrawerItem({required IconData icon, required String text, required GestureTapCallback onTap}) {
    return ListTile(
      leading: Icon(icon), // Ikon yang ditampilkan di depan teks
      title: Text(text), // Teks yang ditampilkan pada item
      onTap: onTap, // Fungsi yang dijalankan ketika item ditekan
    );
  }
}