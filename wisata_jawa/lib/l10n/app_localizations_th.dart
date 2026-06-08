// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Thai (`th`).
class AppLocalizationsTh extends AppLocalizations {
  AppLocalizationsTh([String locale = 'th']) : super(locale);

  @override
  String get appTitle => 'ท่องเที่ยวชวา';

  @override
  String get appTagline => '✨ สำรวจความงามของเกาะชวา';

  @override
  String get appSubtitle => 'แนะนำสถานที่ท่องเที่ยวที่ดีที่สุด';

  @override
  String get greetingMorning => 'สวัสดีตอนเช้า';

  @override
  String get greetingAfternoon => 'สวัสดีตอนบ่าย';

  @override
  String get greetingEvening => 'สวัสดีตอนเย็น';

  @override
  String get greetingNight => 'สวัสดีตอนกลางคืน';

  @override
  String get headerTitle => 'ท่องเที่ยวเกาะชวา';

  @override
  String get headerSubtitle => 'ค้นพบจุดหมายปลายทางที่ดีที่สุดในเกาะชวา';

  @override
  String get allProvinces => 'ทั้งหมด';

  @override
  String get navHome => 'หน้าแรก';

  @override
  String get navSearch => 'ค้นหา';

  @override
  String get navFavorites => 'รายการโปรด';

  @override
  String get navProfile => 'โปรไฟล์';

  @override
  String get loadingWisata => 'กำลังโหลด...';

  @override
  String get loadingFavorites => 'กำลังโหลดรายการโปรด...';

  @override
  String get searchingWisata => 'กำลังค้นหา...';

  @override
  String get errorOccurred => 'อุ๊ปส์! เกิดข้อผิดพลาด';

  @override
  String get errorConnection => 'กรุณาตรวจสอบการเชื่อมต่ออินเทอร์เน็ต';

  @override
  String get errorGeneral => 'เกิดข้อผิดพลาด';

  @override
  String get emptyWisata => 'ยังไม่มีสถานที่ท่องเที่ยว';

  @override
  String get emptyWisataHint => 'เป็นคนแรกที่เพิ่มสถานที่ท่องเที่ยว!';

  @override
  String get emptyFavorites => 'ยังไม่มีรายการโปรด';

  @override
  String get emptyFavoritesHint =>
      'แตะ ♥ ที่สถานที่ท่องเที่ยวเพื่อเพิ่มในรายการโปรด';

  @override
  String get addWisata => 'เพิ่มสถานที่ท่องเที่ยว';

  @override
  String get editWisata => 'แก้ไขสถานที่ท่องเที่ยว';

  @override
  String get deleteWisata => 'ลบสถานที่ท่องเที่ยว';

  @override
  String get wisataAdded => 'เพิ่มสถานที่ท่องเที่ยวสำเร็จ';

  @override
  String get wisataUpdated => 'อัปเดตสถานที่ท่องเที่ยวสำเร็จ';

  @override
  String get wisataDeleted => 'ลบสถานที่ท่องเที่ยวสำเร็จ';

  @override
  String wisataFailed(String error) {
    return 'ล้มเหลว: $error';
  }

  @override
  String get searchTitle => 'ค้นหาสถานที่ท่องเที่ยว';

  @override
  String get searchSubtitle => 'ค้นหาจุดหมายในฝันของคุณ';

  @override
  String get searchHint => 'ค้นหาชื่อ เมือง หรือจังหวัด...';

  @override
  String get searchFavorite => 'ค้นหาสถานที่โปรดของคุณ';

  @override
  String get searchFavoriteHint => 'พิมพ์ชื่อสถานที่ เมือง หรือจังหวัด';

  @override
  String get searchNotFound => 'ไม่พบสถานที่ท่องเที่ยว';

  @override
  String get searchNotFoundHint => 'ลองใช้คำค้นอื่น';

  @override
  String searchResultCount(int count) {
    return 'พบ $count สถานที่';
  }

  @override
  String get favoritesTitle => 'สถานที่โปรด';

  @override
  String get favoritesSubtitle => 'คอลเลกชันสถานที่ที่คุณชอบ';

  @override
  String favoritesCount(int count) {
    return '$count สถานที่โปรด';
  }

  @override
  String get loginRequired => 'กรุณาเข้าสู่ระบบก่อน';

  @override
  String get welcome => 'ยินดีต้อนรับ';

  @override
  String get loginSubtitle => 'เข้าสู่ระบบเพื่อสำรวจสถานที่ท่องเที่ยวเกาะชวา';

  @override
  String get emailLabel => 'อีเมล';

  @override
  String get passwordLabel => 'รหัสผ่าน';

  @override
  String get confirmPasswordLabel => 'ยืนยันรหัสผ่าน';

  @override
  String get loginButton => 'เข้าสู่ระบบ';

  @override
  String get registerButton => 'สมัครสมาชิก';

  @override
  String get noAccount => 'ยังไม่มีบัญชี? ';

  @override
  String get registerLink => 'สมัครสมาชิก';

  @override
  String get hasAccount => 'มีบัญชีแล้ว? ';

  @override
  String get loginLink => 'เข้าสู่ระบบ';

  @override
  String get createAccount => 'สร้างบัญชีใหม่';

  @override
  String get registerSubtitle => 'เข้าร่วมและค้นพบสถานที่ท่องเที่ยวเกาะชวา';

  @override
  String get passwordMismatch => 'รหัสผ่านไม่ตรงกัน';

  @override
  String profileMemberSince(String date) {
    return 'สมาชิกตั้งแต่ $date';
  }

  @override
  String get profileWisataLabel => 'สถานที่';

  @override
  String get profileFavoriteLabel => 'รายการโปรด';

  @override
  String get profileWisataAdded => 'สถานที่ที่คุณเพิ่ม';

  @override
  String get profileNoWisata => 'ยังไม่มีสถานที่';

  @override
  String get profileNoWisataHint => 'สถานที่ที่คุณเพิ่มจะปรากฏที่นี่';

  @override
  String get logout => 'ออกจากระบบ';

  @override
  String get logoutSubtitle => 'ออกจากบัญชีของคุณ';

  @override
  String get logoutConfirm => 'คุณแน่ใจหรือไม่ว่าต้องการออกจากบัญชีนี้?';

  @override
  String get cancel => 'ยกเลิก';

  @override
  String get wisataNameLabel => 'ชื่อสถานที่ท่องเที่ยว';

  @override
  String get wisataNameRequired => 'กรุณากรอกชื่อสถานที่';

  @override
  String get provinceLabel => 'จังหวัด';

  @override
  String get cityLabel => 'เมือง/อำเภอ';

  @override
  String get cityRequired => 'กรุณากรอกชื่อเมือง';

  @override
  String get descriptionLabel => 'คำอธิบาย';

  @override
  String get descriptionRequired => 'กรุณากรอกคำอธิบาย';

  @override
  String ratingLabel(String value) {
    return 'คะแนน: $value';
  }

  @override
  String get updateWisata => 'อัปเดตสถานที่';

  @override
  String get tapToPickImage => 'แตะเพื่อเลือกรูปภาพ';

  @override
  String get maxImageSize => 'สูงสุด 700KB';

  @override
  String get changeImage => 'เปลี่ยน';

  @override
  String get imageTooLarge => 'รูปภาพใหญ่เกินไป สูงสุด 700KB หลังบีบอัด';

  @override
  String get selectImage => 'กรุณาเลือกรูปภาพสถานที่ท่องเที่ยว';

  @override
  String get detailDescription => 'คำอธิบาย';

  @override
  String get detailProvince => 'จังหวัด';

  @override
  String get detailCity => 'เมือง';

  @override
  String get detailRating => 'คะแนน';

  @override
  String deleteConfirm(String name) {
    return 'คุณแน่ใจหรือไม่ว่าต้องการลบ \"$name\"? การกระทำนี้ไม่สามารถยกเลิกได้';
  }

  @override
  String get delete => 'ลบ';

  @override
  String get language => 'ภาษา';

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
