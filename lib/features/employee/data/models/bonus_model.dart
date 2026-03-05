// ignore_for_file: overridden_fields
import 'package:hive/hive.dart';
import 'package:whale_staff/features/employee/domain/entities/bonus.dart';

part 'bonus_model.g.dart';

@HiveType(typeId: 3)
class BonusModel extends Bonus {
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

  const BonusModel({
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

  factory BonusModel.fromEntity(Bonus bonus) {
    return BonusModel(
      id: bonus.id,
      employeeId: bonus.employeeId,
      amount: bonus.amount,
      reason: bonus.reason,
      date: bonus.date,
    );
  }
}
