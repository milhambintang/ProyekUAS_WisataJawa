import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wisata_jawa/models/wisata.dart';
import 'package:wisata_jawa/services/firestore_service.dart';
import 'package:wisata_jawa/widgets/wisata_card.dart';
import 'package:wisata_jawa/screens/wisata_detail_screen.dart';

class FavoritesTab extends StatefulWidget {
  const FavoritesTab({super.key});

  @override
  State<FavoritesTab> createState() => _FavoritesTabState();
}

class _FavoritesTabState extends State<FavoritesTab> {
  final FirestoreService _firestoreService = FirestoreService();
  final String? _userId = FirebaseAuth.instance.currentUser?.uid;

  Set<String> _favoriteIds = {};
  StreamSubscription? _favoriteSub;

  @override
  void initState() {
    super.initState();
    _listenFavorites();
  }

  @override
  void dispose() {
    _favoriteSub?.cancel();
    super.dispose();
  }

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
    if (_userId == null) {
      return const Center(child: Text('Silakan login terlebih dahulu'));
    }

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
                      const Text(
                        'Wisata Favorit',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Koleksi wisata yang kamu sukai',
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

          // Favorites list
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
                          'Memuat favorit...',
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  );
                }

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
                          const Text(
                            'Terjadi Kesalahan',
                            style: TextStyle(
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

                final wisataList = snapshot.data ?? [];

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
                        const Text(
                          'Belum Ada Favorit',
                          style: TextStyle(
                            color: Color(0xFF1A1A1A),
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Tap ♥ pada wisata untuk menambahkan ke favorit',
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 16, 20, 4),
                      child: Text(
                        '${wisataList.length} wisata favorit',
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
