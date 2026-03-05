import 'package:equatable/equatable.dart';

class Deduction extends Equatable {
  final String id;
  final String employeeId;
  final double amount;
  final String reason;
  final DateTime date;

  const Deduction({
    required this.id,
    required this.employeeId,
    required this.amount,
    required this.reason,
    required this.date,
  });

  @override
  List<Object?> get props => [id, employeeId, amount, reason, date];
}
