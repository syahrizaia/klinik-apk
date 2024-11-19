class Pasien {
  final int id; // ID Pasien
  final int nomor_rm;
  final String nama; // Nama Pasien
  final DateTime tanggal_lahir;
  final String nomor_telepon;
  final String alamat;
  final String createdAt; // Waktu data dibuat
  final String updatedAt; // Waktu data diperbarui

  Pasien(
    {required this.id,
    required this.nomor_rm,
    required this.nama,
    required this.tanggal_lahir,
    required this.nomor_telepon,
    required this.alamat,
    required this.createdAt,
    required this.updatedAt});

  // Fungsi ini untuk mengubah JSON ke dalam bentuk Pasien
  factory Pasien.fromJson(Map<String, dynamic> json) {
    return Pasien(
      id: json['id'],
      nomor_rm: json['nomor_rm'],
      nama: json['nama'],
      tanggal_lahir: DateTime.parse(json['tanggal_lahir']),
      nomor_telepon: json['nomor_telepon'],
      alamat: json['alamat'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}