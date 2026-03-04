import 'package:hive/hive.dart';
import 'package:whale_staff/features/employee/data/models/bonus_model.dart';
import 'package:whale_staff/features/employee/domain/entities/bonus.dart';
import 'package:whale_staff/features/employee/domain/repositories/bonus_repository.dart';

class BonusRepositoryImpl implements BonusRepository {
  static const String boxName = 'bonuses';

  @override
  Future<void> addBonus(Bonus bonus) async {
    final box = await Hive.openBox<BonusModel>(boxName);
    await box.put(bonus.id, BonusModel.fromEntity(bonus));
  }

  @override
  Future<List<Bonus>> getEmployeeBonuses(String employeeId) async {
    final box = await Hive.openBox<BonusModel>(boxName);
    return box.values.where((b) => b.employeeId == employeeId).toList();
  }

  @override
  Future<List<Bonus>> getAllBonuses() async {
    final box = await Hive.openBox<BonusModel>(boxName);
    return box.values.toList();
  }

  @override
  Future<void> deleteBonus(String id) async {
    final box = await Hive.openBox<BonusModel>(boxName);
    await box.delete(id);
  }
}
