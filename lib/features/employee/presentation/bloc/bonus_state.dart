import 'package:equatable/equatable.dart';
import 'package:whale_staff/features/employee/domain/entities/bonus.dart';

abstract class BonusState extends Equatable {
  const BonusState();
  @override
  List<Object?> get props => [];
}

class BonusInitial extends BonusState {}

class BonusLoading extends BonusState {}

class BonusLoaded extends BonusState {
  final List<Bonus> bonuses;
  const BonusLoaded(this.bonuses);
  @override
  List<Object?> get props => [bonuses];
}

class BonusError extends BonusState {
  final String message;
  const BonusError(this.message);
  @override
  List<Object?> get props => [message];
}
