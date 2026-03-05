import 'package:whale_staff/features/employee/domain/entities/deduction.dart';

abstract class DeductionRepository {
  Future<List<Deduction>> getEmployeeDeductions(String employeeId);
  Future<void> addDeduction(Deduction deduction);
  Future<void> deleteDeduction(String id);
}
