import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wisata_jawa/models/wisata.dart';
import 'package:wisata_jawa/services/firestore_service.dart';
import 'package:wisata_jawa/widgets/wisata_card.dart';
import 'package:wisata_jawa/screens/wisata_detail_screen.dart';
import '../l10n/app_localizations.dart'; // l10n

class FavoritesTab extends StatefulWidget {
  const FavoritesTab({super.key});

  @override
  State<FavoritesTab> createState() => _FavoritesTabState();
}

class _FavoritesTabState extends State<FavoritesTab> {
  final FirestoreService _firestoreService = FirestoreService(); // Instance untuk mengakses Firestore
  final String? _userId = FirebaseAuth.instance.currentUser?.uid; // Ambil UID user yang sedang login, jika tidak ada maka null

// Set untuk menyimpan ID wisata yang difavoritkan oleh user, 
//dan StreamSubscription untuk mendengarkan perubahan data favorit
  Set<String> _favoriteIds = {};
  StreamSubscription? _favoriteSub;

// Inisialisasi state, mulai mendengarkan data favorit user saat widget dibuat, 
//dan pastikan untuk membatalkan langganan saat widget dihapus
  @override
  void initState() {
    super.initState();
    _listenFavorites();
  }

// Dispose method untuk membatalkan langganan ke stream saat widget dihapus, untuk mencegah memory leak
  @override
  void dispose() {
    _favoriteSub?.cancel();
    super.dispose();
  }

// Method untuk mendengarkan perubahan data favorit user,
// jika userId tidak null maka subscribe ke stream yang mengembalikan list ID favorit,
  void _listenFavorites() {
    if (_userId == null) return;
    _favoriteSub = _firestoreService.getFavoriteIds(_userId!).listen((ids) {
      if (mounted) {
        setState(() {
          _favoriteIds = ids.toSet();
        });
      }
    });
  }

// Method untuk toggle status favorit sebuah wisata, 
//jika sudah difavoritkan maka hapus dari favorit, jika belum maka tambahkan ke favorit
  void _toggleFavorite(String wisataId) {
    if (_userId == null) return;
    if (_favoriteIds.contains(wisataId)) {
      _firestoreService.removeFavorite(_userId!, wisataId);
    } else {
      _firestoreService.addFavorite(_userId!, wisataId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!; // l10n

    if (_userId == null) {
      return Center(child: Text(l10n.loginRequired)); // l10n
    }

// Scaffold utama untuk menampilkan daftar favorit, dengan header dan grid list wisata favorit
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAF8),
      body: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 12,
              left: 20,
              right: 20,
              bottom: 20,
            ),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF1B5E20), Color(0xFF2E7D32), Color(0xFF388E3C)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF1B5E20).withValues(alpha: 0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.favoritesTitle, // l10n
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        l10n.favoritesSubtitle, // l10n
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.7),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.2),
                    ),
                  ),
                  child: const Icon(
                    Icons.favorite_rounded,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ],
            ),
          ),

          // Konten utama untuk menampilkan daftar favorit, dengan handling untuk loading, error, dan empty state
          Expanded(
            child: StreamBuilder<List<Wisata>>(
              stream: _firestoreService.getFavoriteWisata(_userId!),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8F5E9),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const CircularProgressIndicator(
                            color: Color(0xFF2E7D32),
                            strokeWidth: 2.5,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          l10n.loadingFavorites, // l10n
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                // Handling error saat mengambil data favorit, tampilkan pesan error dengan ikon
                if (snapshot.hasError) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 64,
                            height: 64,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFF3E0),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Icon(Icons.wifi_off_rounded,
                                size: 32, color: Color(0xFFFF9800)),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            l10n.errorGeneral, // l10n
                            style: const TextStyle(
                              color: Color(0xFF1A1A1A),
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                final wisataList = snapshot.data ?? []; // Ambil data wisata favorit, jika null maka gunakan list kosong
                // Handling untuk kondisi ketika tidak ada wisata favorit, tampilkan pesan empty state dengan ikon
                if (wisataList.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFEBEE),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: const Icon(
                            Icons.favorite_border_rounded,
                            size: 40,
                            color: Color(0xFFEF9A9A),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          l10n.emptyFavorites, // l10n
                          style: const TextStyle(
                            color: Color(0xFF1A1A1A),
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          l10n.emptyFavoritesHint, // l10n
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                // Jika data favorit tersedia, tampilkan dalam bentuk grid, dengan jumlah favorit di header
                // dan setiap item wisata dapat diklik untuk melihat detail, serta tombol favorit untuk toggle status favorit
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 16, 20, 4),
                      child: Text(
                        l10n.favoritesCount(wisataList.length), // l10n
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Expanded(
                      child: GridView.builder(
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 14,
                          mainAxisSpacing: 14,
                          childAspectRatio: 0.68,
                        ),
                        itemCount: wisataList.length,
                        itemBuilder: (context, index) {
                          final wisata = wisataList[index];
                          return WisataCard(
                            wisata: wisata,
                            isFavorite: _favoriteIds.contains(wisata.id),
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      WisataDetailScreen(wisata: wisata),
                                ),
                              );
                            },
                            onFavoriteToggle: () =>
                                _toggleFavorite(wisata.id),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
