

import 'package:get/get.dart';

class ThemeController extends GetxController {
  static const THEME_STATUS = "THEME_STATUS";
  RxBool _darkTheme = false.obs;

  bool get getIsDarkTheme => _darkTheme.value;

  @override
  void onInit() {
    super.onInit();
    getTheme();
  }

  void setDarkTheme({required bool themeValue}) async {
    _darkTheme.value = themeValue;
    // Enregistrez ici l'état du thème dans SharedPreferences ou Firebase, si nécessaire.
    await saveTheme(themeValue);
  }

  Future<void> getTheme() async {
    final bool isDarkTheme = await fetchTheme();
    _darkTheme.value = isDarkTheme;
  }

  Future<void> saveTheme(bool themeValue) async {
    // Enregistrez l'état du thème dans SharedPreferences ou Firebase, selon vos besoins.
    // Par exemple, vous pouvez utiliser SharedPreferences comme suit :
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // await prefs.setBool(THEME_STATUS, themeValue);
  }

  Future<bool> fetchTheme() async {
    // Récupérez l'état du thème depuis SharedPreferences ou Firebase, selon vos besoins.
    // Par exemple, avec SharedPreferences :
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // return prefs.getBool(THEME_STATUS) ?? false;
    return false; // Remplacez cette ligne par votre logique de récupération du thème.
  }
}