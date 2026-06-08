import 'package:flutter/material.dart';
import 'package:wisata_jawa/screens/home_tab.dart';
import 'package:wisata_jawa/screens/search_tab.dart';
import 'package:wisata_jawa/screens/favorites_tab.dart';
import 'package:wisata_jawa/screens/profile_tab.dart';
import '../l10n/app_localizations.dart'; // l10n

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _tabs = const [
    HomeTab(),
    SearchTab(),
    FavoritesTab(),
    ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!; // l10n

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _tabs,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF1B5E20).withValues(alpha: 0.08),
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: const Color(0xFF2E7D32),
            unselectedItemColor: Colors.grey.shade400,
            selectedFontSize: 11,
            unselectedFontSize: 11,
            selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              letterSpacing: 0.3,
            ),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
            elevation: 0,
            items: [
              BottomNavigationBarItem(
                icon: _buildNavIcon(Icons.home_outlined, 0),
                activeIcon: _buildActiveNavIcon(Icons.home_rounded, 0),
                label: l10n.navHome, // l10n
              ),
              BottomNavigationBarItem(
                icon: _buildNavIcon(Icons.search_outlined, 1),
                activeIcon: _buildActiveNavIcon(Icons.search_rounded, 1),
                label: l10n.navSearch, // l10n
              ),
              BottomNavigationBarItem(
                icon: _buildNavIcon(Icons.favorite_outline, 2),
                activeIcon: _buildActiveNavIcon(Icons.favorite_rounded, 2),
                label: l10n.navFavorites, // l10n
              ),
              BottomNavigationBarItem(
                icon: _buildNavIcon(Icons.person_outline, 3),
                activeIcon: _buildActiveNavIcon(Icons.person_rounded, 3),
                label: l10n.navProfile, // l10n
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavIcon(IconData icon, int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Icon(icon, size: 24),
    );
  }

  Widget _buildActiveNavIcon(IconData icon, int index) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      margin: const EdgeInsets.only(bottom: 2),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, size: 24, color: const Color(0xFF2E7D32)),
    );
  }
}
