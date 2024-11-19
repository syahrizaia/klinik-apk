import 'package:flutter/material.dart'; // Library utama untuk UI di Flutter
import '../../models/pasien.dart'; // Mengimpor model Pasien
import '../../services/pasien_service.dart'; // Mengimpor PasienService untuk operasi data

class PasienFormScreen extends StatefulWidget {
  final Pasien? pasien; // Data pasien yang mungkin diisi untuk edit

  PasienFormScreen({this.pasien});

  @override
  _PasienFormScreenState createState() => _PasienFormScreenState();
}

class _PasienFormScreenState extends State<PasienFormScreen> {
  final _formKey = GlobalKey<FormState>(); // Kunci unik untuk form
  final TextEditingController _pasienController = TextEditingController(); // Controller untuk input nama pasien

  @override
  void initState() {
    super.initState();

    if (widget.pasien != null) {
      // Jika mode edit, isi controller dengan data yang ada
      _pasienController.text = widget.pasien!.nama;
    }
  }
  
  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Jika validasi form berhasil
      if (widget.pasien == null) {
        // Jika tidak ada data pasien, tambahkan baru
        await PasienService().createPasien(_pasienController.text);
      } else {
        // Jika ada data pasien, lakukan update
        await PasienService().updatePasien(widget.pasien!.id, _pasienController.text);
      }
      Navigator.pop(context); // Kembali ke layar sebelumnya setelah submit
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pasien == null ? 'Add Pasien' : 'Edit Pasien'), // Menampilkan judul sesuai mode (tambah/edit)
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _pasienController,
                decoration: InputDecoration(labelText: 'Nama Pasien'), // Input untuk nama pasien
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name for the Pasien'; // Validasi input kosong
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm, // Tombol submit
                child: Text(widget.pasien == null ? 'Create' : 'Update'), // Menampilkan teks tombol sesuai mode
              ),
            ],
          ),
        ),
      ),
    );
  }
}