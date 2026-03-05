import 'package:equatable/equatable.dart';

class Bonus extends Equatable {
  final String id;
  final String employeeId;
  final double amount;
  final String reason;
  final DateTime date;

  const Bonus({
    required this.id,
    required this.employeeId,
    required this.amount,
    required this.reason,
    required this.date,
  });

  @override
  List<Object?> get props => [id, employeeId, amount, reason, date];
}
