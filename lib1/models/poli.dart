class Poli {
  final int id; // ID Poli
  final String poli; // Nama Poli
  final String createdAt; // Waktu data dibuat
  final String updatedAt; // Waktu data diperbarui

  Poli(
    {required this.id,
    required this.poli,
    required this.createdAt,
    required this.updatedAt});

  // Fungsi ini untuk mengubah JSON ke dalam bentuk Poli
  factory Poli.fromJson(Map<String, dynamic> json) {
    return Poli(
      id: json['id'],
      poli: json['poli'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}