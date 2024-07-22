import 'dart:convert';
import 'package:ruabbit_flutter/app/WaterFree/model/water_dispenser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../app/WaterFree/model/water_free_profile.dart';
import '../model/user_profile.dart';

// UserProfile
Future<UserProfile> getUserProfileFromPrefs() async {
  final prefs = await SharedPreferences.getInstance();
  final String? userProfileJsonString = prefs.getString('userProfile');
  if (userProfileJsonString != null) {
    final userProfileJson = jsonDecode(userProfileJsonString);
    return UserProfile.fromJson(userProfileJson);
  } else {
    return UserProfile(cookies: [], isLogin: false);
  }
}

Future<void> saveUserProfileToPrefs(UserProfile userProfile) async {
  final prefs = await SharedPreferences.getInstance();
  final userProfileJsonString = jsonEncode(userProfile.toJson());
  await prefs.setString('userProfile', userProfileJsonString);
}

Future<void> editUserProfileInPrefs(Map<String, dynamic> updates) async {
  UserProfile userProfile = await getUserProfileFromPrefs();
  updates.forEach((key, value) {
    if (key == 'cookies') {
      userProfile.cookies = value;
    } else if (key == 'isLogin') {
      userProfile.isLogin = value;
    }
  });
  await saveUserProfileToPrefs(userProfile);
}

// WaterFreeProfile
Future<WaterFreeProfile> getWaterFreeProfileFromPrefs() async {
  final prefs = await SharedPreferences.getInstance();
  final String? waterFreeProfileJsonString =
      prefs.getString('waterFreeProfile');
  if (waterFreeProfileJsonString != null) {
    final waterFreeProfileJson = jsonDecode(waterFreeProfileJsonString);
    return WaterFreeProfile.fromJson(waterFreeProfileJson);
  } else {
    return WaterFreeProfile(cardId: '', waterDispenserList: []);
  }
}

Future<void> saveWaterFreeProfileToPrefs(
    WaterFreeProfile waterFreeProfile) async {
  final prefs = await SharedPreferences.getInstance();
  final waterFreeProfileJsonString = jsonEncode(waterFreeProfile.toJson());
  await prefs.setString('waterFreeProfile', waterFreeProfileJsonString);
}

Future<void> editWaterFreeProfileInPrefs(Map<String, dynamic> updates) async {
  WaterFreeProfile waterFreeProfile = await getWaterFreeProfileFromPrefs();
  updates.forEach((key, value) {
    if (key == 'cardId') {
      waterFreeProfile.cardId = value;
    } else if (key == 'waterDispenserList') {
      waterFreeProfile.waterDispenserList = List<WaterDispenser>.from(value);
    }
  });
  await saveWaterFreeProfileToPrefs(waterFreeProfile);
}
