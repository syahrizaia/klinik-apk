import 'dart:convert'; // Untuk mengubah data dari JSON
import 'package:http/http.dart' as http; // Library HTTP untuk melakukan request ke server
import '../models/pegawai.dart'; // Mengimpor model Pegawai untuk digunakan di dalam service
import 'constant.dart'; // Mengimpor konstanta, termasuk baseUrl

class PegawaiService {
  static const String endpoint = '$baseUrl/pegawai'; // URL endpoint untuk resource Pegawai
  
  // Fungsi untuk mendapatkan data dari server
  Future<List<Pegawai>> getPegawai() async {
    final response = await http.get(Uri.parse(endpoint));
  
    if (response.statusCode == 200) {  
      // Jika respons berhasil, mengubah data dari JSON menjadi List objek Pegawai
      final data = jsonDecode(response.body);
      final List<dynamic> pegawaiList = data['data'];

      return pegawaiList.map((json) => Pegawai.fromJson(json)).toList();
    } else {
      // Jika gagal, alihkan ke Exception
      throw Exception('Failed to load data');
    }
  }

  // Fungsi untuk menambahkan data pegawai baru
  Future<void> createPegawai(String pegawaiName) async {
    final response = await http.post(
      Uri.parse(endpoint),
      headers: {
        'Content-Type': 'application/json'
      }, // Memberitahu server bahwa data berbentuk JSON
      body: jsonEncode({'pegawai': pegawaiName}), // Mengubah data menjadi format JSON
    );

    if (response.statusCode != 201) {
      // Jika respons bukan 201 (Created), alihkan ke Exception
      throw Exception('Failed to create pegawai');
    }
  }

  // Fungsi untuk memperbarui data pegawai
  Future<void> updatePegawai(int id, String pegawaiName) async {
    final response = await http.put(
      Uri.parse('$endpoint/$id'),
      headers: {
        'Content-Type': 'application/json'
      }, // Memberitahu server bahwa data berbentuk JSON
      body: jsonEncode({'pegawai': pegawaiName}), // Mengubah data menjadi format JSON
    );

    if (response.statusCode != 200) {
      // Jika respons bukan 200 (OK), alihkan ke Exception
      throw Exception('Failed to update pegawai');
    }
  }

  // Fungsi untuk menghapus data pegawai
  Future<void> deletePegawai(int id) async {
    final response = await http.delete(Uri.parse('$endpoint/$id'));
  
    if (response.statusCode != 200) {
      // Jika respons bukan 200 (OK), alihkan ke Exception
      throw Exception('Failed to delete pegawai');
    }
  }
}