import 'package:flutter/material.dart'; // Library utama untuk UI di Flutter
import '../../models/pasien.dart'; // Mengimpor model Pasien
import '../../services/pasien_service.dart'; // Mengimpor PasienService untuk operasi data
import '../../sidebar.dart'; // Mengimpor Sidebar untuk navigasi aplikasi

class PasienListScreen extends StatefulWidget {
  @override
  _PasienListScreenState createState() => _PasienListScreenState();
}

class _PasienListScreenState extends State<PasienListScreen> {
  List<Pasien> _pasienList = []; // List untuk menyimpan data Pasien
  bool _isLoading = true; // Status untuk menampilkan loading

  @override
  void initState() {
    super.initState();
    _loadPasienData(); // Memuat data Pasien saat inisialisasi
  }

  Future<void> _loadPasienData() async {
    setState(() {
      _isLoading = true; // Mengubah status menjadi loading
    });
    
    try {
      _pasienList = await PasienService().getPasien(); // Mendapatkan data Pasien dari server
    } catch (e) {
      _showErrorDialog(e.toString()); // Menampilkan pesan error jika gagal
    } finally {
      setState(() {
        _isLoading = false; // Mengubah status menjadi tidak loading
      });
    }
  }

  void _deletePasien(int id) async {
    bool? confirmDelete = await _showDeleteConfirmation();
    if (confirmDelete == true) {
      try {
        await PasienService().deletePasien(id); // Menghapus data Pasien
        _loadPasienData(); // Memperbarui data setelah penghapusan
      } catch (e) {
        _showErrorDialog(e.toString()); // Menampilkan pesan error jika gagal
      }
    }
  }

  Future<bool?> _showDeleteConfirmation() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Konfirmasi Hapus'),
        content: Text('Apakah Anda yakin ingin menghapus data ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('Tidak'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Ya'),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Pasien'), // Judul AppBar
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, '/add-pasien').then((value) => _loadPasienData()); // Memuat ulang data setelah penambahan
            },
          ),
        ],
      ),
      drawer: Sidebar(), // Menampilkan drawer navigasi
      body: _isLoading
        ? Center(child: CircularProgressIndicator()) // Menampilkan loading jika data sedang dimuat
        : _pasienList.isEmpty
          ? Center(child: Text('No data found')) // Menampilkan pesan jika data kosong
          : ListView.builder(
            itemCount: _pasienList.length,
            itemBuilder: (context, index) {
              final pasien = _pasienList[index];
              return Card(
                child: ListTile(
                  title: Text(pasien.nama), // Menampilkan nama Pasien
                  subtitle: Text('ID: ${pasien.id}'), // Menampilkan ID Pasien
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          Navigator.pushNamed(context, '/edit-pasien', arguments: pasien).then((value) => _loadPasienData()); // Memuat ulang data setelah edit
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _deletePasien(pasien.id), // Menghapus Pasien
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
    );
  }
}