import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wisata_jawa/models/wisata.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // ============================================
  // WISATA CRUD
  // ============================================

  // Daftar provinsi di Pulau Jawa
  static const List<String> provinsiList = [
    'Banten',
    'DKI Jakarta',
    'Jawa Barat',
    'Jawa Tengah',
    'DI Yogyakarta',
    'Jawa Timur',
  ];

  // Tambah wisata baru
  Future<String> addWisata(Wisata wisata) async {
    final docRef = await _db.collection('wisata').add(wisata.toFirestore());
    return docRef.id;
  }

  // Update wisata
  Future<void> updateWisata(Wisata wisata) async {
    await _db.collection('wisata').doc(wisata.id).update(wisata.toFirestore());
  }

  // Hapus wisata beserta favorit user yang menghapus
  // Favorit user lain akan di-cleanup otomatis oleh getFavoriteWisata
  Future<void> deleteWisata(String wisataId, {String? userId}) async {
    final batch = _db.batch();

    // Hapus dokumen wisata
    batch.delete(_db.collection('wisata').doc(wisataId));

    // Hapus juga dari favorit user yang menghapus
    if (userId != null) {
      batch.delete(
        _db.collection('users').doc(userId).collection('favorites').doc(wisataId),
      );
    }

    await batch.commit();
  }

  // Get semua wisata (stream real-time)
  Stream<List<Wisata>> getSemuaWisata() {
    return _db
        .collection('wisata')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Wisata.fromFirestore(doc)).toList());
  }

  // Get wisata berdasarkan provinsi (stream real-time, filter client-side)
  Stream<List<Wisata>> getWisataByProvinsi(String provinsi) {
    return _db
        .collection('wisata')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Wisata.fromFirestore(doc))
            .where((wisata) => wisata.provinsi == provinsi)
            .toList());
  }

  // Get wisata berdasarkan user (stream real-time, filter client-side)
  Stream<List<Wisata>> getWisataByUser(String userId) {
    return _db
        .collection('wisata')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Wisata.fromFirestore(doc))
            .where((wisata) => wisata.createdBy == userId)
            .toList());
  }

  // Search wisata berdasarkan nama
  Future<List<Wisata>> searchWisata(String query) async {
    // Firestore tidak support full-text search,
    // jadi kita ambil semua lalu filter di client
    final snapshot = await _db.collection('wisata').get();
    final allWisata =
        snapshot.docs.map((doc) => Wisata.fromFirestore(doc)).toList();

    final lowerQuery = query.toLowerCase();
    return allWisata
        .where((w) =>
            w.nama.toLowerCase().contains(lowerQuery) ||
            w.kota.toLowerCase().contains(lowerQuery) ||
            w.provinsi.toLowerCase().contains(lowerQuery) ||
            w.deskripsi.toLowerCase().contains(lowerQuery))
        .toList();
  }

  // ============================================
  // FAVORITES
  // ============================================

  // Tambah ke favorit
  Future<void> addFavorite(String userId, String wisataId) async {
    await _db
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .doc(wisataId)
        .set({
      'wisataId': wisataId,
      'addedAt': FieldValue.serverTimestamp(),
    });
  }

  // Hapus dari favorit
  Future<void> removeFavorite(String userId, String wisataId) async {
    await _db
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .doc(wisataId)
        .delete();
  }

  // Cek apakah wisata sudah di-favorit
  Stream<bool> isFavorite(String userId, String wisataId) {
    return _db
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .doc(wisataId)
        .snapshots()
        .map((doc) => doc.exists);
  }

  // Get semua wisata favorit user (stream real-time)
  Stream<List<String>> getFavoriteIds(String userId) {
    return _db
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.id).toList());
  }

  // Get wisata favorit user sebagai list Wisata
  // Auto-cleanup: hapus referensi favorit yang wisatanya sudah tidak ada
  Stream<List<Wisata>> getFavoriteWisata(String userId) {
    return getFavoriteIds(userId).asyncMap((ids) async {
      if (ids.isEmpty) return <Wisata>[];

      // Firestore 'whereIn' max 30 items per query
      final List<Wisata> results = [];
      final List<String> orphanedIds = [];

      for (int i = 0; i < ids.length; i += 30) {
        final batch = ids.sublist(i, i + 30 > ids.length ? ids.length : i + 30);
        final snapshot = await _db
            .collection('wisata')
            .where(FieldPath.documentId, whereIn: batch)
            .get();

        final foundIds = snapshot.docs.map((doc) => doc.id).toSet();
        results.addAll(
            snapshot.docs.map((doc) => Wisata.fromFirestore(doc)).toList());

        // Cari ID yang ada di favorites tapi wisatanya sudah tidak ada
        for (final id in batch) {
          if (!foundIds.contains(id)) {
            orphanedIds.add(id);
          }
        }
      }

      // Auto-cleanup: hapus favorit yang wisatanya sudah dihapus
      for (final orphanId in orphanedIds) {
        removeFavorite(userId, orphanId);
      }

      return results;
    });
  }
}
