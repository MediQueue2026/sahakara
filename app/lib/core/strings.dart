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
      AppLanguage.si: 'මම සහායිකාවක්',
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
      AppLanguage.si: 'මෙම ගිණුම නිවස් හිමිකරුවෙකු ලෙස ලියාපදිංචි කර ඇත. මෙතැනින් පිවිසෙන්න.',
      AppLanguage.ta: 'இந்தக் கணக்கு வீட்டு உரிமையாளராகப் பதிவு செய்யப்பட்டுள்ளது. இங்கே உள்நுழையவும்.',
    },
    'registeredAsMaid': {
      AppLanguage.en:
          'This account is registered as a maid. Sign in here instead.',
      AppLanguage.si:
          'මෙම ගිණුම සහායිකාවක් ලෙස ලියාපදිංචි කර ඇත. මෙතැනින් පිවිසෙන්න.',
      AppLanguage.ta: 'இந்தக் கணக்கு வீட்டுப் பணியாளராகப் பதிவு செய்யப்பட்டுள்ளது. இங்கே உள்நுழையவும்.',
    },
    'adminUseWebPanel': {
      AppLanguage.en:
          'This is an admin account. Please use the Sahakara web admin panel.',
      AppLanguage.si: 'මෙය පරිපාලක ගිණුමකි. කරුණාකර සහකාර වෙබ් පරිපාලන පුවරුව භාවිතා කරන්න.',
      AppLanguage.ta: 'இது ஒரு நிர்வாகி கணக்கு. சஹகார இணைய நிர்வாகப் பலகத்தைப் பயன்படுத்தவும்.',
    },
    'waitingForHousehold': {
      AppLanguage.en: 'Waiting to join a household',
      AppLanguage.si: 'නිවසකට එක්වීමට රැඳී සිටී',
      AppLanguage.ta: 'ஒரு வீட்டில் சேரக் காத்திருக்கிறது',
    },
    'waitingForHouseholdBody': {
      AppLanguage.en:
          'Ask the house owner to add you in Sahakara using this email:',
      AppLanguage.si: 'මෙම ඊමේල් ලිපිනය භාවිතයෙන් ඔබව සහකාර වෙත එක් කරන ලෙස නිවස් හිමිකරුගෙන් ඉල්ලන්න:',
      AppLanguage.ta: 'இந்த மின்னஞ்சலைப் பயன்படுத்தி உங்களை சஹகாரவில் சேர்க்க வீட்டு உரிமையாளரிடம் கேளுங்கள்:',
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
      AppLanguage.ta: 'இன்னும் இயல்புநிலை பணிகள் இல்லை. தட்டச்சு செய்ய கீழே "மற்றவை" அழுத்தவும்.',
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
      AppLanguage.en: 'No staff yet. Add them from the Household tab, then assign this task from the Daily tasks list.',
      AppLanguage.si: 'තවම සේවකයින් නැත. නිවස ටැබයෙන් ඔවුන් එක් කර, පසුව දෛනික කාර්ය ලැයිස්තුවෙන් මෙම කාර්යය පවරන්න.',
      AppLanguage.ta: 'இன்னும் பணியாளர்கள் இல்லை. வீடு தாவலில் அவர்களைச் சேர்த்து, பின்னர் தினசரி பணிகள் பட்டியலில் இந்தப் பணியை ஒதுக்கவும்.',
    },
    'save': {
      AppLanguage.en: 'Save',
      AppLanguage.si: 'සුරකින්න',
      AppLanguage.ta: 'சேமி',
    },
  };

  static String of(String key, AppLanguage lang) {
    return _values[key]?[lang] ?? _values[key]?[AppLanguage.en] ?? key;
  }
}
