class Pegawai {
  final int id; // ID Pegawai
  final String nip;
  final String nama; // Nama Pegawai
  final DateTime tanggal_lahir;
  final String nomor_telepon;
  final String email;
  final String password;
  final String createdAt; // Waktu data dibuat
  final String updatedAt; // Waktu data diperbarui

  Pegawai(
    {required this.id,
    required this.nip,
    required this.nama,
    required this.tanggal_lahir,
    required this.nomor_telepon,
    required this.email,
    required this.password,
    required this.createdAt,
    required this.updatedAt});

  // Fungsi ini untuk mengubah JSON ke dalam bentuk Pegawai
  factory Pegawai.fromJson(Map<String, dynamic> json) {
    return Pegawai(
      id: json['id'],
      nip: json['nip'],
      nama: json['nama'],
      tanggal_lahir: DateTime.parse(json['tanggal_lahir']),
      nomor_telepon: json['nomor_telepon'],
      email: json['email'],
      password: json['password'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}