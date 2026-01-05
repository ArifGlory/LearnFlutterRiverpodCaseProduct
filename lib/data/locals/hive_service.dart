import 'package:hive/hive.dart';

class HiveService {
  static const boxName = "favorites";
  static const tokenBox = "session";

  Future<Box> openBox() async => await Hive.openBox(boxName);

  Future<void> toggleFavorite(int productId) async {
    final box = await openBox();
    final current = box.get(productId, defaultValue: false);
    await box.put(productId, !current);
  }

  Future<bool> isFavorite(int productId) async {
    final box = await openBox();
    return box.get(productId, defaultValue: false);
  }

  Future<void> saveToken(String token) async {
    final box = await Hive.openBox(tokenBox);
    await box.put("token", token);
  }

  Future<String?> getToken() async {
    final box = await Hive.openBox(tokenBox);
    return box.get("token");
  }

  Future<void> clearSession() async {
    final box = await Hive.openBox(tokenBox);
    await box.clear();
  }
}
