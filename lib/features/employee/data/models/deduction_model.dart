import 'package:hive/hive.dart';
import 'package:whale_staff/features/employee/domain/entities/deduction.dart';

part 'deduction_model.g.dart';

@HiveType(typeId: 4)
class DeductionModel extends Deduction {
  @override
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  final String employeeId;
  @override
  @HiveField(2)
  final double amount;
  @override
  @HiveField(3)
  final String reason;
  @override
  @HiveField(4)
  final DateTime date;

  const DeductionModel({
    required this.id,
    required this.employeeId,
    required this.amount,
    required this.reason,
    required this.date,
  }) : super(
         id: id,
         employeeId: employeeId,
         amount: amount,
         reason: reason,
         date: date,
       );

  factory DeductionModel.fromEntity(Deduction deduction) {
    return DeductionModel(
      id: deduction.id,
      employeeId: deduction.employeeId,
      amount: deduction.amount,
      reason: deduction.reason,
      date: deduction.date,
    );
  }
}
