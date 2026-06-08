import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wisata_jawa/models/wisata.dart';
import 'package:wisata_jawa/services/firestore_service.dart';
import 'package:wisata_jawa/screens/add_wisata_screen.dart';
import '../l10n/app_localizations.dart'; // l10n
import '../main.dart'; // l10n - untuk MainApp.setLocale()

class WisataDetailScreen extends StatefulWidget {
  final Wisata wisata;

  const WisataDetailScreen({super.key, required this.wisata});

  @override
  State<WisataDetailScreen> createState() => _WisataDetailScreenState();
}

class _WisataDetailScreenState extends State<WisataDetailScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  final String? _userId = FirebaseAuth.instance.currentUser?.uid;
  bool _isFavorite = false;
  StreamSubscription? _favoriteSub;

  @override
  void initState() {
    super.initState();
    _checkFavorite();
  }

  @override
  void dispose() {
    _favoriteSub?.cancel();
    super.dispose();
  }

  void _checkFavorite() {
    if (_userId == null) return;
    _favoriteSub = _firestoreService
        .isFavorite(_userId!, widget.wisata.id)
        .listen((isFav) {
      if (mounted) {
        setState(() {
          _isFavorite = isFav;
        });
      }
    });
  }

  void _toggleFavorite() {
    if (_userId == null) return;
    if (_isFavorite) {
      _firestoreService.removeFavorite(_userId!, widget.wisata.id);
    } else {
      _firestoreService.addFavorite(_userId!, widget.wisata.id);
    }
  }

  bool get _isOwner => _userId == widget.wisata.createdBy;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!; // l10n
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAF8),
      body: CustomScrollView(
        slivers: [
          // App bar with image
          SliverAppBar(
            expandedHeight: 320,
            pinned: true,
            backgroundColor: const Color(0xFF1B5E20),
            leading: Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.25),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.15),
                  ),
                ),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_rounded,
                      color: Colors.white, size: 20),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
            actions: [
              // Favorite button
              Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  decoration: BoxDecoration(
                    color: _isFavorite
                        ? const Color(0xFFE53935).withValues(alpha: 0.9)
                        : Colors.black.withValues(alpha: 0.25),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.15),
                    ),
                  ),
                  child: IconButton(
                    icon: Icon(
                      _isFavorite
                          ? Icons.favorite_rounded
                          : Icons.favorite_border_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                    onPressed: _toggleFavorite,
                  ),
                ),
              ),
              // Edit/Delete (jika owner)
              if (_isOwner)
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.25),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.15),
                      ),
                    ),
                    child: PopupMenuButton<String>(
                      icon: const Icon(Icons.more_vert,
                          color: Colors.white, size: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      onSelected: (value) {
                        if (value == 'edit') {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  AddWisataScreen(wisata: widget.wisata),
                            ),
                          );
                        } else if (value == 'delete') {
                          _showDeleteDialog();
                        }
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 'edit',
                          child: Row(
                            children: [
                              const Icon(Icons.edit_outlined,
                                  size: 18, color: Color(0xFF2E7D32)),
                              const SizedBox(width: 10),
                              Text(l10n.editWisata), // l10n
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: 'delete',
                          child: Row(
                            children: [
                              const Icon(Icons.delete_outline,
                                  size: 18, color: Colors.red),
                              const SizedBox(width: 10),
                              Text(l10n.delete, // l10n
                                  style: const TextStyle(color: Colors.red)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: _buildHeroImage(),
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: Transform.translate(
              offset: const Offset(0, -24),
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFF8FAF8),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 28, 20, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Nama wisata
                      Text(
                        widget.wisata.nama,
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1A1A1A),
                          letterSpacing: -0.5,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Lokasi & Rating chips
                      Wrap(
                        spacing: 10,
                        runSpacing: 8,
                        children: [
                          // Lokasi chip
                          _buildChip(
                            icon: Icons.location_on_rounded,
                            iconColor: const Color(0xFF2E7D32),
                            text:
                                '${widget.wisata.kota}, ${widget.wisata.provinsi}',
                            bgColor: const Color(0xFFE8F5E9),
                            textColor: const Color(0xFF2E7D32),
                          ),
                          // Rating chip
                          _buildChip(
                            icon: Icons.star_rounded,
                            iconColor: const Color(0xFFFFA000),
                            text:
                                '${widget.wisata.rating.toStringAsFixed(1)} / 5.0',
                            bgColor: const Color(0xFFFFF8E1),
                            textColor: const Color(0xFFFF8F00),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Divider
                      Container(
                        height: 1,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.grey.shade200,
                              Colors.grey.shade100,
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Deskripsi section
                      Row(
                        children: [
                          Container(
                            width: 4,
                            height: 20,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xFF2E7D32),
                                  Color(0xFF43A047)
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            l10n.detailDescription, // l10n
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF1A1A1A),
                              letterSpacing: -0.3,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        widget.wisata.deskripsi,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade700,
                          height: 1.7,
                          letterSpacing: 0.1,
                        ),
                      ),
                      const SizedBox(height: 28),

                      // Info card
                      Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: const Color(0xFFE8F5E9),
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF1B5E20)
                                  .withValues(alpha: 0.06),
                              blurRadius: 16,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            _buildInfoRow(Icons.map_rounded, l10n.detailProvince, // l10n
                                widget.wisata.provinsi),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 12),
                              child: Divider(
                                  color: Colors.grey.shade100, height: 1),
                            ),
                            _buildInfoRow(Icons.location_city_rounded, l10n.detailCity, // l10n
                                widget.wisata.kota),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 12),
                              child: Divider(
                                  color: Colors.grey.shade100, height: 1),
                            ),
                            _buildInfoRow(
                              Icons.star_rounded,
                              l10n.detailRating, // l10n
                              '${widget.wisata.rating.toStringAsFixed(1)} / 5.0',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChip({
    required IconData icon,
    required Color iconColor,
    required String text,
    required Color bgColor,
    required Color textColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: iconColor),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              color: textColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroImage() {
    if (widget.wisata.gambar.isEmpty) {
      return Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE8F5E9), Color(0xFFC8E6C9)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Icon(
            Icons.photo_camera_outlined,
            size: 64,
            color: Colors.grey.shade400,
          ),
        ),
      );
    }

    try {
      final bytes = base64Decode(widget.wisata.gambar);
      return Stack(
        fit: StackFit.expand,
        children: [
          Image.memory(
            bytes,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              color: const Color(0xFFE8F5E9),
              child:
                  const Icon(Icons.broken_image, size: 64, color: Colors.grey),
            ),
          ),
          // Gradient overlay at bottom
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.5),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    } catch (_) {
      return Container(
        color: const Color(0xFFE8F5E9),
        child: const Icon(Icons.broken_image, size: 64, color: Colors.grey),
      );
    }
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: const Color(0xFFE8F5E9),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 18, color: const Color(0xFF2E7D32)),
        ),
        const SizedBox(width: 12),
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1A1A1A),
          ),
        ),
      ],
    );
  }

  void _showDeleteDialog() {
    final l10n = AppLocalizations.of(context)!; // l10n
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFFFFEBEE),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.delete_outline_rounded,
                  color: Color(0xFFE53935), size: 22),
            ),
            const SizedBox(width: 12),
            Text(
              l10n.deleteWisata, // l10n
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
            ),
          ],
        ),
        content: Text(
          l10n.deleteConfirm(widget.wisata.nama), // l10n
          style: TextStyle(color: Colors.grey.shade600, height: 1.5),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            style: TextButton.styleFrom(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child:
                Text(l10n.cancel, style: TextStyle(color: Colors.grey.shade600)), // l10n
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(ctx);
              await _firestoreService.deleteWisata(widget.wisata.id, userId: _userId);
              if (mounted) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Row(
                      children: [
                        const Icon(Icons.check_circle_rounded,
                            color: Colors.white, size: 20),
                        const SizedBox(width: 10),
                        Text(l10n.wisataDeleted), // l10n
                      ],
                    ),
                    backgroundColor: const Color(0xFF2E7D32),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    margin: const EdgeInsets.all(16),
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE53935),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              elevation: 0,
            ),
            child: Text(l10n.delete, // l10n
                style: const TextStyle(fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}