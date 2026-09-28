import 'app_language.dart';

/// Trilingual UI strings. Add a key here, then `si`/`ta` entries as
/// translations land — screens should always read through [Strings.of]
/// rather than hard-coding English.
class Strings {
  static const Map<String, Map<AppLanguage, String>> _values = {
    'appName': {
      AppLanguage.en: 'Sahakara',
      AppLanguage.si: 'සහකාර',
      AppLanguage.ta: 'சஹகார',
    },
    'email': {
      AppLanguage.en: 'Email',
      AppLanguage.si: 'ඊමේල් ලිපිනය',
      AppLanguage.ta: 'மின்னஞ்சல்',
    },
    'password': {
      AppLanguage.en: 'Password',
      AppLanguage.si: 'මුරපදය',
      AppLanguage.ta: 'கடவுச்சொல்',
    },
    'confirmPassword': {
      AppLanguage.en: 'Confirm password',
      AppLanguage.si: 'මුරපදය තහවුරු කරන්න',
      AppLanguage.ta: 'கடவுச்சொல்லை உறுதிப்படுத்தவும்',
    },
    'passwordsDontMatch': {
      AppLanguage.en: 'Passwords do not match',
      AppLanguage.si: 'මුරපද නොගැලපේ',
      AppLanguage.ta: 'கடவுச்சொற்கள் பொருந்தவில்லை',
    },
    'signIn': {
      AppLanguage.en: 'Sign in',
      AppLanguage.si: 'පිවිසෙන්න',
      AppLanguage.ta: 'உள்நுழை',
    },
    'signUp': {
      AppLanguage.en: 'Sign up',
      AppLanguage.si: 'ලියාපදිංචි වන්න',
      AppLanguage.ta: 'பதிவு செய்',
    },
    'noAccount': {
      AppLanguage.en: "Don't have an account? Sign up",
      AppLanguage.si: 'ගිණුමක් නැද්ද? ලියාපදිංචි වන්න',
      AppLanguage.ta: 'கணக்கு இல்லையா? பதிவு செய்யவும்',
    },
    'haveAccount': {
      AppLanguage.en: 'Already have an account? Sign in',
      AppLanguage.si: 'දැනටමත් ගිණුමක් තිබේද? පිවිසෙන්න',
      AppLanguage.ta: 'ஏற்கனவே கணக்கு உள்ளதா? உள்நுழையவும்',
    },
    'language': {
      AppLanguage.en: 'Language',
      AppLanguage.si: 'භාෂාව',
      AppLanguage.ta: 'மொழி',
    },
    'createHousehold': {
      AppLanguage.en: 'Create your household',
      AppLanguage.si: 'ඔබේ නිවස සාදන්න',
      AppLanguage.ta: 'உங்கள் வீட்டை உருவாக்கவும்',
    },
    'householdName': {
      AppLanguage.en: 'Household name',
      AppLanguage.si: 'නිවසේ නම',
      AppLanguage.ta: 'வீட்டின் பெயர்',
    },
    'address': {
      AppLanguage.en: 'Address',
      AppLanguage.si: 'ලිපිනය',
      AppLanguage.ta: 'முகவரி',
    },
    'create': {
      AppLanguage.en: 'Create',
      AppLanguage.si: 'සාදන්න',
      AppLanguage.ta: 'உருவாக்கு',
    },
    'addMaid': {
      AppLanguage.en: 'Add a maid by email',
      AppLanguage.si: 'ඊමේල් මගින් සහායිකාවක් එක් කරන්න',
      AppLanguage.ta: 'மின்னஞ்சல் மூலம் உதவியாளரைச் சேர்க்கவும்',
    },
    'add': {
      AppLanguage.en: 'Add',
      AppLanguage.si: 'එක් කරන්න',
      AppLanguage.ta: 'சேர்',
    },
    'household': {
      AppLanguage.en: 'Household',
      AppLanguage.si: 'නිවස',
      AppLanguage.ta: 'வீடு',
    },
    'contract': {
      AppLanguage.en: 'Contract',
      AppLanguage.si: 'ගිවිසුම',
      AppLanguage.ta: 'ஒப்பந்தம்',
    },
    'tasks': {
      AppLanguage.en: 'Task library',
      AppLanguage.si: 'කාර්ය ලැයිස්තුව',
      AppLanguage.ta: 'பணி பட்டியல்',
    },
    'settings': {
      AppLanguage.en: 'Settings',
      AppLanguage.si: 'සැකසුම්',
      AppLanguage.ta: 'அமைப்புகள்',
    },
    'payType': {
      AppLanguage.en: 'Pay type',
      AppLanguage.si: 'ගෙවීම් වර්ගය',
      AppLanguage.ta: 'ஊதிய வகை',
    },
    'rate': {
      AppLanguage.en: 'Rate (LKR)',
      AppLanguage.si: 'ගාස්තුව (රු)',
      AppLanguage.ta: 'விகிதம் (ரூ)',
    },
    'offDays': {
      AppLanguage.en: 'Off days',
      AppLanguage.si: 'නිවාඩු දින',
      AppLanguage.ta: 'விடுமுறை நாட்கள்',
    },
    'workingHours': {
      AppLanguage.en: 'Working hours',
      AppLanguage.si: 'වැඩ කරන වේලාව',
      AppLanguage.ta: 'வேலை நேரம்',
    },
    'saveContract': {
      AppLanguage.en: 'Save contract',
      AppLanguage.si: 'ගිවිසුම සුරකින්න',
      AppLanguage.ta: 'ஒப்பந்தத்தைச் சேமிக்கவும்',
    },
    'noContract': {
      AppLanguage.en: 'No contract set up yet.',
      AppLanguage.si: 'තවම ගිවිසුමක් සකසා නැත.',
      AppLanguage.ta: 'இன்னும் ஒப்பந்தம் அமைக்கப்படவில்லை.',
    },
    'signOut': {
      AppLanguage.en: 'Sign out',
      AppLanguage.si: 'පිටවන්න',
      AppLanguage.ta: 'வெளியேறு',
    },
    'minutes': {
      AppLanguage.en: 'min',
      AppLanguage.si: 'මිනිත්තු',
      AppLanguage.ta: 'நிமிடம்',
    },
  };

  static String of(String key, AppLanguage lang) {
    return _values[key]?[lang] ?? _values[key]?[AppLanguage.en] ?? key;
  }
}
