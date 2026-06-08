import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_id.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_th.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('id'),
    Locale('ko'),
    Locale('th'),
    Locale('zh'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Wisata Jawa'**
  String get appTitle;

  /// No description provided for @appTagline.
  ///
  /// In en, this message translates to:
  /// **'✨ Explore the Beauty of Java Island'**
  String get appTagline;

  /// No description provided for @appSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Best Tourism Recommendations'**
  String get appSubtitle;

  /// No description provided for @greetingMorning.
  ///
  /// In en, this message translates to:
  /// **'Good Morning'**
  String get greetingMorning;

  /// No description provided for @greetingAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Good Afternoon'**
  String get greetingAfternoon;

  /// No description provided for @greetingEvening.
  ///
  /// In en, this message translates to:
  /// **'Good Evening'**
  String get greetingEvening;

  /// No description provided for @greetingNight.
  ///
  /// In en, this message translates to:
  /// **'Good Night'**
  String get greetingNight;

  /// No description provided for @headerTitle.
  ///
  /// In en, this message translates to:
  /// **'Java Island Tourism'**
  String get headerTitle;

  /// No description provided for @headerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Discover the best tourist destinations in Java'**
  String get headerSubtitle;

  /// No description provided for @allProvinces.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get allProvinces;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navSearch.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get navSearch;

  /// No description provided for @navFavorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get navFavorites;

  /// No description provided for @navProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navProfile;

  /// No description provided for @loadingWisata.
  ///
  /// In en, this message translates to:
  /// **'Loading tourism...'**
  String get loadingWisata;

  /// No description provided for @loadingFavorites.
  ///
  /// In en, this message translates to:
  /// **'Loading favorites...'**
  String get loadingFavorites;

  /// No description provided for @searchingWisata.
  ///
  /// In en, this message translates to:
  /// **'Searching tourism...'**
  String get searchingWisata;

  /// No description provided for @errorOccurred.
  ///
  /// In en, this message translates to:
  /// **'Oops! An Error Occurred'**
  String get errorOccurred;

  /// No description provided for @errorConnection.
  ///
  /// In en, this message translates to:
  /// **'Make sure your internet connection is stable'**
  String get errorConnection;

  /// No description provided for @errorGeneral.
  ///
  /// In en, this message translates to:
  /// **'An error occurred'**
  String get errorGeneral;

  /// No description provided for @emptyWisata.
  ///
  /// In en, this message translates to:
  /// **'No Tourism Yet'**
  String get emptyWisata;

  /// No description provided for @emptyWisataHint.
  ///
  /// In en, this message translates to:
  /// **'Be the first to add a tourist spot!'**
  String get emptyWisataHint;

  /// No description provided for @emptyFavorites.
  ///
  /// In en, this message translates to:
  /// **'No Favorites Yet'**
  String get emptyFavorites;

  /// No description provided for @emptyFavoritesHint.
  ///
  /// In en, this message translates to:
  /// **'Tap ♥ on a tourist spot to add it to favorites'**
  String get emptyFavoritesHint;

  /// No description provided for @addWisata.
  ///
  /// In en, this message translates to:
  /// **'Add Tourism'**
  String get addWisata;

  /// No description provided for @editWisata.
  ///
  /// In en, this message translates to:
  /// **'Edit Tourism'**
  String get editWisata;

  /// No description provided for @deleteWisata.
  ///
  /// In en, this message translates to:
  /// **'Delete Tourism'**
  String get deleteWisata;

  /// No description provided for @wisataAdded.
  ///
  /// In en, this message translates to:
  /// **'Tourism added successfully'**
  String get wisataAdded;

  /// No description provided for @wisataUpdated.
  ///
  /// In en, this message translates to:
  /// **'Tourism updated successfully'**
  String get wisataUpdated;

  /// No description provided for @wisataDeleted.
  ///
  /// In en, this message translates to:
  /// **'Tourism deleted successfully'**
  String get wisataDeleted;

  /// No description provided for @wisataFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed: {error}'**
  String wisataFailed(String error);

  /// No description provided for @searchTitle.
  ///
  /// In en, this message translates to:
  /// **'Search Tourism'**
  String get searchTitle;

  /// No description provided for @searchSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Find your dream destination'**
  String get searchSubtitle;

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'Search by name, city, or province...'**
  String get searchHint;

  /// No description provided for @searchFavorite.
  ///
  /// In en, this message translates to:
  /// **'Search Your Favorite'**
  String get searchFavorite;

  /// No description provided for @searchFavoriteHint.
  ///
  /// In en, this message translates to:
  /// **'Type tourism name, city, or province'**
  String get searchFavoriteHint;

  /// No description provided for @searchNotFound.
  ///
  /// In en, this message translates to:
  /// **'Tourism Not Found'**
  String get searchNotFound;

  /// No description provided for @searchNotFoundHint.
  ///
  /// In en, this message translates to:
  /// **'Try a different keyword'**
  String get searchNotFoundHint;

  /// No description provided for @searchResultCount.
  ///
  /// In en, this message translates to:
  /// **'{count} tourism found'**
  String searchResultCount(int count);

  /// No description provided for @favoritesTitle.
  ///
  /// In en, this message translates to:
  /// **'Favorite Tourism'**
  String get favoritesTitle;

  /// No description provided for @favoritesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Collection of tourism you like'**
  String get favoritesSubtitle;

  /// No description provided for @favoritesCount.
  ///
  /// In en, this message translates to:
  /// **'{count} favorite tourism'**
  String favoritesCount(int count);

  /// No description provided for @loginRequired.
  ///
  /// In en, this message translates to:
  /// **'Please login first'**
  String get loginRequired;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// No description provided for @loginSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Login to explore Java Island tourism'**
  String get loginSubtitle;

  /// No description provided for @emailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailLabel;

  /// No description provided for @passwordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordLabel;

  /// No description provided for @confirmPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPasswordLabel;

  /// No description provided for @loginButton.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginButton;

  /// No description provided for @registerButton.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get registerButton;

  /// No description provided for @noAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? '**
  String get noAccount;

  /// No description provided for @registerLink.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get registerLink;

  /// No description provided for @hasAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? '**
  String get hasAccount;

  /// No description provided for @loginLink.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginLink;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create New Account'**
  String get createAccount;

  /// No description provided for @registerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Join and discover Java Island tourism'**
  String get registerSubtitle;

  /// No description provided for @passwordMismatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordMismatch;

  /// No description provided for @profileMemberSince.
  ///
  /// In en, this message translates to:
  /// **'Member since {date}'**
  String profileMemberSince(String date);

  /// No description provided for @profileWisataLabel.
  ///
  /// In en, this message translates to:
  /// **'Tourism'**
  String get profileWisataLabel;

  /// No description provided for @profileFavoriteLabel.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get profileFavoriteLabel;

  /// No description provided for @profileWisataAdded.
  ///
  /// In en, this message translates to:
  /// **'Tourism You Added'**
  String get profileWisataAdded;

  /// No description provided for @profileNoWisata.
  ///
  /// In en, this message translates to:
  /// **'No tourism yet'**
  String get profileNoWisata;

  /// No description provided for @profileNoWisataHint.
  ///
  /// In en, this message translates to:
  /// **'Tourism you add will appear here'**
  String get profileNoWisataHint;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @logoutSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Logout from your account'**
  String get logoutSubtitle;

  /// No description provided for @logoutConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout from this account?'**
  String get logoutConfirm;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @wisataNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Tourism Name'**
  String get wisataNameLabel;

  /// No description provided for @wisataNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Tourism name is required'**
  String get wisataNameRequired;

  /// No description provided for @provinceLabel.
  ///
  /// In en, this message translates to:
  /// **'Province'**
  String get provinceLabel;

  /// No description provided for @cityLabel.
  ///
  /// In en, this message translates to:
  /// **'City/District'**
  String get cityLabel;

  /// No description provided for @cityRequired.
  ///
  /// In en, this message translates to:
  /// **'City is required'**
  String get cityRequired;

  /// No description provided for @descriptionLabel.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get descriptionLabel;

  /// No description provided for @descriptionRequired.
  ///
  /// In en, this message translates to:
  /// **'Description is required'**
  String get descriptionRequired;

  /// No description provided for @ratingLabel.
  ///
  /// In en, this message translates to:
  /// **'Rating: {value}'**
  String ratingLabel(String value);

  /// No description provided for @updateWisata.
  ///
  /// In en, this message translates to:
  /// **'Update Tourism'**
  String get updateWisata;

  /// No description provided for @tapToPickImage.
  ///
  /// In en, this message translates to:
  /// **'Tap to pick an image'**
  String get tapToPickImage;

  /// No description provided for @maxImageSize.
  ///
  /// In en, this message translates to:
  /// **'Maximum 700KB'**
  String get maxImageSize;

  /// No description provided for @changeImage.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get changeImage;

  /// No description provided for @imageTooLarge.
  ///
  /// In en, this message translates to:
  /// **'Image is too large. Maximum 700KB after compression.'**
  String get imageTooLarge;

  /// No description provided for @selectImage.
  ///
  /// In en, this message translates to:
  /// **'Please select a tourism image'**
  String get selectImage;

  /// No description provided for @detailDescription.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get detailDescription;

  /// No description provided for @detailProvince.
  ///
  /// In en, this message translates to:
  /// **'Province'**
  String get detailProvince;

  /// No description provided for @detailCity.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get detailCity;

  /// No description provided for @detailRating.
  ///
  /// In en, this message translates to:
  /// **'Rating'**
  String get detailRating;

  /// No description provided for @deleteConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete \"{name}\"? This action cannot be undone.'**
  String deleteConfirm(String name);

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @languageIndonesian.
  ///
  /// In en, this message translates to:
  /// **'Indonesia'**
  String get languageIndonesian;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @languageThai.
  ///
  /// In en, this message translates to:
  /// **'ไทย'**
  String get languageThai;

  /// No description provided for @languageKorean.
  ///
  /// In en, this message translates to:
  /// **'한국어'**
  String get languageKorean;

  /// No description provided for @languageChinese.
  ///
  /// In en, this message translates to:
  /// **'中文'**
  String get languageChinese;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'id', 'ko', 'th', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'id':
      return AppLocalizationsId();
    case 'ko':
      return AppLocalizationsKo();
    case 'th':
      return AppLocalizationsTh();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
