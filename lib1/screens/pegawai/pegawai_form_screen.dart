import 'package:flutter/material.dart'; // Library utama untuk UI di Flutter
import '../../models/pegawai.dart'; // Mengimpor model Pegawai
import '../../services/pegawai_service.dart'; // Mengimpor PegawaiService untuk operasi data

class PegawaiFormScreen extends StatefulWidget {
  final Pegawai? pegawai; // Data pegawai yang mungkin diisi untuk edit

  PegawaiFormScreen({this.pegawai});

  @override
  _PegawaiFormScreenState createState() => _PegawaiFormScreenState();
}

class _PegawaiFormScreenState extends State<PegawaiFormScreen> {
  final _formKey = GlobalKey<FormState>(); // Kunci unik untuk form
  final TextEditingController _pegawaiController = TextEditingController(); // Controller untuk input nama pegawai

  @override
  void initState() {
    super.initState();

    if (widget.pegawai != null) {
      // Jika mode edit, isi controller dengan data yang ada
      _pegawaiController.text = widget.pegawai!.nama;
    }
  }
  
  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Jika validasi form berhasil
      if (widget.pegawai == null) {
        // Jika tidak ada data pegawai, tambahkan baru
        await PegawaiService().createPegawai(_pegawaiController.text);
      } else {
        // Jika ada data pegawai, lakukan update
        await PegawaiService().updatePegawai(widget.pegawai!.id, _pegawaiController.text);
      }
      Navigator.pop(context); // Kembali ke layar sebelumnya setelah submit
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pegawai == null ? 'Add Pegawai' : 'Edit Pegawai'), // Menampilkan judul sesuai mode (tambah/edit)
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _pegawaiController,
                decoration: InputDecoration(labelText: 'Nama Pegawai'), // Input untuk nama pegawai
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name for the Pegawai'; // Validasi input kosong
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm, // Tombol submit
                child: Text(widget.pegawai == null ? 'Create' : 'Update'), // Menampilkan teks tombol sesuai mode
              ),
            ],
          ),
        ),
      ),
    );
  }
}