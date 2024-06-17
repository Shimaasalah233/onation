import 'package:ONATION/loginandregisteration/main2.dart';
import 'package:flutter/material.dart';

class Language extends ChangeNotifier {
  String _lang = language;
  getLanguage() {
    return _lang;
  }

  setLanguage(String lang) {
    _lang = lang;
    notifyListeners();
  }

  String tSetting() {
    if (getLanguage() == 'AR') {
      return "الإعدادات و الخصوصية";
    } else {
      return "Settings & Privacy";
    }
  }

  String tFavorite() {
    if (getLanguage() == 'AR') {
      return "المفضلة";
    } else {
      return "Favorite";
    }
  }

  String tDarkm() {
    if (getLanguage() == 'AR') {
      return "المظهر";
    } else {
      return "Theme";
    }
  }

  String tLanguage() {
    if (getLanguage() == 'AR') {
      return "اللغة";
    } else {
      return "Language";
    }
  }

  String teditprof() {
    if (getLanguage() == 'AR') {
      return "تعديل الملف الشخصي";
    } else {
      return "Edit Profile";
    }
  }

  String tinfo() {
    if (getLanguage() == 'AR') {
      return "معلوماتي";
    } else {
      return "My Information";
    }
  }

  String tchanges() {
    if (getLanguage() == 'AR') {
      return "حفظ التغييرات";
    } else {
      return "Save Changes";
    }
  }

  String tuser() {
    if (getLanguage() == 'AR') {
      return "اسم المستخدم";
    } else {
      return "Username";
    }
  }

  String temail() {
    if (getLanguage() == 'AR') {
      return "البريد الألكتروني";
    } else {
      return "E-mail";
    }
  }

  String tphone() {
    if (getLanguage() == 'AR') {
      return "رقم الهاتف";
    } else {
      return "Phone Number";
    }
  }

  String tlogout() {
    if (getLanguage() == 'AR') {
      return "تسجيل الخروج";
    } else {
      return "Logout";
    }
  }

  String tdelete() {
    if (getLanguage() == 'AR') {
      return "حذف الحساب";
    } else {
      return "Delete Account";
    }
  }

  String twelcome() {
    if (getLanguage() == 'AR') {
      return "مرحبًا";
    } else {
      return "Welcome";
    }
  }

  String tprofile() {
    if (getLanguage() == 'AR') {
      return "الملف الشخصي";
    } else {
      return "Profile";
    }
  }

  String thome() {
    if (getLanguage() == 'AR') {
      return "الصفحة الرئيسية";
    } else {
      return "Home";
    }
  }

  String tsearch() {
    if (getLanguage() == 'AR') {
      return "بحث";
    } else {
      return "search";
    }
  }

  String tcountry() {
    if (getLanguage() == 'AR') {
      return "فلسطين";
    } else {
      return "Palestine";
    }
  }

  String tall() {
    if (getLanguage() == 'AR') {
      return "الكل";
    } else {
      return "All";
    }
  }

  String tarab() {
    if (getLanguage() == 'AR') {
      return "عربية";
    } else {
      return "Arabian";
    }
  }

  String tasia() {
    if (getLanguage() == 'AR') {
      return "آسيوية";
    } else {
      return "Asian";
    }
  }

  String teurope() {
    if (getLanguage() == 'AR') {
      return "أوروبية";
    } else {
      return "European";
    }
  }

  String tamerica() {
    if (getLanguage() == 'AR') {
      return "أمريكية";
    } else {
      return "American";
    }
  }

  String tpurpose() {
    if (getLanguage() == 'AR') {
      return "غرض السفر";
    } else {
      return "Travel Purpose";
    }
  }

  String tedu() {
    if (getLanguage() == 'AR') {
      return "التعليم";
    } else {
      return "Education";
    }
  }

  String twork() {
    if (getLanguage() == 'AR') {
      return "العمل";
    } else {
      return "Work";
    }
  }

  String tTour() {
    if (getLanguage() == 'AR') {
      return "السياحة";
    } else {
      return "Tourism";
    }
  }

  String tmore() {
    if (getLanguage() == 'AR') {
      return "استكشف المزيد";
    } else {
      return "See More";
    }
  }

  String tcity() {
    if (getLanguage() == 'AR') {
      return "المدن الأشهر";
    } else {
      return "Famous Cities";
    }
  }

  String ttourist() {
    if (getLanguage() == 'AR') {
      return "المعالم الأشهر";
    } else {
      return "Famous Landmarks";
    }
  }

  String ttokyo() {
    if (getLanguage() == 'AR') {
      return "طوكيو";
    } else {
      return "Tokyo";
    }
  }

  String ttokyotower() {
    if (getLanguage() == 'AR') {
      return "برج طوكيو";
    } else {
      return "Tokyo Tower";
    }
  }

  String tdet() {
    if (getLanguage() == 'AR') {
      return "بعض التفاصيل";
    } else {
      return "some details";
    }
  }

  String tpaper() {
    if (getLanguage() == 'AR') {
      return "الأوراق الأساسية";
    } else {
      return "Basic papers";
    }
  }

  String taboutcountry() {
    if (getLanguage() == 'AR') {
      return "خاص بالدولة";
    } else {
      return "Related to country";
    }
  }

  String tnotes() {
    if (getLanguage() == 'AR') {
      return "ملاحظات";
    } else {
      return "Notes";
    }
  }

  String tembises() {
    if (getLanguage() == 'AR') {
      return "السفارات";
    } else {
      return "Embassies";
    }
  }

  String tFavCities() {
    if (getLanguage() == 'AR') {
      return "الدول المفضلة  ";
    } else {
      return "Favorite Countries ";
    }
  }

  String taddcomment() {
    if (getLanguage() == 'AR') {
      return "إضافة تعليق";
    } else {
      return "Add Comment";
    }
  }

  String tcomment() {
    if (getLanguage() == 'AR') {
      return "التعليق";
    } else {
      return "Comment";
    }
  }

  String tadd() {
    if (getLanguage() == 'AR') {
      return "إضافة";
    } else {
      return "Add";
    }
  }

  String tcancel() {
    if (getLanguage() == 'AR') {
      return "إلغاء";
    } else {
      return "Cancel";
    }
  }

  String tabout() {
    if (getLanguage() == 'AR') {
      return "عن فريقنا";
    } else {
      return "About Us";
    }
  }

  String taboutproject() {
    if (getLanguage() == 'AR') {
      return "عن تطبيقنا";
    } else {
      return "About App";
    }
  }

  String taboutus() {
    if (getLanguage() == 'AR') {
      return "عن فريقنا";
    } else {
      return "About Us";
    }
  }

  String tteam() {
    if (getLanguage() == 'AR') {
      return ":أعضاء فريقنا";
    } else {
      return "Team Members: ";
    }
  }

  String tchangepass() {
    if (getLanguage() == 'AR') {
      return "تغيير كلمة السر";
    } else {
      return "Change Password";
    }
  }

  String tsuggadd() {
    if (getLanguage() == 'AR') {
      return "إضافة اقتراح";
    } else {
      return "Add a suggestion";
    }
  }

  String ttitlsugg() {
    if (getLanguage() == 'AR') {
      return "عنوان الاقتراح";
    } else {
      return "Suggestion Title";
    }
  }

  String tdessugg() {
    if (getLanguage() == 'AR') {
      return "وصف الاقتراح";
    } else {
      return "Suggestion Description";
    }
  }

  String empssugg() {
    if (getLanguage() == 'AR') {
      return "من فضلك ادخل الاقتراح";
    } else {
      return "Please Enter The Suggestion";
    }
  }

  String warning() {
    if (getLanguage() == 'AR') {
      return "تحذير ";
    } else {
      return "Warning";
    }
  }

  String sure() {
    if (getLanguage() == 'AR') {
      return "هل انت متأكد من حذف حسابك؟";
    } else {
      return "Are you sure you want to delete your account?";
    }
  }

  String yes() {
    if (getLanguage() == 'AR') {
      return "نعم";
    } else {
      return "Yes";
    }
  }

  String no() {
    if (getLanguage() == 'AR') {
      return "لا";
    } else {
      return "No";
    }
  }
}
