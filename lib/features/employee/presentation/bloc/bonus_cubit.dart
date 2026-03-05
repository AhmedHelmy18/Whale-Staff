import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whale_staff/features/employee/domain/entities/bonus.dart';
import 'package:whale_staff/features/employee/domain/use_cases/bonus_use_cases.dart';
import 'package:whale_staff/features/employee/presentation/bloc/bonus_state.dart';

class BonusCubit extends Cubit<BonusState> {
  final AddBonus addBonusUseCase;
  final GetEmployeeBonuses getEmployeeBonusesUseCase;
  final GetAllBonuses getAllBonusesUseCase;
  final DeleteBonus deleteBonusUseCase;

  List<Bonus> _allBonuses = [];

  BonusCubit({
    required this.addBonusUseCase,
    required this.getEmployeeBonusesUseCase,
    required this.getAllBonusesUseCase,
    required this.deleteBonusUseCase,
  }) : super(BonusInitial());

  Future<void> loadAllBonuses() async {
    emit(BonusLoading());
    try {
      _allBonuses = await getAllBonusesUseCase();
      emit(BonusLoaded(_allBonuses, allBonuses: _allBonuses));
    } catch (e) {
      emit(BonusError(e.toString()));
    }
  }

  void searchBonuses(String query, Map<String, String> employeeNames) {
    if (state is BonusLoaded) {
      if (query.isEmpty) {
        emit(BonusLoaded(_allBonuses, allBonuses: _allBonuses));
      } else {
        final filtered = _allBonuses.where((bonus) {
          final searchLower = query.toLowerCase();
          final employeeName = (employeeNames[bonus.employeeId] ?? '')
              .toLowerCase();
          return bonus.reason.toLowerCase().contains(searchLower) ||
              employeeName.contains(searchLower) ||
              bonus.amount.toString().contains(searchLower);
        }).toList();
        emit(
          BonusLoaded(filtered, allBonuses: _allBonuses, searchQuery: query),
        );
      }
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
