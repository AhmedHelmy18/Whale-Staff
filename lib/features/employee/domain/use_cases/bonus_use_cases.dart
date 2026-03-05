import 'package:whale_staff/features/employee/domain/entities/bonus.dart';
import 'package:whale_staff/features/employee/domain/repositories/bonus_repository.dart';

class AddBonus {
  final BonusRepository repository;
  AddBonus(this.repository);

  Future<void> call(Bonus bonus) async {
    await repository.addBonus(bonus);
  }
}

class GetEmployeeBonuses {
  final BonusRepository repository;
  GetEmployeeBonuses(this.repository);

  Future<List<Bonus>> call(String employeeId) async {
    return await repository.getEmployeeBonuses(employeeId);
  }
}

class GetAllBonuses {
  final BonusRepository repository;
  GetAllBonuses(this.repository);

  Future<List<Bonus>> call() async {
    return await repository.getAllBonuses();
  }
}

class DeleteBonus {
  final BonusRepository repository;
  DeleteBonus(this.repository);

  Future<void> call(String id) async {
    await repository.deleteBonus(id);
  }
}
