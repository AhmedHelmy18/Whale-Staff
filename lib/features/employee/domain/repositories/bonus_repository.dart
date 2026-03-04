import 'package:whale_staff/features/employee/domain/entities/bonus.dart';

abstract class BonusRepository {
  Future<void> addBonus(Bonus bonus);
  Future<List<Bonus>> getEmployeeBonuses(String employeeId);
  Future<List<Bonus>> getAllBonuses();
  Future<void> deleteBonus(String id);
}
