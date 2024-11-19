import 'dart:convert'; // Untuk mengubah data dari JSON
import 'package:http/http.dart' as http; // Library HTTP untuk melakukan request ke server
import '../models/pasien.dart'; // Mengimpor model Pasien untuk digunakan di dalam service
import 'constant.dart'; // Mengimpor konstanta, termasuk baseUrl

class PasienService {
  static const String endpoint = '$baseUrl/pasien'; // URL endpoint untuk resource Pasien
  
  // Fungsi untuk mendapatkan data dari server
  Future<List<Pasien>> getPasien() async {
    final response = await http.get(Uri.parse(endpoint));
  
    if (response.statusCode == 200) {  
      // Jika respons berhasil, mengubah data dari JSON menjadi List objek Pasien
      final data = jsonDecode(response.body);
      final List<dynamic> pasienList = data['data'];

      return pasienList.map((json) => Pasien.fromJson(json)).toList();
    } else {
      // Jika gagal, alihkan ke Exception
      throw Exception('Failed to load data');
    }
  }

  // Fungsi untuk menambahkan data pasien baru
  Future<void> createPasien(String pasienName) async {
    final response = await http.post(
      Uri.parse(endpoint),
      headers: {
        'Content-Type': 'application/json'
      }, // Memberitahu server bahwa data berbentuk JSON
      body: jsonEncode({'pasien': pasienName}), // Mengubah data menjadi format JSON
    );

    if (response.statusCode != 201) {
      // Jika respons bukan 201 (Created), alihkan ke Exception
      throw Exception('Failed to create pasien');
    }
  }

  // Fungsi untuk memperbarui data pasien
  Future<void> updatePasien(int id, String pasienName) async {
    final response = await http.put(
      Uri.parse('$endpoint/$id'),
      headers: {
        'Content-Type': 'application/json'
      }, // Memberitahu server bahwa data berbentuk JSON
      body: jsonEncode({'pasien': pasienName}), // Mengubah data menjadi format JSON
    );

    if (response.statusCode != 200) {
      // Jika respons bukan 200 (OK), alihkan ke Exception
      throw Exception('Failed to update pasien');
    }
  }

  // Fungsi untuk menghapus data pasien
  Future<void> deletePasien(int id) async {
    final response = await http.delete(Uri.parse('$endpoint/$id'));
  
    if (response.statusCode != 200) {
      // Jika respons bukan 200 (OK), alihkan ke Exception
      throw Exception('Failed to delete pasien');
    }
  }
}