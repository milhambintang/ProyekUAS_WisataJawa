import 'package:cloud_firestore/cloud_firestore.dart';

class Wisata { // Model untuk data wisata
  final String id;
  final String nama;
  final String deskripsi;
  final String provinsi;
  final String kota;
  final String gambar; // Base64 encoded image
  final double rating;
  final DateTime createdAt;
  final String createdBy; // UID user

  Wisata({ // Konstruktor untuk Wisata
    required this.id,
    required this.nama,
    required this.deskripsi,
    required this.provinsi,
    required this.kota,
    required this.gambar,
    required this.rating,
    required this.createdAt,
    required this.createdBy,
  });

  // Factory method untuk membuat Wisata dari Firestore DocumentSnapshot
  factory Wisata.fromFirestore(DocumentSnapshot doc) { 
    final data = doc.data() as Map<String, dynamic>;
    return Wisata(
      id: doc.id,
      nama: data['nama'] ?? '',
      deskripsi: data['deskripsi'] ?? '',
      provinsi: data['provinsi'] ?? '',
      kota: data['kota'] ?? '',
      gambar: data['gambar'] ?? '',
      rating: (data['rating'] ?? 0).toDouble(),
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      createdBy: data['createdBy'] ?? '',
    );
  }

  // Method untuk mengubah Wisata menjadi Map untuk disimpan ke Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'nama': nama,
      'deskripsi': deskripsi,
      'provinsi': provinsi,
      'kota': kota,
      'gambar': gambar,
      'rating': rating,
      'createdAt': Timestamp.fromDate(createdAt),
      'createdBy': createdBy,
    };
  }

  // Method untuk membuat salinan Wisata dengan beberapa field yang diubah
  Wisata copyWith({
    String? id,
    String? nama,
    String? deskripsi,
    String? provinsi,
    String? kota,
    String? gambar,
    double? rating,
    DateTime? createdAt,
    String? createdBy,
  }) {
    return Wisata( // Membuat salinan Wisata dengan field yang diubah jika diberikan, atau tetap menggunakan nilai lama
      id: id ?? this.id,
      nama: nama ?? this.nama,
      deskripsi: deskripsi ?? this.deskripsi,
      provinsi: provinsi ?? this.provinsi,
      kota: kota ?? this.kota,
      gambar: gambar ?? this.gambar,
      rating: rating ?? this.rating,
      createdAt: createdAt ?? this.createdAt,
      createdBy: createdBy ?? this.createdBy,
    );
  }
}
