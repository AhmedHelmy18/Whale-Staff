import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whale_staff/features/employee/domain/entities/bonus.dart';
import 'package:whale_staff/features/employee/domain/use_cases/bonus_use_cases.dart';
import 'package:whale_staff/features/employee/presentation/bloc/bonus_state.dart';

class BonusCubit extends Cubit<BonusState> {
  final AddBonus addBonusUseCase;
  final GetEmployeeBonuses getEmployeeBonusesUseCase;
  final GetAllBonuses getAllBonusesUseCase;
  final DeleteBonus deleteBonusUseCase;

  BonusCubit({
    required this.addBonusUseCase,
    required this.getEmployeeBonusesUseCase,
    required this.getAllBonusesUseCase,
    required this.deleteBonusUseCase,
  }) : super(BonusInitial());

  Future<void> loadAllBonuses() async {
    emit(BonusLoading());
    try {
      final bonuses = await getAllBonusesUseCase();
      emit(BonusLoaded(bonuses));
    } catch (e) {
      emit(BonusError(e.toString()));
    }
  }

  Future<void> addBonus(Bonus bonus) async {
    try {
      await addBonusUseCase(bonus);
      await loadAllBonuses();
    } catch (e) {
      emit(BonusError(e.toString()));
    }
  }

  Future<void> removeBonus(String id) async {
    try {
      await deleteBonusUseCase(id);
      await loadAllBonuses();
    } catch (e) {
      emit(BonusError(e.toString()));
    }
  }
}
