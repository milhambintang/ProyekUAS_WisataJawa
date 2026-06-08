// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appTitle => '자바 관광';

  @override
  String get appTagline => '✨ 자바 섬의 아름다움을 탐험하세요';

  @override
  String get appSubtitle => '최고의 관광 추천';

  @override
  String get greetingMorning => '좋은 아침입니다';

  @override
  String get greetingAfternoon => '좋은 오후입니다';

  @override
  String get greetingEvening => '좋은 저녁입니다';

  @override
  String get greetingNight => '안녕하세요';

  @override
  String get headerTitle => '자바 섬 관광';

  @override
  String get headerSubtitle => '자바 섬 최고의 관광지를 찾아보세요';

  @override
  String get allProvinces => '전체';

  @override
  String get navHome => '홈';

  @override
  String get navSearch => '검색';

  @override
  String get navFavorites => '즐겨찾기';

  @override
  String get navProfile => '프로필';

  @override
  String get loadingWisata => '관광지 로딩 중...';

  @override
  String get loadingFavorites => '즐겨찾기 로딩 중...';

  @override
  String get searchingWisata => '관광지 검색 중...';

  @override
  String get errorOccurred => '이런! 오류가 발생했습니다';

  @override
  String get errorConnection => '인터넷 연결을 확인해주세요';

  @override
  String get errorGeneral => '오류가 발생했습니다';

  @override
  String get emptyWisata => '관광지가 없습니다';

  @override
  String get emptyWisataHint => '첫 번째로 관광지를 추가해보세요!';

  @override
  String get emptyFavorites => '즐겨찾기가 없습니다';

  @override
  String get emptyFavoritesHint => '관광지에서 ♥를 눌러 즐겨찾기에 추가하세요';

  @override
  String get addWisata => '관광지 추가';

  @override
  String get editWisata => '관광지 수정';

  @override
  String get deleteWisata => '관광지 삭제';

  @override
  String get wisataAdded => '관광지가 성공적으로 추가되었습니다';

  @override
  String get wisataUpdated => '관광지가 성공적으로 업데이트되었습니다';

  @override
  String get wisataDeleted => '관광지가 성공적으로 삭제되었습니다';

  @override
  String wisataFailed(String error) {
    return '실패: $error';
  }

  @override
  String get searchTitle => '관광지 검색';

  @override
  String get searchSubtitle => '꿈의 여행지를 찾아보세요';

  @override
  String get searchHint => '이름, 도시 또는 지역으로 검색...';

  @override
  String get searchFavorite => '좋아하는 관광지 검색';

  @override
  String get searchFavoriteHint => '관광지 이름, 도시 또는 지역을 입력하세요';

  @override
  String get searchNotFound => '관광지를 찾을 수 없습니다';

  @override
  String get searchNotFoundHint => '다른 키워드를 시도해보세요';

  @override
  String searchResultCount(int count) {
    return '$count개의 관광지 발견';
  }

  @override
  String get favoritesTitle => '즐겨찾기 관광지';

  @override
  String get favoritesSubtitle => '좋아하는 관광지 모음';

  @override
  String favoritesCount(int count) {
    return '$count개의 즐겨찾기';
  }

  @override
  String get loginRequired => '먼저 로그인해주세요';

  @override
  String get welcome => '환영합니다';

  @override
  String get loginSubtitle => '자바 섬 관광지를 탐험하려면 로그인하세요';

  @override
  String get emailLabel => '이메일';

  @override
  String get passwordLabel => '비밀번호';

  @override
  String get confirmPasswordLabel => '비밀번호 확인';

  @override
  String get loginButton => '로그인';

  @override
  String get registerButton => '회원가입';

  @override
  String get noAccount => '계정이 없으신가요? ';

  @override
  String get registerLink => '회원가입';

  @override
  String get hasAccount => '이미 계정이 있으신가요? ';

  @override
  String get loginLink => '로그인';

  @override
  String get createAccount => '새 계정 만들기';

  @override
  String get registerSubtitle => '가입하고 자바 섬 관광지를 발견하세요';

  @override
  String get passwordMismatch => '비밀번호가 일치하지 않습니다';

  @override
  String profileMemberSince(String date) {
    return '$date부터 회원';
  }

  @override
  String get profileWisataLabel => '관광지';

  @override
  String get profileFavoriteLabel => '즐겨찾기';

  @override
  String get profileWisataAdded => '추가한 관광지';

  @override
  String get profileNoWisata => '관광지가 없습니다';

  @override
  String get profileNoWisataHint => '추가한 관광지가 여기에 표시됩니다';

  @override
  String get logout => '로그아웃';

  @override
  String get logoutSubtitle => '계정에서 로그아웃';

  @override
  String get logoutConfirm => '이 계정에서 로그아웃하시겠습니까?';

  @override
  String get cancel => '취소';

  @override
  String get wisataNameLabel => '관광지 이름';

  @override
  String get wisataNameRequired => '관광지 이름을 입력해주세요';

  @override
  String get provinceLabel => '지역';

  @override
  String get cityLabel => '도시/구';

  @override
  String get cityRequired => '도시를 입력해주세요';

  @override
  String get descriptionLabel => '설명';

  @override
  String get descriptionRequired => '설명을 입력해주세요';

  @override
  String ratingLabel(String value) {
    return '평점: $value';
  }

  @override
  String get updateWisata => '관광지 업데이트';

  @override
  String get tapToPickImage => '이미지를 선택하려면 탭하세요';

  @override
  String get maxImageSize => '최대 700KB';

  @override
  String get changeImage => '변경';

  @override
  String get imageTooLarge => '이미지가 너무 큽니다. 압축 후 최대 700KB입니다.';

  @override
  String get selectImage => '관광지 이미지를 선택해주세요';

  @override
  String get detailDescription => '설명';

  @override
  String get detailProvince => '지역';

  @override
  String get detailCity => '도시';

  @override
  String get detailRating => '평점';

  @override
  String deleteConfirm(String name) {
    return '\"$name\"을(를) 삭제하시겠습니까? 이 작업은 취소할 수 없습니다.';
  }

  @override
  String get delete => '삭제';

  @override
  String get language => '언어';

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
