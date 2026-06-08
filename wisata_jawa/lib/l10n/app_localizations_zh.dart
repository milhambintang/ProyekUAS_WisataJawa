// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => '爪哇旅游';

  @override
  String get appTagline => '✨ 探索爪哇岛的美丽';

  @override
  String get appSubtitle => '最佳旅游推荐';

  @override
  String get greetingMorning => '早上好';

  @override
  String get greetingAfternoon => '下午好';

  @override
  String get greetingEvening => '傍晚好';

  @override
  String get greetingNight => '晚上好';

  @override
  String get headerTitle => '爪哇岛旅游';

  @override
  String get headerSubtitle => '发现爪哇岛最佳旅游目的地';

  @override
  String get allProvinces => '全部';

  @override
  String get navHome => '首页';

  @override
  String get navSearch => '搜索';

  @override
  String get navFavorites => '收藏';

  @override
  String get navProfile => '个人资料';

  @override
  String get loadingWisata => '正在加载景点...';

  @override
  String get loadingFavorites => '正在加载收藏...';

  @override
  String get searchingWisata => '正在搜索景点...';

  @override
  String get errorOccurred => '哎呀！出错了';

  @override
  String get errorConnection => '请确保您的网络连接稳定';

  @override
  String get errorGeneral => '发生错误';

  @override
  String get emptyWisata => '暂无景点';

  @override
  String get emptyWisataHint => '成为第一个添加景点的人！';

  @override
  String get emptyFavorites => '暂无收藏';

  @override
  String get emptyFavoritesHint => '点击景点上的 ♥ 添加到收藏';

  @override
  String get addWisata => '添加景点';

  @override
  String get editWisata => '编辑景点';

  @override
  String get deleteWisata => '删除景点';

  @override
  String get wisataAdded => '景点添加成功';

  @override
  String get wisataUpdated => '景点更新成功';

  @override
  String get wisataDeleted => '景点删除成功';

  @override
  String wisataFailed(String error) {
    return '失败：$error';
  }

  @override
  String get searchTitle => '搜索景点';

  @override
  String get searchSubtitle => '寻找您的梦想目的地';

  @override
  String get searchHint => '搜索名称、城市或省份...';

  @override
  String get searchFavorite => '搜索您喜欢的景点';

  @override
  String get searchFavoriteHint => '输入景点名称、城市或省份';

  @override
  String get searchNotFound => '未找到景点';

  @override
  String get searchNotFoundHint => '尝试其他关键词';

  @override
  String searchResultCount(int count) {
    return '找到 $count 个景点';
  }

  @override
  String get favoritesTitle => '收藏景点';

  @override
  String get favoritesSubtitle => '您喜欢的景点合集';

  @override
  String favoritesCount(int count) {
    return '$count 个收藏景点';
  }

  @override
  String get loginRequired => '请先登录';

  @override
  String get welcome => '欢迎';

  @override
  String get loginSubtitle => '登录以探索爪哇岛旅游景点';

  @override
  String get emailLabel => '邮箱';

  @override
  String get passwordLabel => '密码';

  @override
  String get confirmPasswordLabel => '确认密码';

  @override
  String get loginButton => '登录';

  @override
  String get registerButton => '注册';

  @override
  String get noAccount => '还没有账号？';

  @override
  String get registerLink => '注册';

  @override
  String get hasAccount => '已有账号？';

  @override
  String get loginLink => '登录';

  @override
  String get createAccount => '创建新账号';

  @override
  String get registerSubtitle => '加入并发现爪哇岛旅游景点';

  @override
  String get passwordMismatch => '密码不匹配';

  @override
  String profileMemberSince(String date) {
    return '注册于 $date';
  }

  @override
  String get profileWisataLabel => '景点';

  @override
  String get profileFavoriteLabel => '收藏';

  @override
  String get profileWisataAdded => '您添加的景点';

  @override
  String get profileNoWisata => '暂无景点';

  @override
  String get profileNoWisataHint => '您添加的景点将显示在这里';

  @override
  String get logout => '退出登录';

  @override
  String get logoutSubtitle => '退出您的账号';

  @override
  String get logoutConfirm => '您确定要退出此账号吗？';

  @override
  String get cancel => '取消';

  @override
  String get wisataNameLabel => '景点名称';

  @override
  String get wisataNameRequired => '请填写景点名称';

  @override
  String get provinceLabel => '省份';

  @override
  String get cityLabel => '城市/区县';

  @override
  String get cityRequired => '请填写城市';

  @override
  String get descriptionLabel => '描述';

  @override
  String get descriptionRequired => '请填写描述';

  @override
  String ratingLabel(String value) {
    return '评分：$value';
  }

  @override
  String get updateWisata => '更新景点';

  @override
  String get tapToPickImage => '点击选择图片';

  @override
  String get maxImageSize => '最大 700KB';

  @override
  String get changeImage => '更换';

  @override
  String get imageTooLarge => '图片太大。压缩后最大700KB。';

  @override
  String get selectImage => '请选择景点图片';

  @override
  String get detailDescription => '描述';

  @override
  String get detailProvince => '省份';

  @override
  String get detailCity => '城市';

  @override
  String get detailRating => '评分';

  @override
  String deleteConfirm(String name) {
    return '您确定要删除 \"$name\" 吗？此操作无法撤消。';
  }

  @override
  String get delete => '删除';

  @override
  String get language => '语言';

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
