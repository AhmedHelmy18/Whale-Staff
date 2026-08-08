import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whale_staff/features/employee/domain/repositories/employee_repository.dart';
import 'package:whale_staff/features/employee/domain/repositories/bonus_repository.dart';
import 'package:whale_staff/features/employee/domain/repositories/deduction_repository.dart';
import 'package:whale_staff/features/leave/domain/repositories/leave_repository.dart';
import 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final EmployeeRepository employeeRepository;
  final LeaveRepository leaveRepository;
  final BonusRepository bonusRepository;
  final DeductionRepository deductionRepository;

  DashboardCubit({
    required this.employeeRepository,
    required this.leaveRepository,
    required this.bonusRepository,
    required this.deductionRepository,
  }) : super(DashboardInitial());

  Future<void> loadDashboardData() async {
    emit(DashboardLoading());
    try {
      final employees = await employeeRepository.getEmployees();
      final allLeaves = await leaveRepository.getAllLeaves();
      final allBonuses = await bonusRepository.getEmployeeBonuses('');
      final allDeductions = await deductionRepository.getEmployeeDeductions('');

      final totalEmployees = employees.length;

      final today = DateTime.now();
      final activeLeavesToday = allLeaves.where((leave) {
        return (leave.startDate.isBefore(today) ||
                leave.startDate.isAtSameMomentAs(today)) &&
            (leave.endDate.isAfter(today) ||
                leave.endDate.isAtSameMomentAs(today));
      }).length;

      double totalBaseSalary = 0;
      for (var emp in employees) {
        totalBaseSalary += emp.baseSalary;
      }

      double totalBonuses = 0;
      for (var bonus in allBonuses) {
        if (bonus.date.month == today.month && bonus.date.year == today.year) {
          totalBonuses += bonus.amount;
        }
      }

      double totalDeductions = 0;
      for (var deduction in allDeductions) {
        if (deduction.date.month == today.month &&
            deduction.date.year == today.year) {
          totalDeductions += deduction.amount;
        }
      }

      final totalMonthlyPayroll =
          totalBaseSalary + totalBonuses - totalDeductions;

      final normalizedToday = DateTime(today.year, today.month, today.day);
      final upcomingBirthdays = employees.where((emp) {
        if (emp.birthday == null) return false;

        final bDay = emp.birthday!;
        var nextBDay = DateTime(today.year, bDay.month, bDay.day);

        if (nextBDay.isBefore(normalizedToday)) {
          nextBDay = DateTime(today.year + 1, bDay.month, bDay.day);
        }

        final diff = nextBDay.difference(normalizedToday).inDays;
        return diff >= 0 && diff <= 30;
      }).toList();

      final Map<String, double> salaryByPosition = {};
      for (var emp in employees) {
        salaryByPosition[emp.position] =
            (salaryByPosition[emp.position] ?? 0) + emp.baseSalary;
      }

      for (var bonus in allBonuses) {
        if (bonus.date.month == today.month && bonus.date.year == today.year) {
          final targetEmp = employees
              .where((e) => e.id == bonus.employeeId)
              .toList();
          if (targetEmp.isNotEmpty) {
            salaryByPosition[targetEmp.first.position] =
                (salaryByPosition[targetEmp.first.position] ?? 0) +
                bonus.amount;
          }
        }
      }

      emit(
        DashboardLoaded(
          totalEmployees: totalEmployees,
          activeLeavesToday: activeLeavesToday,
          totalMonthlyPayroll: totalMonthlyPayroll,
          upcomingBirthdays: upcomingBirthdays,
          recentLeaves: allLeaves.take(5).toList(),
          salaryByPosition: salaryByPosition,
        ),
      );
    } catch (e) {
      emit(DashboardError(e.toString()));
    }
  }
}
