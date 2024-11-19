import 'package:flutter/material.dart'; // Library utama untuk UI di Flutter
import '../../models/pegawai.dart'; // Mengimpor model Pegawai
import '../../services/pegawai_service.dart'; // Mengimpor PegawaiService untuk operasi data
import '../../sidebar.dart'; // Mengimpor Sidebar untuk navigasi aplikasi

class PegawaiListScreen extends StatefulWidget {
  @override
  _PegawaiListScreenState createState() => _PegawaiListScreenState();
}

class _PegawaiListScreenState extends State<PegawaiListScreen> {
  List<Pegawai> _pegawaiList = []; // List untuk menyimpan data Pegawai
  bool _isLoading = true; // Status untuk menampilkan loading

  @override
  void initState() {
    super.initState();
    _loadPegawaiData(); // Memuat data Pegawai saat inisialisasi
  }

  Future<void> _loadPegawaiData() async {
    setState(() {
      _isLoading = true; // Mengubah status menjadi loading
    });
    
    try {
      _pegawaiList = await PegawaiService().getPegawai(); // Mendapatkan data Pegawai dari server
    } catch (e) {
      _showErrorDialog(e.toString()); // Menampilkan pesan error jika gagal
    } finally {
      setState(() {
        _isLoading = false; // Mengubah status menjadi tidak loading
      });
    }
  }

  void _deletePegawai(int id) async {
    bool? confirmDelete = await _showDeleteConfirmation();
    if (confirmDelete == true) {
      try {
        await PegawaiService().deletePegawai(id); // Menghapus data Pegawai
        _loadPegawaiData(); // Memperbarui data setelah penghapusan
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
        title: Text('List Pegawai'), // Judul AppBar
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, '/add-pegawai').then((value) => _loadPegawaiData()); // Memuat ulang data setelah penambahan
            },
          ),
        ],
      ),
      drawer: Sidebar(), // Menampilkan drawer navigasi
      body: _isLoading
        ? Center(child: CircularProgressIndicator()) // Menampilkan loading jika data sedang dimuat
        : _pegawaiList.isEmpty
          ? Center(child: Text('No data found')) // Menampilkan pesan jika data kosong
          : ListView.builder(
            itemCount: _pegawaiList.length,
            itemBuilder: (context, index) {
              final pegawai = _pegawaiList[index];
              return Card(
                child: ListTile(
                  title: Text(pegawai.nama), // Menampilkan nama Pegawai
                  subtitle: Text('ID: ${pegawai.id}'), // Menampilkan ID Pegawai
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          Navigator.pushNamed(context, '/edit-pegawai', arguments: pegawai).then((value) => _loadPegawaiData()); // Memuat ulang data setelah edit
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _deletePegawai(pegawai.id), // Menghapus Pegawai
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