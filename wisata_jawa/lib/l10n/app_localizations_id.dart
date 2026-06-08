// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get appTitle => 'Wisata Jawa';

  @override
  String get appTagline => '✨ Jelajahi Keindahan Pulau Jawa';

  @override
  String get appSubtitle => 'Rekomendasi Wisata Terbaik';

  @override
  String get greetingMorning => 'Selamat Pagi';

  @override
  String get greetingAfternoon => 'Selamat Siang';

  @override
  String get greetingEvening => 'Selamat Sore';

  @override
  String get greetingNight => 'Selamat Malam';

  @override
  String get headerTitle => 'Wisata Pulau Jawa';

  @override
  String get headerSubtitle => 'Temukan destinasi wisata terbaik di Pulau Jawa';

  @override
  String get allProvinces => 'Semua';

  @override
  String get navHome => 'Home';

  @override
  String get navSearch => 'Cari';

  @override
  String get navFavorites => 'Favorit';

  @override
  String get navProfile => 'Profil';

  @override
  String get loadingWisata => 'Memuat wisata...';

  @override
  String get loadingFavorites => 'Memuat favorit...';

  @override
  String get searchingWisata => 'Mencari wisata...';

  @override
  String get errorOccurred => 'Oops! Terjadi Kesalahan';

  @override
  String get errorConnection => 'Pastikan koneksi internet kamu stabil';

  @override
  String get errorGeneral => 'Terjadi kesalahan';

  @override
  String get emptyWisata => 'Belum Ada Wisata';

  @override
  String get emptyWisataHint => 'Yuk, jadi yang pertama menambahkan wisata!';

  @override
  String get emptyFavorites => 'Belum Ada Favorit';

  @override
  String get emptyFavoritesHint =>
      'Tap ♥ pada wisata untuk menambahkan ke favorit';

  @override
  String get addWisata => 'Tambah Wisata';

  @override
  String get editWisata => 'Edit Wisata';

  @override
  String get deleteWisata => 'Hapus Wisata';

  @override
  String get wisataAdded => 'Wisata berhasil ditambahkan';

  @override
  String get wisataUpdated => 'Wisata berhasil diperbarui';

  @override
  String get wisataDeleted => 'Wisata berhasil dihapus';

  @override
  String wisataFailed(String error) {
    return 'Gagal: $error';
  }

  @override
  String get searchTitle => 'Cari Wisata';

  @override
  String get searchSubtitle => 'Temukan destinasi impianmu';

  @override
  String get searchHint => 'Cari nama wisata, kota, atau provinsi...';

  @override
  String get searchFavorite => 'Cari Wisata Favoritmu';

  @override
  String get searchFavoriteHint => 'Ketik nama wisata, kota, atau provinsi';

  @override
  String get searchNotFound => 'Wisata Tidak Ditemukan';

  @override
  String get searchNotFoundHint => 'Coba kata kunci lain';

  @override
  String searchResultCount(int count) {
    return '$count wisata ditemukan';
  }

  @override
  String get favoritesTitle => 'Wisata Favorit';

  @override
  String get favoritesSubtitle => 'Koleksi wisata yang kamu sukai';

  @override
  String favoritesCount(int count) {
    return '$count wisata favorit';
  }

  @override
  String get loginRequired => 'Silakan login terlebih dahulu';

  @override
  String get welcome => 'Selamat Datang';

  @override
  String get loginSubtitle => 'Masuk untuk menjelajahi wisata Pulau Jawa';

  @override
  String get emailLabel => 'Email';

  @override
  String get passwordLabel => 'Kata Sandi';

  @override
  String get confirmPasswordLabel => 'Konfirmasi Kata Sandi';

  @override
  String get loginButton => 'Masuk';

  @override
  String get registerButton => 'Daftar';

  @override
  String get noAccount => 'Belum punya akun? ';

  @override
  String get registerLink => 'Daftar';

  @override
  String get hasAccount => 'Sudah punya akun? ';

  @override
  String get loginLink => 'Masuk';

  @override
  String get createAccount => 'Buat Akun Baru';

  @override
  String get registerSubtitle => 'Bergabung dan temukan wisata Pulau Jawa';

  @override
  String get passwordMismatch => 'Kata sandi tidak cocok';

  @override
  String profileMemberSince(String date) {
    return 'Member sejak $date';
  }

  @override
  String get profileWisataLabel => 'Wisata';

  @override
  String get profileFavoriteLabel => 'Favorit';

  @override
  String get profileWisataAdded => 'Wisata yang Kamu Tambahkan';

  @override
  String get profileNoWisata => 'Belum ada wisata';

  @override
  String get profileNoWisataHint =>
      'Wisata yang kamu tambahkan akan muncul di sini';

  @override
  String get logout => 'Keluar';

  @override
  String get logoutSubtitle => 'Keluar dari akun kamu';

  @override
  String get logoutConfirm => 'Apakah kamu yakin ingin keluar dari akun ini?';

  @override
  String get cancel => 'Batal';

  @override
  String get wisataNameLabel => 'Nama Wisata';

  @override
  String get wisataNameRequired => 'Nama wisata wajib diisi';

  @override
  String get provinceLabel => 'Provinsi';

  @override
  String get cityLabel => 'Kota/Kabupaten';

  @override
  String get cityRequired => 'Kota wajib diisi';

  @override
  String get descriptionLabel => 'Deskripsi';

  @override
  String get descriptionRequired => 'Deskripsi wajib diisi';

  @override
  String ratingLabel(String value) {
    return 'Rating: $value';
  }

  @override
  String get updateWisata => 'Perbarui Wisata';

  @override
  String get tapToPickImage => 'Tap untuk pilih gambar';

  @override
  String get maxImageSize => 'Maksimal 700KB';

  @override
  String get changeImage => 'Ganti';

  @override
  String get imageTooLarge =>
      'Gambar terlalu besar. Maksimal 700KB setelah kompresi.';

  @override
  String get selectImage => 'Silakan pilih gambar wisata';

  @override
  String get detailDescription => 'Deskripsi';

  @override
  String get detailProvince => 'Provinsi';

  @override
  String get detailCity => 'Kota';

  @override
  String get detailRating => 'Rating';

  @override
  String deleteConfirm(String name) {
    return 'Apakah kamu yakin ingin menghapus \"$name\"? Tindakan ini tidak bisa dibatalkan.';
  }

  @override
  String get delete => 'Hapus';

  @override
  String get language => 'Bahasa';

  @override
  String get languageIndonesian => 'Indonesia';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageThai => 'ไทย';

  @override
  String get languageKorean => '한국어';

  @override
  String get languageChinese => '中文';
}
