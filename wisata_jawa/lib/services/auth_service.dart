import 'package:firebase_auth/firebase_auth.dart' as auth;

class AuthService {
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;

  // Stream untuk mendengarkan perubahan status autentikasi (login/logout)
  Stream<auth.User?> get user {
    return _firebaseAuth.authStateChanges();
  }

  // Sign In with Email and Password
  Future<auth.User?> signIn(String email, String password) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } catch (e) {
      rethrow; // Biarkan error dilempar ke UI untuk ditangani (misal: tampilkan pesan error)
    }
  }

  // Sign Up with Email and Password
  Future<auth.User?> signUp(String email, String password) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } catch (e) {
      rethrow; // Biarkan error dilempar ke UI untuk ditangani (misal: tampilkan pesan error)
    }
  }

  // Sign Out
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  // Mendapatkan user saat ini (bisa null jika belum login)
  auth.User? get currentUser => _firebaseAuth.currentUser;
}