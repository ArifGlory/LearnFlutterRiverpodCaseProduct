import 'package:hive/hive.dart';

class HiveService {
  static const boxName = "favorites";

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
}
