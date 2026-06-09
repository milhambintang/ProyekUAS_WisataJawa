import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wisata_jawa/models/wisata.dart';
import 'package:wisata_jawa/services/firestore_service.dart';
import 'package:wisata_jawa/services/auth_service.dart';
import 'package:wisata_jawa/screens/login_screen.dart';
import 'package:wisata_jawa/screens/wisata_detail_screen.dart';
import 'package:wisata_jawa/l10n/app_localizations.dart'; // l10n
import 'package:wisata_jawa/main.dart'; // l10n - untuk MainApp.setLocale()
import 'dart:convert';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}


// State untuk ProfileTab, yang menampilkan informasi profil user, menu pengaturan seperti ganti bahasa dan logout, 
// serta daftar wisata yang ditambahkan oleh user, dengan interaksi untuk melihat detail wisata dan mengubah bahasa aplikasi
class _ProfileTabState extends State<ProfileTab> {
  // Service untuk autentikasi dan Firestore untuk database
  final AuthService _authService = AuthService();
  final FirestoreService _firestoreService = FirestoreService();
  final User? _user = FirebaseAuth.instance.currentUser;

  // Data bahasa yang tersedia: [locale, label, flag emoji]
  static const List<_LangOption> _languages = [
    _LangOption('id', 'Indonesia', '🇮🇩'),
    _LangOption('en', 'English', '🇬🇧'),
    _LangOption('th', 'ไทย', '🇹🇭'),
    _LangOption('ko', '한국어', '🇰🇷'),
    _LangOption('zh', '中文', '🇨🇳'),
  ];

  // Locale aktif saat ini
  String _currentLocale = 'id';

  // Format tanggal untuk menampilkan "Member since" dengan format yang lebih ramah, misal: "Member since Jan 2023"
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Sinkronkan _currentLocale dengan locale aktif dari context
    final locale = Localizations.localeOf(context).languageCode;
    if (_currentLocale != locale) {
      _currentLocale = locale;
    }
  }

  // Helper method untuk mengubah bahasa aplikasi
  void _changeLanguage(String langCode) {
    setState(() => _currentLocale = langCode);
    MainApp.setLocale(Locale(langCode));
    Navigator.pop(context); // tutup bottom sheet
  }

  // Helper method untuk menampilkan dialog konfirmasi logout, dengan opsi untuk membatalkan atau melanjutkan logout
  void _showLanguageSheet() {
    final l10n = AppLocalizations.of(context)!;
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle bar
              const SizedBox(height: 12),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),
              // Judul
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8F5E9),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.language_rounded,
                          size: 20, color: Color(0xFF2E7D32)),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      l10n.language, // l10n
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Divider(color: Colors.grey.shade100, height: 1),
              // Daftar bahasa
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _languages.length,
                separatorBuilder: (_, __) =>
                    Divider(color: Colors.grey.shade100, height: 1),
                itemBuilder: (_, i) {
                  final lang = _languages[i];
                  final isSelected = lang.code == _currentLocale;
                  return ListTile(
                    onTap: () => _changeLanguage(lang.code),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 4),
                    leading: Text(lang.flag,
                        style: const TextStyle(fontSize: 28)),
                    title: Text(
                      lang.label,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: isSelected
                            ? FontWeight.w700
                            : FontWeight.w500,
                        color: isSelected
                            ? const Color(0xFF2E7D32)
                            : const Color(0xFF2D2D2D),
                      ),
                    ),
                    trailing: isSelected
                        ? Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              color: const Color(0xFF2E7D32),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.check_rounded,
                                color: Colors.white, size: 16),
                          )
                        : null,
                  );
                },
              ),
              SizedBox(height: MediaQuery.of(context).padding.bottom + 16),
            ],
          ),
        );
      },
    );
  }

  // Helper method untuk menampilkan dialog konfirmasi logout, dengan opsi untuk membatalkan atau melanjutkan logout
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!; // l10n

    // Jika user belum login, tampilkan pesan bahwa login diperlukan untuk melihat profil
    if (_user == null) {
      return Center(child: Text(l10n.loginRequired)); // l10n
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAF8),
      body: Column(
        children: [
          // ── Header dengan info profil ─────────────────────────────────
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 16,
              left: 20,
              right: 20,
              bottom: 28,
            ),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF1B5E20),
                  Color(0xFF2E7D32),
                  Color(0xFF388E3C)
                ],
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
              children: [
                // Avatar
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        Colors.white.withValues(alpha: 0.3),
                        Colors.white.withValues(alpha: 0.1),
                      ],
                    ),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.5),
                      width: 2.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withValues(alpha: 0.15),
                        blurRadius: 20,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: const Icon(Icons.person_rounded,
                      size: 40, color: Colors.white),
                ),
                const SizedBox(height: 14),

                // Email
                Text(
                  _user!.email ?? '-',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(height: 4),

                // Member since
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    l10n.profileMemberSince( // l10n
                      _formatDate(_user!.metadata.creationTime),
                    ),
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.85),
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Stats row
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    StreamBuilder<List<Wisata>>(
                      stream: _firestoreService.getWisataByUser(_user!.uid),
                      builder: (context, snapshot) {
                        final count = snapshot.data?.length ?? 0;
                        return _buildStatItem(
                          count.toString(),
                          l10n.profileWisataLabel, // l10n
                          Icons.add_location_alt_rounded,
                        );
                      },
                    ),
                    const SizedBox(width: 16),
                    StreamBuilder<List<String>>(
                      stream: _firestoreService.getFavoriteIds(_user!.uid),
                      builder: (context, snapshot) {
                        final count = snapshot.data?.length ?? 0;
                        return _buildStatItem(
                          count.toString(),
                          l10n.profileFavoriteLabel, // l10n
                          Icons.favorite_rounded,
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),

          // ── Body ─────────────────────────────────────────────────────
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Menu cards ──────────────────────────────────────
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.04),
                          blurRadius: 12,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Ganti Bahasa
                        _buildMenuTile(
                          icon: Icons.language_rounded,
                          iconBgColor: const Color(0xFFE3F2FD),
                          iconColor: const Color(0xFF1565C0),
                          title: l10n.language, // l10n
                          subtitle: _languages
                              .firstWhere( // Cari label bahasa berdasarkan _currentLocale
                                (l) => l.code == _currentLocale,
                                orElse: () => _languages.first,
                              )
                              .label,
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                _languages
                                    .firstWhere(
                                      (l) => l.code == _currentLocale,
                                      orElse: () => _languages.first,
                                    )
                                    .flag,
                                style: const TextStyle(fontSize: 20),
                              ),
                              const SizedBox(width: 6),
                              Icon(Icons.chevron_right_rounded,
                                  color: Colors.grey.shade300),
                            ],
                          ),
                          onTap: _showLanguageSheet,
                          isLast: false,
                        ),

                        Divider(
                            color: Colors.grey.shade100,
                            height: 1,
                            indent: 68),

                        // Logout
                        _buildMenuTile(
                          icon: Icons.logout_rounded,
                          iconBgColor: const Color(0xFFFFEBEE),
                          iconColor: const Color(0xFFE53935),
                          title: l10n.logout, // l10n
                          subtitle: l10n.logoutSubtitle, // l10n
                          titleColor: const Color(0xFFE53935),
                          subtitleColor: const Color(0xFFEF9A9A),
                          trailing: Icon(Icons.chevron_right_rounded,
                              color: Colors.grey.shade300),
                          onTap: () => _showLogoutDialog(context), // Tampilkan dialog konfirmasi logout
                          isLast: true,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // ── Section header: Wisata ditambahkan ──────────────
                  Row(
                    children: [
                      Container(
                        width: 4,
                        height: 20,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF2E7D32), Color(0xFF43A047)],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        l10n.profileWisataAdded, // l10n
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey.shade800,
                          letterSpacing: -0.3,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),

                  // ── Daftar wisata user ──────────────────────────────
                  StreamBuilder<List<Wisata>>(
                    stream: _firestoreService.getWisataByUser(_user!.uid), // Stream wisata yang ditambahkan oleh user saat ini
                    builder: (context, snapshot) {
                      if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Container(
                          height: 100,
                          alignment: Alignment.center,
                          child: const CircularProgressIndicator(
                            color: Color(0xFF2E7D32),
                            strokeWidth: 2.5,
                          ),
                        );
                      }

                      final wisataList = snapshot.data ?? []; // Daftar wisata yang ditambahkan oleh user, atau list kosong jika belum ada data

                      if (wisataList.isEmpty) {
                        return Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(32),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(color: Colors.grey.shade100),
                          ),
                          child: Column(
                            children: [
                              Container(
                                width: 56,
                                height: 56,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE8F5E9),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: const Icon(
                                  Icons.add_photo_alternate_outlined,
                                  size: 28,
                                  color: Color(0xFF81C784),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                l10n.profileNoWisata, // l10n
                                style: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                l10n.profileNoWisataHint, // l10n
                                style: TextStyle(
                                  color: Colors.grey.shade400,
                                  fontSize: 12,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        );
                      }

                      return Column(
                        children: wisataList
                            .map((w) => _buildWisataListItem(w))
                            .toList(),
                      );
                    },
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method untuk menampilkan dialog konfirmasi logout, dengan opsi untuk membatalkan atau melanjutkan logout
  Widget _buildMenuTile({
    required IconData icon,
    required Color iconBgColor,
    required Color iconColor,
    required String title,
    required String subtitle,
    Color? titleColor,
    Color? subtitleColor,
    required Widget trailing,
    required VoidCallback onTap,
    required bool isLast,
  }) {
    return Material(
      color: Colors.transparent,
      borderRadius: isLast
          ? const BorderRadius.vertical(bottom: Radius.circular(18))
          : BorderRadius.zero,
      child: InkWell(
        onTap: onTap,
        borderRadius: isLast
            ? const BorderRadius.vertical(bottom: Radius.circular(18))
            : BorderRadius.zero,
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: iconBgColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: iconColor, size: 20),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: titleColor ?? const Color(0xFF1A1A1A),
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: subtitleColor ?? Colors.grey.shade500,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              trailing,
            ],
          ),
        ),
      ),
    );
  }

  // Helper method untuk menampilkan dialog konfirmasi logout, dengan opsi untuk membatalkan atau melanjutkan logout
  Widget _buildStatItem(String value, String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 22),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.8),
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // ── Helper: Wisata list item ───────────────────────────────────────────
  Widget _buildWisataListItem(Wisata wisata) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => WisataDetailScreen(wisata: wisata),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF1B5E20).withValues(alpha: 0.06),
              blurRadius: 12,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            // Thumbnail
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: SizedBox(
                width: 64,
                height: 64,
                child: wisata.gambar.isNotEmpty
                    ? Image.memory(
                        base64Decode(wisata.gambar),
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => _thumbPlaceholder(),
                      )
                    : _thumbPlaceholder(),
              ),
            ),
            const SizedBox(width: 14),

            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    wisata.nama,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: Color(0xFF1A1A1A),
                      letterSpacing: -0.3,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8F5E9),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Icon(Icons.location_on_rounded,
                            size: 11, color: Color(0xFF43A047)),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          '${wisata.kota}, ${wisata.provinsi}',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Rating badge
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFE8F5E9), Color(0xFFC8E6C9)],
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.star_rounded,
                      color: Color(0xFFFFA000), size: 14),
                  const SizedBox(width: 3),
                  Text(
                    wisata.rating.toStringAsFixed(1),
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF2E7D32),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method untuk menampilkan dialog konfirmasi logout, dengan opsi untuk membatalkan atau melanjutkan logout
  Widget _thumbPlaceholder() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFE8F5E9), Color(0xFFC8E6C9)],
        ),
      ),
      child: const Icon(Icons.image, color: Colors.grey),
    );
  }

  // Helper method untuk menampilkan dialog konfirmasi logout, dengan opsi untuk membatalkan atau melanjutkan logout
  String _formatDate(DateTime? date) {
    if (date == null) return '-';
    final locale = Localizations.localeOf(context).languageCode; // Dapatkan kode bahasa dari context untuk menentukan nama bulan yang sesuai
    // Daftar nama bulan untuk beberapa bahasa, dengan format singkatan 3 huruf, yang akan dipilih berdasarkan locale aktif
    const monthsId = [
      'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
      'Jul', 'Agt', 'Sep', 'Okt', 'Nov', 'Des'
    ];

    // Daftar nama bulan untuk beberapa bahasa, dengan format singkatan 3 huruf, yang akan dipilih berdasarkan locale aktif
    const monthsEn = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];

    // Daftar nama bulan untuk beberapa bahasa, dengan format singkatan 3 huruf, yang akan dipilih berdasarkan locale aktif
    const monthsTh = [
      'ม.ค.', 'ก.พ.', 'มี.ค.', 'เม.ย.', 'พ.ค.', 'มิ.ย.',
      'ก.ค.', 'ส.ค.', 'ก.ย.', 'ต.ค.', 'พ.ย.', 'ธ.ค.'
    ];
    const monthsKo = [
      '1월', '2월', '3월', '4월', '5월', '6월',
      '7월', '8월', '9월', '10월', '11월', '12월'
    ];
    const monthsZh = [
      '1月', '2月', '3月', '4月', '5月', '6月',
      '7月', '8月', '9月', '10月', '11月', '12月'
    ];
    
    // Pilih daftar nama bulan yang sesuai dengan locale aktif, default ke bahasa Indonesia jika locale tidak dikenali
    final months = switch (locale) {
      'th' => monthsTh,
      'ko' => monthsKo,
      'zh' => monthsZh,
      'en' => monthsEn,
      _ => monthsId,
    };

    // Format tanggal menjadi string dengan format "dd MMM yyyy", menggunakan nama bulan yang sesuai dengan locale aktif
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  // Helper method untuk menampilkan dialog konfirmasi logout, dengan opsi untuk membatalkan atau melanjutkan logout
  void _showLogoutDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context)!; // l10n
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFFFFEBEE),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.logout_rounded,
                  color: Color(0xFFE53935), size: 22),
            ),
            const SizedBox(width: 12),
            Text(
              l10n.logout, // l10n
              style: const TextStyle(
                  fontWeight: FontWeight.w700, fontSize: 18),
            ),
          ],
        ),
        content: Text(
          l10n.logoutConfirm, // l10n
          style: TextStyle(color: Colors.grey.shade600, height: 1.5),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                  horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            child: Text(l10n.cancel, // l10n
                style: TextStyle(color: Colors.grey.shade600)),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(ctx);
              await _authService.signOut();
              if (mounted) {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => const LoginScreen()),
                  (route) => false,
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE53935),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.symmetric(
                  horizontal: 20, vertical: 12),
              elevation: 0,
            ),
            child: Text(l10n.logout, // l10n
                style: const TextStyle(fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}

// Model untuk opsi bahasa, yang menyimpan kode bahasa, label yang ditampilkan, dan emoji bendera yang sesuai
class _LangOption {
  final String code;
  final String label;
  final String flag;
  const _LangOption(this.code, this.label, this.flag);
}