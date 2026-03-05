import 'package:hive/hive.dart';
import 'package:whale_staff/features/employee/data/models/deduction_model.dart';
import 'package:whale_staff/features/employee/domain/entities/deduction.dart';
import 'package:whale_staff/features/employee/domain/repositories/deduction_repository.dart';

class DeductionRepositoryImpl implements DeductionRepository {
  final Box<DeductionModel> deductionBox;

  DeductionRepositoryImpl(this.deductionBox);

  @override
  Future<void> addDeduction(Deduction deduction) async {
    await deductionBox.put(deduction.id, DeductionModel.fromEntity(deduction));
  }

  @override
  Future<void> deleteDeduction(String id) async {
    await deductionBox.delete(id);
  }

  @override
  Future<List<Deduction>> getEmployeeDeductions(String employeeId) async {
    final deductions = deductionBox.values.toList();
    if (employeeId.isEmpty) return deductions;
    return deductions.where((d) => d.employeeId == employeeId).toList();
  }
}
