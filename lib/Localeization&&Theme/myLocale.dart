import 'package:get/get.dart';

class MyLocal implements Translations {
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
        "en": {
          "Todo App": "Todo App",
          "Search": "Search",
          "Change Languge": "Change Languge",
          "Language has changed": "Language has changed"
        },
        "ar": {
          "Todo App": "تطبيق المهام",
          "search": "البحث",
          "Change Languge": "تغيير اللغة",
          "Language has changed": "تم تغييراللغة"
        }
      };
}
