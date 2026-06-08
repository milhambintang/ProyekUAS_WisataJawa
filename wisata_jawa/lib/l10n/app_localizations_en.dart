// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Wisata Jawa';

  @override
  String get appTagline => '✨ Explore the Beauty of Java Island';

  @override
  String get appSubtitle => 'Best Tourism Recommendations';

  @override
  String get greetingMorning => 'Good Morning';

  @override
  String get greetingAfternoon => 'Good Afternoon';

  @override
  String get greetingEvening => 'Good Evening';

  @override
  String get greetingNight => 'Good Night';

  @override
  String get headerTitle => 'Java Island Tourism';

  @override
  String get headerSubtitle => 'Discover the best tourist destinations in Java';

  @override
  String get allProvinces => 'All';

  @override
  String get navHome => 'Home';

  @override
  String get navSearch => 'Search';

  @override
  String get navFavorites => 'Favorites';

  @override
  String get navProfile => 'Profile';

  @override
  String get loadingWisata => 'Loading tourism...';

  @override
  String get loadingFavorites => 'Loading favorites...';

  @override
  String get searchingWisata => 'Searching tourism...';

  @override
  String get errorOccurred => 'Oops! An Error Occurred';

  @override
  String get errorConnection => 'Make sure your internet connection is stable';

  @override
  String get errorGeneral => 'An error occurred';

  @override
  String get emptyWisata => 'No Tourism Yet';

  @override
  String get emptyWisataHint => 'Be the first to add a tourist spot!';

  @override
  String get emptyFavorites => 'No Favorites Yet';

  @override
  String get emptyFavoritesHint =>
      'Tap ♥ on a tourist spot to add it to favorites';

  @override
  String get addWisata => 'Add Tourism';

  @override
  String get editWisata => 'Edit Tourism';

  @override
  String get deleteWisata => 'Delete Tourism';

  @override
  String get wisataAdded => 'Tourism added successfully';

  @override
  String get wisataUpdated => 'Tourism updated successfully';

  @override
  String get wisataDeleted => 'Tourism deleted successfully';

  @override
  String wisataFailed(String error) {
    return 'Failed: $error';
  }

  @override
  String get searchTitle => 'Search Tourism';

  @override
  String get searchSubtitle => 'Find your dream destination';

  @override
  String get searchHint => 'Search by name, city, or province...';

  @override
  String get searchFavorite => 'Search Your Favorite';

  @override
  String get searchFavoriteHint => 'Type tourism name, city, or province';

  @override
  String get searchNotFound => 'Tourism Not Found';

  @override
  String get searchNotFoundHint => 'Try a different keyword';

  @override
  String searchResultCount(int count) {
    return '$count tourism found';
  }

  @override
  String get favoritesTitle => 'Favorite Tourism';

  @override
  String get favoritesSubtitle => 'Collection of tourism you like';

  @override
  String favoritesCount(int count) {
    return '$count favorite tourism';
  }

  @override
  String get loginRequired => 'Please login first';

  @override
  String get welcome => 'Welcome';

  @override
  String get loginSubtitle => 'Login to explore Java Island tourism';

  @override
  String get emailLabel => 'Email';

  @override
  String get passwordLabel => 'Password';

  @override
  String get confirmPasswordLabel => 'Confirm Password';

  @override
  String get loginButton => 'Login';

  @override
  String get registerButton => 'Register';

  @override
  String get noAccount => 'Don\'t have an account? ';

  @override
  String get registerLink => 'Register';

  @override
  String get hasAccount => 'Already have an account? ';

  @override
  String get loginLink => 'Login';

  @override
  String get createAccount => 'Create New Account';

  @override
  String get registerSubtitle => 'Join and discover Java Island tourism';

  @override
  String get passwordMismatch => 'Passwords do not match';

  @override
  String profileMemberSince(String date) {
    return 'Member since $date';
  }

  @override
  String get profileWisataLabel => 'Tourism';

  @override
  String get profileFavoriteLabel => 'Favorites';

  @override
  String get profileWisataAdded => 'Tourism You Added';

  @override
  String get profileNoWisata => 'No tourism yet';

  @override
  String get profileNoWisataHint => 'Tourism you add will appear here';

  @override
  String get logout => 'Logout';

  @override
  String get logoutSubtitle => 'Logout from your account';

  @override
  String get logoutConfirm =>
      'Are you sure you want to logout from this account?';

  @override
  String get cancel => 'Cancel';

  @override
  String get wisataNameLabel => 'Tourism Name';

  @override
  String get wisataNameRequired => 'Tourism name is required';

  @override
  String get provinceLabel => 'Province';

  @override
  String get cityLabel => 'City/District';

  @override
  String get cityRequired => 'City is required';

  @override
  String get descriptionLabel => 'Description';

  @override
  String get descriptionRequired => 'Description is required';

  @override
  String ratingLabel(String value) {
    return 'Rating: $value';
  }

  @override
  String get updateWisata => 'Update Tourism';

  @override
  String get tapToPickImage => 'Tap to pick an image';

  @override
  String get maxImageSize => 'Maximum 700KB';

  @override
  String get changeImage => 'Change';

  @override
  String get imageTooLarge =>
      'Image is too large. Maximum 700KB after compression.';

  @override
  String get selectImage => 'Please select a tourism image';

  @override
  String get detailDescription => 'Description';

  @override
  String get detailProvince => 'Province';

  @override
  String get detailCity => 'City';

  @override
  String get detailRating => 'Rating';

  @override
  String deleteConfirm(String name) {
    return 'Are you sure you want to delete \"$name\"? This action cannot be undone.';
  }

  @override
  String get delete => 'Delete';

  @override
  String get language => 'Language';

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
