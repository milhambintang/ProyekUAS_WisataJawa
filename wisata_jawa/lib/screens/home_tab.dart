import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wisata_jawa/models/wisata.dart';
import 'package:wisata_jawa/services/firestore_service.dart';
import 'package:wisata_jawa/widgets/wisata_card.dart';
import 'package:wisata_jawa/screens/wisata_detail_screen.dart';
import 'package:wisata_jawa/screens/add_wisata_screen.dart';
import '../l10n/app_localizations.dart'; // l10n
import '../main.dart'; // l10n - untuk MainApp.setLocale()

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with SingleTickerProviderStateMixin {
  final FirestoreService _firestoreService = FirestoreService();
  final String? _userId = FirebaseAuth.instance.currentUser?.uid;
  int _selectedProvinsiIndex = 0;

  late AnimationController _animController;
  late Animation<double> _fadeAnimation;

  // Ikon untuk setiap provinsi tab
  final List<IconData> _provinsiIcons = [
    Icons.public_rounded,
    Icons.temple_buddhist_rounded,
    Icons.location_city_rounded,
    Icons.landscape_rounded,
    Icons.temple_hindu_rounded,
    Icons.account_balance_rounded,
    Icons.mosque_rounded,
  ];

  // Set untuk menyimpan ID favorit
  Set<String> _favoriteIds = {};
  StreamSubscription? _favoriteSub;

  @override
  void initState() {
    super.initState();
    _listenFavorites();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOut,
    );
    _animController.forward();
  }

  @override
  void dispose() { //
    _favoriteSub?.cancel();
    _animController.dispose();
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

  // Daftar provinsi tabs (pertama = "Semua" / terlokalisasi)
  List<String> _getProvinsiTabs(AppLocalizations l10n) {
    return [
      l10n.allProvinces,
      ...FirestoreService.provinsiList,
    ];
  }

  Stream<List<Wisata>> _getWisataStream() {
    if (_selectedProvinsiIndex == 0) {
      return _firestoreService.getSemuaWisata();
    }
    final provinsiTabs = [
      'Semua', // placeholder, index 0 sudah dihandle di atas
      ...FirestoreService.provinsiList,
    ];
    return _firestoreService
        .getWisataByProvinsi(provinsiTabs[_selectedProvinsiIndex]);
  }

  String _getGreeting(AppLocalizations l10n) {
    final hour = DateTime.now().hour;
    if (hour < 12) return l10n.greetingMorning;
    if (hour < 15) return l10n.greetingAfternoon;
    if (hour < 18) return l10n.greetingEvening;
    return l10n.greetingNight;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!; // l10n

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAF8),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Column(
          children: [
            // Header with gradient & greeting
            _buildHeader(context, l10n),

            // Provinsi tabs
            _buildProvinsiTabs(l10n),

            // Wisata grid
            Expanded(
              child: StreamBuilder<List<Wisata>>(
                stream: _getWisataStream(),
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
                            l10n.loadingWisata, // l10n
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
                            Text(
                              l10n.errorOccurred, // l10n
                              style: const TextStyle(
                                color: Color(0xFF1A1A1A),
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              l10n.errorConnection, // l10n
                              style: TextStyle(
                                color: Colors.grey.shade500,
                                fontSize: 13,
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
                              color: const Color(0xFFE8F5E9),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: const Icon(
                              Icons.explore_off_outlined,
                              size: 40,
                              color: Color(0xFF81C784),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            l10n.emptyWisata, // l10n
                            style: const TextStyle(
                              color: Color(0xFF1A1A1A),
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            l10n.emptyWisataHint, // l10n
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton.icon(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const AddWisataScreen()),
                              );
                            },
                            icon: const Icon(Icons.add_rounded, size: 20),
                            label: Text(l10n.addWisata), // l10n
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF2E7D32),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 12),
                              elevation: 0,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return GridView.builder(
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
                        onFavoriteToggle: () => _toggleFavorite(wisata.id),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: const LinearGradient(
            colors: [Color(0xFF2E7D32), Color(0xFF43A047)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF2E7D32).withValues(alpha: 0.4),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const AddWisataScreen()),
            );
          },
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          elevation: 0,
          hoverElevation: 0,
          focusElevation: 0,
          highlightElevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          child: const Icon(Icons.add_rounded, size: 28),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, AppLocalizations l10n) {
    final currentLocale = Localizations.localeOf(context).languageCode; // l10n

    return Container(
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${_getGreeting(l10n)} 👋', // l10n
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.85),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      l10n.headerTitle, // l10n
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ],
                ),
              ),
              // Language selector button
              PopupMenuButton<String>(
                icon: Container(
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
                    Icons.language_rounded,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                tooltip: l10n.language, // l10n
                onSelected: (code) => MainApp.setLocale(Locale(code)), // l10n
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                itemBuilder: (context) => [
                  _buildLanguageMenuItem('id', l10n.languageIndonesian, '🇮🇩', currentLocale),
                  _buildLanguageMenuItem('en', l10n.languageEnglish, '🇬🇧', currentLocale),
                  _buildLanguageMenuItem('th', l10n.languageThai, '🇹🇭', currentLocale),
                  _buildLanguageMenuItem('ko', l10n.languageKorean, '🇰🇷', currentLocale),
                  _buildLanguageMenuItem('zh', l10n.languageChinese, '🇨🇳', currentLocale),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            l10n.headerSubtitle, // l10n
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  PopupMenuItem<String> _buildLanguageMenuItem(
      String code, String label, String flag, String currentLocale) {
    return PopupMenuItem(
      value: code,
      child: Row(
        children: [
          if (currentLocale == code)
            const Icon(Icons.check, size: 18, color: Color(0xFF2E7D32))
          else
            const SizedBox(width: 18),
          const SizedBox(width: 8),
          Text(flag, style: const TextStyle(fontSize: 18)),
          const SizedBox(width: 8),
          Text(label),
        ],
      ),
    );
  }

  Widget _buildProvinsiTabs(AppLocalizations l10n) {
    final provinsiTabs = _getProvinsiTabs(l10n);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: List.generate(provinsiTabs.length, (index) {
            final isSelected = _selectedProvinsiIndex == index;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _selectedProvinsiIndex = index;
                    });
                  },
                  borderRadius: BorderRadius.circular(24),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInOut,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      gradient: isSelected
                          ? const LinearGradient(
                              colors: [Color(0xFF2E7D32), Color(0xFF43A047)],
                            )
                          : null,
                      color: isSelected ? null : const Color(0xFFF0F5F0),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: const Color(0xFF2E7D32)
                                    .withValues(alpha: 0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              ),
                            ]
                          : null,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _provinsiIcons[index],
                          size: 16,
                          color: isSelected
                              ? Colors.white
                              : Colors.grey.shade600,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          provinsiTabs[index],
                          style: TextStyle(
                            color: isSelected
                                ? Colors.white
                                : Colors.grey.shade700,
                            fontSize: 13,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
