import 'package:supabase_flutter/supabase_flutter.dart';

import '../main.dart';

class SupabaseAuth {
  Future<String> signUp(String email, String password) async {
    final signUpResponse =
        await Supabase.instance.client.auth.signUp(email, password);

    if (signUpResponse.error == null) {
      return "Account created";
    } else {
      return signUpResponse.error!.message;
    }
  }
  //######################################################################3

  Future<bool> signIn(String email, String password) async {
    final respons = await Supabase.instance.client.auth
        .signIn(email: email, password: password);

    if (respons.error == null) {
      sharedPreferences!.setString("user", respons.data!.user!.id);
      return true;
    } else {
      return false;
    }
  }

  void signOut() {
    sharedPreferences!.remove("user");
  }

  bool anyUseSign() {
    if (sharedPreferences!.getString('user') == null) {
      return false;
    }
    return true;
  }

  void withoutSign() {
    List<String> str = [];
    sharedPreferences!.setStringList("key", str);
  }
}
