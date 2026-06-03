import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
// Import konfigurasi Firebase yang di-generate otomatis oleh FlutterFire CLI
import 'firebase_options.dart';
// Import SplashScreen sebagai halaman awal
import 'package:wisata_jawa/screens/splash_screen.dart';

// Custom ScrollBehavior agar bisa scroll dengan mouse di Chrome/Web
class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
      };
}

void main() async {
  // Memastikan binding Flutter sudah siap sebelum menjalankan kode async
  WidgetsFlutterBinding.ensureInitialized();
  // Inisialisasi Firebase dengan konfigurasi sesuai platform (Android/Web/Windows)
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Menjalankan aplikasi Flutter dengan widget MainApp
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wisata Jawa',
      // Custom scroll behavior agar bisa scroll di Chrome
      scrollBehavior: AppScrollBehavior(),
      // Menghilangkan banner "DEBUG" di pojok kanan atas
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFF2E7D32),
        useMaterial3: true,
        brightness: Brightness.light,
        textTheme: GoogleFonts.poppinsTextTheme(),
        scaffoldBackgroundColor: const Color(0xFFF8FAF8),
      ),
      home: const SplashScreen(),
    );
  }
}