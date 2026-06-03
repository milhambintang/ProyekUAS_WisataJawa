import 'package:flutter/material.dart';
import 'package:wisata_jawa/screens/login_screen.dart';
import 'package:wisata_jawa/services/auth_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedProvinsiIndex = 0;
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wisata Jawa'),
        actions: [
          IconButton(
            onPressed: () async {
              await AuthService().signOut();
              if (mounted) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              }
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Text(
          'Halaman Utama - Provinsi ${selectedProvinsiIndex + 1}',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
