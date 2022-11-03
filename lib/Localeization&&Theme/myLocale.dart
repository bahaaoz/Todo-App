import 'package:get/get.dart';

class MyLocal implements Translations {
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
        "en": {
          "Email": "Email",
          "Password": "Password",
          "SignUp": "SignUp",
          "SignIn": "SignIn",
          "LOGIN": "LOGIN",
          "LOGOUT": "LOGOUT",
          "Back": "Back",
          "Confirmation Password": "Confirmation Password",
          "The password is not the same": "The password is not the same",
          "Todo App": "Todo App",
          "Search": "Search",
          "Change Languge": "Change Languge",
          "Language has changed": "Language has changed"
        },
        "ar": {
          "Email": "الأيميل",
          "Password": "كلمة السر",
          "SignUp": "انشاء حساب",
          "SignIn": "تسجيل الدخول",
          "LOGIN": "دخول",
          "LOGOUT": "تسجيل الخروج",
          "Back": "رجوع",
          "Confirmation Password": "اعادة كتابة كلمة السر",
          "The password is not the same": "كلمتا السر غير متشابهتين",
          "Todo App": "تطبيق المهام",
          "search": "البحث",
          "Change Languge": "تغيير اللغة",
          "Language has changed": "تم تغييراللغة"
        }
      };
}
