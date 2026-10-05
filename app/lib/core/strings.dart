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
    'changePassword': {
      AppLanguage.en: 'Change password',
      AppLanguage.si: 'මුරපදය වෙනස් කරන්න',
      AppLanguage.ta: 'கடவுச்சொல்லை மாற்று',
    },
    'currentPassword': {
      AppLanguage.en: 'Current password',
      AppLanguage.si: 'වත්මන් මුරපදය',
      AppLanguage.ta: 'தற்போதைய கடவுச்சொல்',
    },
    'newPassword': {
      AppLanguage.en: 'New password',
      AppLanguage.si: 'නව මුරපදය',
      AppLanguage.ta: 'புதிய கடவுச்சொல்',
    },
    'wrongCurrentPassword': {
      AppLanguage.en: 'Current password is incorrect',
      AppLanguage.si: 'වත්මන් මුරපදය වැරදියි',
      AppLanguage.ta: 'தற்போதைய கடவுச்சொல் தவறானது',
    },
    'passwordChanged': {
      AppLanguage.en: 'Password updated',
      AppLanguage.si: 'මුරපදය යාවත්කාලීන කරන ලදී',
      AppLanguage.ta: 'கடவுச்சொல் புதுப்பிக்கப்பட்டது',
    },
    'myProfile': {
      AppLanguage.en: 'My profile',
      AppLanguage.si: 'මගේ පැතිකඩ',
      AppLanguage.ta: 'என் சுயவிவரம்',
    },
    'preferredAreas': {
      AppLanguage.en: 'Preferred work areas',
      AppLanguage.si: 'කැමති වැඩ කරන ප්‍රදේශ',
      AppLanguage.ta: 'விரும்பும் பணிப் பகுதிகள்',
    },
    'addArea': {
      AppLanguage.en: 'Add an area, e.g. Nugegoda',
      AppLanguage.si: 'ප්‍රදේශයක් එක් කරන්න, උදා. නුගේගොඩ',
      AppLanguage.ta: 'ஒரு பகுதியைச் சேர்க்கவும், எ.கா. நுகேகொடை',
    },
    'languagesISpeak': {
      AppLanguage.en: 'Languages I speak',
      AppLanguage.si: 'මා කතා කරන භාෂා',
      AppLanguage.ta: 'நான் பேசும் மொழிகள்',
    },
    'appLanguage': {
      AppLanguage.en: 'App language',
      AppLanguage.si: 'යෙදුමේ භාෂාව',
      AppLanguage.ta: 'செயலி மொழி',
    },
    'profileSaved': {
      AppLanguage.en: 'Profile saved',
      AppLanguage.si: 'පැතිකඩ සුරකින ලදී',
      AppLanguage.ta: 'சுயவிவரம் சேமிக்கப்பட்டது',
    },
    'houseLocation': {
      AppLanguage.en: 'House location',
      AppLanguage.si: 'නිවසේ පිහිටීම',
      AppLanguage.ta: 'வீட்டின் இருப்பிடம்',
    },
    'houseArea': {
      AppLanguage.en: 'Area',
      AppLanguage.si: 'ප්‍රදේශය',
      AppLanguage.ta: 'பகுதி',
    },
    'houseAreaHint': {
      AppLanguage.en: 'e.g. Nugegoda',
      AppLanguage.si: 'උදා. නුගේගොඩ',
      AppLanguage.ta: 'எ.கா. நுகேகொடை',
    },
    'languagesSpoken': {
      AppLanguage.en: 'Languages spoken',
      AppLanguage.si: 'කතා කරන භාෂා',
      AppLanguage.ta: 'பேசும் மொழிகள்',
    },
    'profileEmpty': {
      AppLanguage.en: 'No profile details added yet.',
      AppLanguage.si: 'තවම පැතිකඩ විස්තර එක් කර නැත.',
      AppLanguage.ta: 'சுயவிவர விவரங்கள் இன்னும் சேர்க்கப்படவில்லை.',
    },
    'viewProfile': {
      AppLanguage.en: 'View profile',
      AppLanguage.si: 'පැතිකඩ බලන්න',
      AppLanguage.ta: 'சுயவிவரத்தைப் பார்',
    },
    'maidProfile': {
      AppLanguage.en: "Maid's profile",
      AppLanguage.si: 'සහායකයාගේ පැතිකඩ',
      AppLanguage.ta: 'பணியாளரின் சுயவிவரம்',
    },
    'maidNotOnSahakara': {
      AppLanguage.en:
          "This email isn't on Sahakara yet, so there's no profile to show. "
              'They will see your request when they sign up with it.',
      AppLanguage.si:
          'මෙම ඊමේල් ලිපිනය තවම සහකාර හි නැති නිසා පෙන්වීමට පැතිකඩක් නැත. '
              'ඔවුන් එයින් ලියාපදිංචි වූ විට ඔබගේ ඉල්ලීම දකිනු ඇත.',
      AppLanguage.ta:
          'இந்த மின்னஞ்சல் இன்னும் சஹகாரவில் இல்லை, எனவே காட்ட சுயவிவரம் இல்லை. '
              'அவர் அதைக் கொண்டு பதிவு செய்யும்போது உங்கள் கோரிக்கையைப் பார்ப்பார்.',
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
    'imOwner': {
      AppLanguage.en: 'I\'m a house owner',
      AppLanguage.si: 'මම නිවස් හිමිකරුවෙක්',
      AppLanguage.ta: 'நான் வீட்டு உரிமையாளர்',
    },
    'ownerBlurb': {
      AppLanguage.en: 'Manage your household and staff',
      AppLanguage.si: 'ඔබේ නිවස සහ සේවකයින් කළමනාකරණය කරන්න',
      AppLanguage.ta: 'உங்கள் வீட்டையும் பணியாளர்களையும் நிர்வகிக்கவும்',
    },
    'imMaid': {
      AppLanguage.en: 'I\'m a maid',
      AppLanguage.si: 'මම සහායකයෙක්',
      AppLanguage.ta: 'நான் வீட்டுப் பணியாளர்',
    },
    'maidBlurb': {
      AppLanguage.en: 'See your tasks, contract and pay',
      AppLanguage.si: 'ඔබේ කාර්යයන්, ගිවිසුම සහ වැටුප බලන්න',
      AppLanguage.ta: 'உங்கள் பணிகள், ஒப்பந்தம் மற்றும் ஊதியத்தைப் பாருங்கள்',
    },
    'name': {
      AppLanguage.en: 'Your name',
      AppLanguage.si: 'ඔබේ නම',
      AppLanguage.ta: 'உங்கள் பெயர்',
    },
    'nameRequired': {
      AppLanguage.en: 'Please enter your name',
      AppLanguage.si: 'කරුණාකර ඔබේ නම ඇතුළත් කරන්න',
      AppLanguage.ta: 'உங்கள் பெயரை உள்ளிடவும்',
    },
    'registeredAsOwner': {
      AppLanguage.en:
          'This account is registered as a house owner. Sign in here instead.',
      AppLanguage.si:
          'මෙම ගිණුම නිවස් හිමිකරුවෙකු ලෙස ලියාපදිංචි කර ඇත. මෙතැනින් පිවිසෙන්න.',
      AppLanguage.ta:
          'இந்தக் கணக்கு வீட்டு உரிமையாளராகப் பதிவு செய்யப்பட்டுள்ளது. இங்கே உள்நுழையவும்.',
    },
    'registeredAsMaid': {
      AppLanguage.en:
          'This account is registered as a maid. Sign in here instead.',
      AppLanguage.si:
          'මෙම ගිණුම සහායකයෙකු ලෙස ලියාපදිංචි කර ඇත. මෙතැනින් පිවිසෙන්න.',
      AppLanguage.ta:
          'இந்தக் கணக்கு வீட்டுப் பணியாளராகப் பதிவு செய்யப்பட்டுள்ளது. இங்கே உள்நுழையவும்.',
    },
    'adminUseWebPanel': {
      AppLanguage.en:
          'This is an admin account. Please use the Sahakara web admin panel.',
      AppLanguage.si:
          'මෙය පරිපාලක ගිණුමකි. කරුණාකර සහකාර වෙබ් පරිපාලන පුවරුව භාවිතා කරන්න.',
      AppLanguage.ta:
          'இது ஒரு நிர்வாகி கணக்கு. சஹகார இணைய நிர்வாகப் பலகத்தைப் பயன்படுத்தவும்.',
    },
    'waitingForHousehold': {
      AppLanguage.en: 'Waiting to join a household',
      AppLanguage.si: 'නිවසකට එක්වීමට රැඳී සිටී',
      AppLanguage.ta: 'ஒரு வீட்டில் சேரக் காத்திருக்கிறது',
    },
    'waitingForHouseholdBody': {
      AppLanguage.en:
          'Ask the house owner to add you in Sahakara using this email:',
      AppLanguage.si:
          'මෙම ඊමේල් ලිපිනය භාවිතයෙන් ඔබව සහකාර වෙත එක් කරන ලෙස නිවස් හිමිකරුගෙන් ඉල්ලන්න:',
      AppLanguage.ta:
          'இந்த மின்னஞ்சலைப் பயன்படுத்தி உங்களை சஹகாரவில் சேர்க்க வீட்டு உரிமையாளரிடம் கேளுங்கள்:',
    },
    'checkAgain': {
      AppLanguage.en: 'Check again',
      AppLanguage.si: 'නැවත පරීක්ෂා කරන්න',
      AppLanguage.ta: 'மீண்டும் சரிபார்க்கவும்',
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
      AppLanguage.si: 'ඊමේල් මගින් සහායකයෙකු එක් කරන්න',
      AppLanguage.ta: 'மின்னஞ்சல் மூலம் உதவியாளரைச் சேர்க்கவும்',
    },
    'enterMaidEmail': {
      AppLanguage.en: "Enter the maid's email address",
      AppLanguage.si: 'සහායකයාගේ ඊමේල් ලිපිනය ඇතුළත් කරන්න',
      AppLanguage.ta: 'உதவியாளரின் மின்னஞ்சல் முகவரியை உள்ளிடவும்',
    },
    'contractSentAsRequest': {
      AppLanguage.en:
          'This is sent to them as a request. They join the household once they accept it.',
      AppLanguage.si:
          'මෙය ඔවුන්ට ඉල්ලීමක් ලෙස යවනු ලැබේ. ඔවුන් එය පිළිගත් පසු නිවසට එක් වේ.',
      AppLanguage.ta:
          'இது அவருக்குக் கோரிக்கையாக அனுப்பப்படும். அவர் ஏற்றுக்கொண்டதும் வீட்டில் சேர்வார்.',
    },
    'sendRequest': {
      AppLanguage.en: 'Send request',
      AppLanguage.si: 'ඉල්ලීම යවන්න',
      AppLanguage.ta: 'கோரிக்கையை அனுப்பவும்',
    },
    'invite_pending': {
      AppLanguage.en: 'Waiting for them to accept',
      AppLanguage.si: 'ඔවුන් පිළිගන්නා තෙක් රැඳී සිටී',
      AppLanguage.ta: 'அவர் ஏற்றுக்கொள்ளக் காத்திருக்கிறது',
    },
    'invite_declined': {
      AppLanguage.en: 'Declined the request',
      AppLanguage.si: 'ඉල්ලීම ප්‍රතික්ෂේප කළා',
      AppLanguage.ta: 'கோரிக்கையை நிராகரித்தார்',
    },
    'cancelRequest': {
      AppLanguage.en: 'Cancel request',
      AppLanguage.si: 'ඉල්ලීම අවලංගු කරන්න',
      AppLanguage.ta: 'கோரிக்கையை ரத்து செய்',
    },
    'remove': {
      AppLanguage.en: 'Remove',
      AppLanguage.si: 'ඉවත් කරන්න',
      AppLanguage.ta: 'அகற்று',
    },
    'joinRequests': {
      AppLanguage.en: 'Requests',
      AppLanguage.si: 'ඉල්ලීම්',
      AppLanguage.ta: 'கோரிக்கைகள்',
    },
    'noJoinRequests': {
      AppLanguage.en: 'No pending household requests.',
      AppLanguage.si: 'පොරොත්තු වන නිවාස ඉල්ලීම් නැත.',
      AppLanguage.ta: 'நிலுவையில் உள்ள வீட்டு கோரிக்கைகள் இல்லை.',
    },
    'accept': {
      AppLanguage.en: 'Accept',
      AppLanguage.si: 'පිළිගන්න',
      AppLanguage.ta: 'ஏற்றுக்கொள்',
    },
    'decline': {
      AppLanguage.en: 'Decline',
      AppLanguage.si: 'ප්‍රතික්ෂේප කරන්න',
      AppLanguage.ta: 'நிராகரி',
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
    'payType_monthly': {
      AppLanguage.en: 'Monthly basic salary',
      AppLanguage.si: 'මාසික මූලික වැටුප',
      AppLanguage.ta: 'மாதாந்திர அடிப்படைச் சம்பளம்',
    },
    'payType_daily': {
      AppLanguage.en: 'Daily wage',
      AppLanguage.si: 'දෛනික වැටුප',
      AppLanguage.ta: 'தினசரி கூலி',
    },
    'payType_hourly': {
      AppLanguage.en: 'Hourly rate',
      AppLanguage.si: 'පැයකට ගාස්තුව',
      AppLanguage.ta: 'மணிநேர விகிதம்',
    },
    'payType_per_visit': {
      AppLanguage.en: 'Per visit',
      AppLanguage.si: 'වරකට',
      AppLanguage.ta: 'ஒரு வருகைக்கு',
    },
    'rate_monthly': {
      AppLanguage.en: 'Monthly basic salary (LKR)',
      AppLanguage.si: 'මාසික මූලික වැටුප (රු)',
      AppLanguage.ta: 'மாதாந்திர அடிப்படைச் சம்பளம் (ரூ)',
    },
    'rate_daily': {
      AppLanguage.en: 'Daily wage (LKR)',
      AppLanguage.si: 'දෛනික වැටුප (රු)',
      AppLanguage.ta: 'தினசரி கூலி (ரூ)',
    },
    'rate_hourly': {
      AppLanguage.en: 'Hourly rate (LKR)',
      AppLanguage.si: 'පැයකට ගාස්තුව (රු)',
      AppLanguage.ta: 'மணிநேர விகிதம் (ரூ)',
    },
    'rate_per_visit': {
      AppLanguage.en: 'Amount per visit (LKR)',
      AppLanguage.si: 'වරකට මුදල (රු)',
      AppLanguage.ta: 'ஒரு வருகைக்கான தொகை (ரூ)',
    },
    'allowance': {
      AppLanguage.en: 'Fixed allowance (LKR)',
      AppLanguage.si: 'ස්ථාවර දීමනාව (රු)',
      AppLanguage.ta: 'நிலையான கொடுப்பனவு (ரூ)',
    },
    'allowanceHint': {
      AppLanguage.en: 'Optional · paid every month on top of the basic salary',
      AppLanguage.si: 'අත්‍යවශ්‍ය නොවේ · මූලික වැටුපට අමතරව සෑම මසකම ගෙවේ',
      AppLanguage.ta:
          'விருப்பத்தேர்வு · அடிப்படைச் சம்பளத்துடன் ஒவ்வொரு மாதமும் வழங்கப்படும்',
    },
    'enterValidAllowance': {
      AppLanguage.en: 'Enter a valid allowance, or leave it blank',
      AppLanguage.si: 'වලංගු දීමනාවක් ඇතුළත් කරන්න, නැතහොත් හිස්ව තබන්න',
      AppLanguage.ta: 'சரியான கொடுப்பனவை உள்ளிடவும், அல்லது காலியாக விடவும்',
    },
    'required': {
      AppLanguage.en: 'Required',
      AppLanguage.si: 'අනිවාර්යයි',
      AppLanguage.ta: 'கட்டாயம்',
    },
    'optional': {
      AppLanguage.en: 'Optional',
      AppLanguage.si: 'අත්‍යවශ්‍ය නොවේ',
      AppLanguage.ta: 'விருப்பத்தேர்வு',
    },
    'enterValidAmount': {
      AppLanguage.en: 'Enter a valid amount',
      AppLanguage.si: 'වලංගු මුදලක් ඇතුළත් කරන්න',
      AppLanguage.ta: 'சரியான தொகையை உள்ளிடவும்',
    },
    'contractSaved': {
      AppLanguage.en: 'Contract saved successfully',
      AppLanguage.si: 'ගිවිසුම සාර්ථකව සුරකින ලදී',
      AppLanguage.ta: 'ஒப்பந்தம் வெற்றிகரமாகச் சேமிக்கப்பட்டது',
    },
    'requestSent': {
      AppLanguage.en: 'Request sent successfully',
      AppLanguage.si: 'ඉල්ලීම සාර්ථකව යවන ලදී',
      AppLanguage.ta: 'கோரிக்கை வெற்றிகரமாக அனுப்பப்பட்டது',
    },
    'requestSentBody': {
      AppLanguage.en:
          'They will join the household once they accept the contract.',
      AppLanguage.si: 'ඔවුන් ගිවිසුම පිළිගත් පසු නිවසට එක් වේ.',
      AppLanguage.ta: 'அவர் ஒப்பந்தத்தை ஏற்றுக்கொண்டதும் வீட்டில் சேர்வார்.',
    },
    'ok': {
      AppLanguage.en: 'OK',
      AppLanguage.si: 'හරි',
      AppLanguage.ta: 'சரி',
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
    'contractMissingAskOwner': {
      AppLanguage.en:
          'Your contract is not available yet. Ask the household owner to add or update your contract, then refresh this page.',
      AppLanguage.si:
          'ඔබගේ ගිවිසුම තවම ලබා ගත නොහැක. ගෘහ හිමිකරුගෙන් ගිවිසුම එක් කිරීමට හෝ යාවත්කාලීන කිරීමට ඉල්ලා මෙම පිටුව නැවත පූරණය කරන්න.',
      AppLanguage.ta:
          'உங்கள் ஒப்பந்தம் இன்னும் கிடைக்கவில்லை. வீட்டின் உரிமையாளரிடம் ஒப்பந்தத்தைச் சேர்க்க அல்லது புதுப்பிக்கச் சொல்லி, இந்தப் பக்கத்தைப் புதுப்பிக்கவும்.',
    },
    'contractLoadFailed': {
      AppLanguage.en: 'Could not load the contract.',
      AppLanguage.si: 'ගිවිසුම පූරණය කළ නොහැකි විය.',
      AppLanguage.ta: 'ஒப்பந்தத்தை ஏற்ற முடியவில்லை.',
    },
    'refresh': {
      AppLanguage.en: 'Refresh',
      AppLanguage.si: 'නැවත පූරණය කරන්න',
      AppLanguage.ta: 'புதுப்பி',
    },
    'retry': {
      AppLanguage.en: 'Try again',
      AppLanguage.si: 'නැවත උත්සාහ කරන්න',
      AppLanguage.ta: 'மீண்டும் முயற்சி செய்',
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
    'dailyTasks': {
      AppLanguage.en: 'Daily tasks',
      AppLanguage.si: 'දෛනික කාර්යයන්',
      AppLanguage.ta: 'தினசரி பணிகள்',
    },
    'myTasks': {
      AppLanguage.en: 'My tasks',
      AppLanguage.si: 'මගේ කාර්ය',
      AppLanguage.ta: 'என் பணிகள்',
    },
    'myContract': {
      AppLanguage.en: 'My contract',
      AppLanguage.si: 'මගේ ගිවිසුම',
      AppLanguage.ta: 'என் ஒப்பந்தம்',
    },
    'hello': {
      AppLanguage.en: 'Hello',
      AppLanguage.si: 'ආයුබෝවන්',
      AppLanguage.ta: 'வணக்கம்',
    },
    'tasksDone': {
      AppLanguage.en: '{done} of {total} tasks done',
      AppLanguage.si: 'කාර්ය {total} න් {done} ක් අවසන්',
      AppLanguage.ta: '{total} பணிகளில் {done} முடிந்தது',
    },
    'addTask': {
      AppLanguage.en: 'Add task',
      AppLanguage.si: 'කාර්යයක් එක් කරන්න',
      AppLanguage.ta: 'பணியைச் சேர்',
    },
    'assignTo': {
      AppLanguage.en: 'Assign to',
      AppLanguage.si: 'පවරන්න',
      AppLanguage.ta: 'ஒதுக்கவும்',
    },
    'task': {
      AppLanguage.en: 'Task',
      AppLanguage.si: 'කාර්යය',
      AppLanguage.ta: 'பணி',
    },
    'customTask': {
      AppLanguage.en: 'Other (type it in)',
      AppLanguage.si: 'වෙනත් (ටයිප් කරන්න)',
      AppLanguage.ta: 'மற்றவை (தட்டச்சு செய்யவும்)',
    },
    'noLibraryTasks': {
      AppLanguage.en: 'No default tasks yet. Tap "Other" below to type one in.',
      AppLanguage.si: 'තවම පෙරනිමි කාර්ය නැත. ටයිප් කිරීමට පහත "වෙනත්" ඔබන්න.',
      AppLanguage.ta:
          'இன்னும் இயல்புநிலை பணிகள் இல்லை. தட்டச்சு செய்ய கீழே "மற்றவை" அழுத்தவும்.',
    },
    'whatTask': {
      AppLanguage.en: 'What needs to be done?',
      AppLanguage.si: 'කළ යුත්තේ කුමක්ද?',
      AppLanguage.ta: 'என்ன செய்ய வேண்டும்?',
    },
    'whoAndWhen': {
      AppLanguage.en: 'Who and when',
      AppLanguage.si: 'කවුද සහ කවදාද',
      AppLanguage.ta: 'யார், எப்போது',
    },
    'detailsOptional': {
      AppLanguage.en: 'Details (optional)',
      AppLanguage.si: 'විස්තර (අත්‍යවශ්‍ය නොවේ)',
      AppLanguage.ta: 'விவரங்கள் (விருப்பத்தேர்வு)',
    },
    'today': {
      AppLanguage.en: 'Today',
      AppLanguage.si: 'අද',
      AppLanguage.ta: 'இன்று',
    },
    'tomorrow': {
      AppLanguage.en: 'Tomorrow',
      AppLanguage.si: 'හෙට',
      AppLanguage.ta: 'நாளை',
    },
    'pickDate': {
      AppLanguage.en: 'Pick a date',
      AppLanguage.si: 'දිනයක් තෝරන්න',
      AppLanguage.ta: 'தேதியைத் தேர்ந்தெடுக்கவும்',
    },
    'otherMinutes': {
      AppLanguage.en: 'Or type the minutes',
      AppLanguage.si: 'නැතහොත් මිනිත්තු ගණන ටයිප් කරන්න',
      AppLanguage.ta: 'அல்லது நிமிடங்களைத் தட்டச்சு செய்யவும்',
    },
    'chooseTaskError': {
      AppLanguage.en: 'Choose a task or type one in',
      AppLanguage.si: 'කාර්යයක් තෝරන්න හෝ ටයිප් කරන්න',
      AppLanguage.ta: 'ஒரு பணியைத் தேர்ந்தெடுக்கவும் அல்லது தட்டச்சு செய்யவும்',
    },
    'minutesError': {
      AppLanguage.en: 'Enter the minutes as a whole number',
      AppLanguage.si: 'මිනිත්තු පූර්ණ සංඛ්‍යාවක් ලෙස ඇතුළත් කරන්න',
      AppLanguage.ta: 'நிமிடங்களை முழு எண்ணாக உள்ளிடவும்',
    },
    'searchTasks': {
      AppLanguage.en: 'Search tasks',
      AppLanguage.si: 'කාර්ය සොයන්න',
      AppLanguage.ta: 'பணிகளைத் தேடவும்',
    },
    'noTaskMatches': {
      AppLanguage.en: 'No matching tasks. Tap "Other" below to type it in.',
      AppLanguage.si: 'ගැළපෙන කාර්ය නැත. ටයිප් කිරීමට පහත "වෙනත්" ඔබන්න.',
      AppLanguage.ta:
          'பொருந்தும் பணிகள் இல்லை. தட்டச்சு செய்ய கீழே "மற்றவை" அழுத்தவும்.',
    },
    'category_cleaning': {
      AppLanguage.en: 'Cleaning',
      AppLanguage.si: 'පිරිසිදු කිරීම',
      AppLanguage.ta: 'சுத்தம்',
    },
    'category_kitchen': {
      AppLanguage.en: 'Kitchen',
      AppLanguage.si: 'කුස්සිය',
      AppLanguage.ta: 'சமையலறை',
    },
    'category_cooking': {
      AppLanguage.en: 'Cooking',
      AppLanguage.si: 'ආහාර පිසීම',
      AppLanguage.ta: 'சமையல்',
    },
    'category_laundry': {
      AppLanguage.en: 'Laundry',
      AppLanguage.si: 'රෙදි සේදීම',
      AppLanguage.ta: 'சலவை',
    },
    'category_other': {
      AppLanguage.en: 'Outdoor, errands and family',
      AppLanguage.si: 'එළිමහන, පණිවිඩ සහ පවුල',
      AppLanguage.ta: 'வெளிப்புறம், வேலைகள், குடும்பம்',
    },
    'customTaskTitle': {
      AppLanguage.en: 'Task title',
      AppLanguage.si: 'කාර්යයේ නම',
      AppLanguage.ta: 'பணியின் பெயர்',
    },
    'estMinutes': {
      AppLanguage.en: 'Estimated minutes',
      AppLanguage.si: 'ඇස්තමේන්තුගත මිනිත්තු',
      AppLanguage.ta: 'மதிப்பிடப்பட்ட நிமிடங்கள்',
    },
    'addPhoto': {
      AppLanguage.en: 'Add a photo (optional)',
      AppLanguage.si: 'ඡායාරූපයක් එක් කරන්න (අත්‍යවශ්‍ය නොවේ)',
      AppLanguage.ta: 'புகைப்படம் சேர்க்கவும் (விருப்பத்தேர்வு)',
    },
    'addPhotoHint': {
      AppLanguage.en: 'Show what needs to be done',
      AppLanguage.si: 'කළ යුතු දේ පෙන්වන්න',
      AppLanguage.ta: 'என்ன செய்ய வேண்டும் என்பதைக் காட்டுங்கள்',
    },
    'takePhoto': {
      AppLanguage.en: 'Take a photo',
      AppLanguage.si: 'ඡායාරූපයක් ගන්න',
      AppLanguage.ta: 'புகைப்படம் எடுக்கவும்',
    },
    'chooseFromGallery': {
      AppLanguage.en: 'Choose from gallery',
      AppLanguage.si: 'ගැලරියෙන් තෝරන්න',
      AppLanguage.ta: 'கேலரியிலிருந்து தேர்ந்தெடுக்கவும்',
    },
    'priority': {
      AppLanguage.en: 'Priority',
      AppLanguage.si: 'ප්‍රමුඛතාව',
      AppLanguage.ta: 'முன்னுரிமை',
    },
    'priority_high': {
      AppLanguage.en: 'High',
      AppLanguage.si: 'ඉහළ',
      AppLanguage.ta: 'அதிகம்',
    },
    'priority_medium': {
      AppLanguage.en: 'Medium',
      AppLanguage.si: 'මධ්‍යම',
      AppLanguage.ta: 'நடுத்தரம்',
    },
    'priority_low': {
      AppLanguage.en: 'Low',
      AppLanguage.si: 'අඩු',
      AppLanguage.ta: 'குறைவு',
    },
    'date': {
      AppLanguage.en: 'Date',
      AppLanguage.si: 'දිනය',
      AppLanguage.ta: 'தேதி',
    },
    'noTasksForDay': {
      AppLanguage.en: 'No tasks for this day.',
      AppLanguage.si: 'මෙම දිනයට කාර්යයන් නැත.',
      AppLanguage.ta: 'இந்த நாளுக்கு பணிகள் இல்லை.',
    },
    'noStaffYet': {
      AppLanguage.en: 'Add household staff from the Household tab first.',
      AppLanguage.si: 'පළමුව නිවස ටැබයෙන් සේවකයින් එක් කරන්න.',
      AppLanguage.ta: 'முதலில் வீடு தாவலில் பணியாளர்களைச் சேர்க்கவும்.',
    },
    'status_pending': {
      AppLanguage.en: 'Not started',
      AppLanguage.si: 'ආරම්භ කර නැත',
      AppLanguage.ta: 'தொடங்கவில்லை',
    },
    'status_started': {
      AppLanguage.en: 'Started',
      AppLanguage.si: 'ආරම්භ කළා',
      AppLanguage.ta: 'தொடங்கியது',
    },
    'status_done': {
      AppLanguage.en: 'Done',
      AppLanguage.si: 'අවසන්',
      AppLanguage.ta: 'முடிந்தது',
    },
    'status_need_help': {
      AppLanguage.en: 'Need help',
      AppLanguage.si: 'උදව් අවශ්‍යයි',
      AppLanguage.ta: 'உதவி தேவை',
    },
    'status_cant_do': {
      AppLanguage.en: "Can't do",
      AppLanguage.si: 'කළ නොහැක',
      AppLanguage.ta: 'செய்ய முடியாது',
    },
    'status_carried_forward': {
      AppLanguage.en: 'Moved to next day',
      AppLanguage.si: 'ඊළඟ දිනට ගෙන ගියා',
      AppLanguage.ta: 'அடுத்த நாளுக்கு மாற்றப்பட்டது',
    },
    'whyCantDo': {
      AppLanguage.en: "Why can't it be done?",
      AppLanguage.si: 'එය කළ නොහැක්කේ ඇයි?',
      AppLanguage.ta: 'ஏன் செய்ய முடியாது?',
    },
    'reason_no_supplies': {
      AppLanguage.en: 'No supplies',
      AppLanguage.si: 'අවශ්‍ය ද්‍රව්‍ය නැත',
      AppLanguage.ta: 'பொருட்கள் இல்லை',
    },
    'reason_power_cut': {
      AppLanguage.en: 'Power cut',
      AppLanguage.si: 'විදුලිය විසන්ධි වී ඇත',
      AppLanguage.ta: 'மின்வெட்டு',
    },
    'reason_water_cut': {
      AppLanguage.en: 'Water cut',
      AppLanguage.si: 'ජලය කපා ඇත',
      AppLanguage.ta: 'தண்ணீர் இல்லை',
    },
    'reason_sick': {
      AppLanguage.en: 'Sick',
      AppLanguage.si: 'අසනීපයි',
      AppLanguage.ta: 'உடல்நலமில்லை',
    },
    'reason_no_time': {
      AppLanguage.en: 'No time',
      AppLanguage.si: 'වේලාව නැත',
      AppLanguage.ta: 'நேரம் இல்லை',
    },
    'reason_other': {
      AppLanguage.en: 'Other',
      AppLanguage.si: 'වෙනත්',
      AppLanguage.ta: 'மற்றவை',
    },
    'unassigned': {
      AppLanguage.en: 'Not assigned yet',
      AppLanguage.si: 'තවම පවරා නැත',
      AppLanguage.ta: 'இன்னும் ஒதுக்கப்படவில்லை',
    },
    'assignLaterHint': {
      AppLanguage.en:
          'No staff yet. Add them from the Household tab, then assign this task from the Daily tasks list.',
      AppLanguage.si:
          'තවම සේවකයින් නැත. නිවස ටැබයෙන් ඔවුන් එක් කර, පසුව දෛනික කාර්ය ලැයිස්තුවෙන් මෙම කාර්යය පවරන්න.',
      AppLanguage.ta:
          'இன்னும் பணியாளர்கள் இல்லை. வீடு தாவலில் அவர்களைச் சேர்த்து, பின்னர் தினசரி பணிகள் பட்டியலில் இந்தப் பணியை ஒதுக்கவும்.',
    },
    'save': {
      AppLanguage.en: 'Save',
      AppLanguage.si: 'සුරකින්න',
      AppLanguage.ta: 'சேமி',
    },
    'attendance': {
      AppLanguage.en: 'Attendance',
      AppLanguage.si: 'පැමිණීම',
      AppLanguage.ta: 'வருகை',
    },
    'checkIn': {
      AppLanguage.en: 'Check In',
      AppLanguage.si: 'පැමිණීම සටහන් කරන්න',
      AppLanguage.ta: 'வருகையை பதிவு செய்',
    },
    'checkOut': {
      AppLanguage.en: 'Check Out',
      AppLanguage.si: 'පිටවීම සටහන් කරන්න',
      AppLanguage.ta: 'வெளியேறுதலை பதிவு செய்',
    },
    'requestLeave': {
      AppLanguage.en: 'Request Leave',
      AppLanguage.si: 'නිවාඩු ඉල්ලුම් කරන්න',
      AppLanguage.ta: 'விடுமுறை கோரு',
    },
    'leaveRequests': {
      AppLanguage.en: 'Leave Requests',
      AppLanguage.si: 'නිවාඩු ඉල්ලීම්',
      AppLanguage.ta: 'விடுமுறை கோரிக்கைகள்',
    },
    'attendanceHistory': {
      AppLanguage.en: 'Attendance History',
      AppLanguage.si: 'පැමිණීම් ඉතිහාසය',
      AppLanguage.ta: 'வருகை வரலாறு',
    },
    'leaveType': {
      AppLanguage.en: 'Leave Type',
      AppLanguage.si: 'නිවාඩු වර්ගය',
      AppLanguage.ta: 'விடுமுறை வகை',
    },
    'leave_paid': {
      AppLanguage.en: 'Paid',
      AppLanguage.si: 'ගෙවන',
      AppLanguage.ta: 'ஊதியத்துடன்',
    },
    'leave_unpaid': {
      AppLanguage.en: 'Unpaid',
      AppLanguage.si: 'නොගෙවන',
      AppLanguage.ta: 'ஊதியமில்லா',
    },
    'leave_sick': {
      AppLanguage.en: 'Sick',
      AppLanguage.si: 'අසනීප',
      AppLanguage.ta: 'மருத்துவ',
    },
    'startDate': {
      AppLanguage.en: 'Start Date',
      AppLanguage.si: 'ආරම්භක දිනය',
      AppLanguage.ta: 'ஆரம்ப தேதி',
    },
    'endDate': {
      AppLanguage.en: 'End Date',
      AppLanguage.si: 'අවසන් දිනය',
      AppLanguage.ta: 'முடிவு தேதி',
    },
    'reasonOptional': {
      AppLanguage.en: 'Reason (Optional)',
      AppLanguage.si: 'හේතුව (විකල්ප)',
      AppLanguage.ta: 'காரணம் (விருப்பத்தேர்வு)',
    },
    'submit': {
      AppLanguage.en: 'Submit',
      AppLanguage.si: 'යොමු කරන්න',
      AppLanguage.ta: 'சமர்ப்பி',
    },
    'cancel': {
      AppLanguage.en: 'Cancel',
      AppLanguage.si: 'අවලංගු කරන්න',
      AppLanguage.ta: 'ரத்து செய்',
    },
    'leave_status_pending': {
      AppLanguage.en: 'PENDING',
      AppLanguage.si: 'පොරොත්තු',
      AppLanguage.ta: 'நிலுவையில் உள்ளது',
    },
    'leave_status_approved': {
      AppLanguage.en: 'APPROVED',
      AppLanguage.si: 'අනුමතයි',
      AppLanguage.ta: 'அங்கீகரிக்கப்பட்டது',
    },
    'leave_status_rejected': {
      AppLanguage.en: 'REJECTED',
      AppLanguage.si: 'ප්‍රතික්ෂේපිතයි',
      AppLanguage.ta: 'நிராகரிக்கப்பட்டது',
    },
    'noLeaveRequests': {
      AppLanguage.en: 'No leave requests.',
      AppLanguage.si: 'නිවාඩු ඉල්ලීම් නැත.',
      AppLanguage.ta: 'விடுமுறை கோரிக்கைகள் இல்லை.',
    },
    'noAttendanceRecords': {
      AppLanguage.en: 'No attendance records.',
      AppLanguage.si: 'පැමිණීම් වාර්තා නැත.',
      AppLanguage.ta: 'வருகை பதிவுகள் இல்லை.',
    },
    'status': {
      AppLanguage.en: 'Status',
      AppLanguage.si: 'තත්ත්වය',
      AppLanguage.ta: 'நிலை',
    },
    'noReasonProvided': {
      AppLanguage.en: 'No reason provided',
      AppLanguage.si: 'හේතුවක් සපයා නැත',
      AppLanguage.ta: 'காரணம் வழங்கப்படவில்லை',
    },
    'halfDay': {
      AppLanguage.en: 'Half day',
      AppLanguage.si: 'අර්ධ දිනය',
      AppLanguage.ta: 'அரை நாள்',
    },
    'attendanceType': {
      AppLanguage.en: 'Attendance type',
      AppLanguage.si: 'පැමිණීමේ වර්ගය',
      AppLanguage.ta: 'வருகை வகை',
    },
    'dayType_full': {
      AppLanguage.en: 'Full day',
      AppLanguage.si: 'සම්පූර්ණ දිනය',
      AppLanguage.ta: 'முழு நாள்',
    },
    'dayType_half': {
      AppLanguage.en: 'Half day',
      AppLanguage.si: 'අර්ධ දිනය',
      AppLanguage.ta: 'அரை நாள்',
    },
    'overtimeHours': {
      AppLanguage.en: 'Overtime hours',
      AppLanguage.si: 'අතිකාල පැය',
      AppLanguage.ta: 'கூடுதல் நேரம் (மணி)',
    },
    'enterValidOvertime': {
      AppLanguage.en: 'Enter a number from 0 to 24.',
      AppLanguage.si: '0 සිට 24 දක්වා අගයක් ඇතුළත් කරන්න.',
      AppLanguage.ta: '0 முதல் 24 வரை உள்ள எண்ணை உள்ளிடவும்.',
    },
    'pay': {
      AppLanguage.en: 'Pay',
      AppLanguage.si: 'ගෙවීම්',
      AppLanguage.ta: 'ஊதியம்',
    },
    'salaryPayments': {
      AppLanguage.en: 'Salary payments',
      AppLanguage.si: 'වැටුප් ගෙවීම්',
      AppLanguage.ta: 'சம்பளப் பணம்',
    },
    'scheduledPayments': {
      AppLanguage.en: 'Payment schedule',
      AppLanguage.si: 'ගෙවීම් කාලසටහන',
      AppLanguage.ta: 'கட்டண அட்டவணை',
    },
    'paymentDueTomorrow': {
      AppLanguage.en: 'Reminder: a staff payment is due tomorrow.',
      AppLanguage.si: 'මතක් කිරීම: හෙට සේවක වැටුපක් ගෙවිය යුතුයි.',
      AppLanguage.ta: 'நினைவூட்டல்: நாளை பணியாளர் ஊதியம் வழங்க வேண்டும்.',
    },
    'paymentDate': {
      AppLanguage.en: 'Payment date',
      AppLanguage.si: 'ගෙවීම් දිනය',
      AppLanguage.ta: 'கட்டண தேதி',
    },
    'amount': {
      AppLanguage.en: 'Amount (LKR)',
      AppLanguage.si: 'මුදල (LKR)',
      AppLanguage.ta: 'தொகை (LKR)',
    },
    'noteOptional': {
      AppLanguage.en: 'Note (optional)',
      AppLanguage.si: 'සටහන (විකල්ප)',
      AppLanguage.ta: 'குறிப்பு (விருப்பம்)',
    },
    'addPaymentDate': {
      AppLanguage.en: 'Schedule salary payment',
      AppLanguage.si: 'වැටුප් ගෙවීම සැලසුම් කරන්න',
      AppLanguage.ta: 'சம்பளத் தேதியை திட்டமிடு',
    },
    'markPaid': {
      AppLanguage.en: 'Mark as paid',
      AppLanguage.si: 'ගෙවා ඇති බව සටහන් කරන්න',
      AppLanguage.ta: 'செலுத்தியதாகக் குறி',
    },
    'paymentStatus_scheduled': {
      AppLanguage.en: 'Scheduled',
      AppLanguage.si: 'සැලසුම් කර ඇත',
      AppLanguage.ta: 'திட்டமிடப்பட்டது',
    },
    'paymentStatus_paid': {
      AppLanguage.en: 'Paid',
      AppLanguage.si: 'ගෙවා ඇත',
      AppLanguage.ta: 'செலுத்தப்பட்டது',
    },
    'paymentMethod': {
      AppLanguage.en: 'Payment method',
      AppLanguage.si: 'ගෙවීමේ ක්‍රමය',
      AppLanguage.ta: 'கட்டண முறை',
    },
    'method_cash': {
      AppLanguage.en: 'Cash',
      AppLanguage.si: 'මුදල්',
      AppLanguage.ta: 'பணம்',
    },
    'method_bank': {
      AppLanguage.en: 'Bank transfer',
      AppLanguage.si: 'බැංකු මාරු කිරීම',
      AppLanguage.ta: 'வங்கி பரிமாற்றம்',
    },
    'method_mobile_wallet': {
      AppLanguage.en: 'Mobile wallet',
      AppLanguage.si: 'ජංගම මුදල් පසුම්බිය',
      AppLanguage.ta: 'மொபைல் பணப்பை',
    },
    'advanceRequests': {
      AppLanguage.en: 'Salary advance requests',
      AppLanguage.si: 'වැටුප් අත්තිකාරම් ඉල්ලීම්',
      AppLanguage.ta: 'சம்பள முன்பணக் கோரிக்கைகள்',
    },
    'confirmApproveAdvance': {
      AppLanguage.en:
          'Approve the advance of {amount}? It will be recorded as issued.',
      AppLanguage.si:
          '{amount} අත්තිකාරම අනුමත කරන්නද? එය ලබා දුන් ලෙස සටහන් වේ.',
      AppLanguage.ta:
          '{amount} முன்பணத்தை அங்கீகரிக்கவா? வழங்கியதாக பதிவு செய்யப்படும்.',
    },
    'confirmRejectAdvance': {
      AppLanguage.en: 'Reject the advance request for {amount}?',
      AppLanguage.si: '{amount} අත්තිකාරම් ඉල්ලීම ප්‍රතික්ෂේප කරන්නද?',
      AppLanguage.ta: '{amount} முன்பணக் கோரிக்கையை நிராகரிக்கவா?',
    },
    'requestAdvance': {
      AppLanguage.en: 'Request an advance',
      AppLanguage.si: 'අත්තිකාරමක් ඉල්ලන්න',
      AppLanguage.ta: 'முன்பணம் கோரு',
    },
    'advanceStatus_pending': {
      AppLanguage.en: 'Pending',
      AppLanguage.si: 'පොරොත්තුවෙන්',
      AppLanguage.ta: 'நிலுவையில்',
    },
    'advanceStatus_approved': {
      AppLanguage.en: 'Approved',
      AppLanguage.si: 'අනුමතයි',
      AppLanguage.ta: 'அங்கீகரிக்கப்பட்டது',
    },
    'advanceStatus_rejected': {
      AppLanguage.en: 'Rejected',
      AppLanguage.si: 'ප්‍රතික්ෂේපිතයි',
      AppLanguage.ta: 'நிராகரிக்கப்பட்டது',
    },
    'noPayments': {
      AppLanguage.en: 'No salary payments scheduled yet.',
      AppLanguage.si: 'තවම වැටුප් ගෙවීම් සැලසුම් කර නැත.',
      AppLanguage.ta: 'இன்னும் சம்பளப் பணம் திட்டமிடப்படவில்லை.',
    },
    'noAdvanceRequests': {
      AppLanguage.en: 'No advance requests.',
      AppLanguage.si: 'අත්තිකාරම් ඉල්ලීම් නැත.',
      AppLanguage.ta: 'முன்பணக் கோரிக்கைகள் இல்லை.',
    },
    'selectStaff': {
      AppLanguage.en: 'Select staff member',
      AppLanguage.si: 'සේවකයෙකු තෝරන්න',
      AppLanguage.ta: 'பணியாளரைத் தேர்ந்தெடுக்கவும்',
    },
    'approve': {
      AppLanguage.en: 'Approve',
      AppLanguage.si: 'අනුමත කරන්න',
      AppLanguage.ta: 'அங்கீகரி',
    },
    'reject': {
      AppLanguage.en: 'Reject',
      AppLanguage.si: 'ප්‍රතික්ෂේප කරන්න',
      AppLanguage.ta: 'நிராகரி',
    },
  };

  static String of(String key, AppLanguage lang) {
    return _values[key]?[lang] ?? _values[key]?[AppLanguage.en] ?? key;
  }
}
