import 'dart:async' as _i19;

import 'package:flutter/material.dart' as _i18;
import 'package:flutter_bloc/flutter_bloc.dart' as _i20;
import 'package:mockito/mockito.dart' as _i1;
import 'package:whale_staff/core/theme/theme_cubit.dart' as _i17;
import 'package:whale_staff/features/dashboard/presentation/bloc/dashboard_cubit.dart'
    as _i21;
import 'package:whale_staff/features/dashboard/presentation/bloc/dashboard_state.dart'
    as _i6;
import 'package:whale_staff/features/employee/domain/entities/bonus.dart'
    as _i28;
import 'package:whale_staff/features/employee/domain/entities/deduction.dart'
    as _i30;
import 'package:whale_staff/features/employee/domain/entities/employee.dart'
    as _i23;
import 'package:whale_staff/features/employee/domain/repositories/bonus_repository.dart'
    as _i4;
import 'package:whale_staff/features/employee/domain/repositories/deduction_repository.dart'
    as _i5;
import 'package:whale_staff/features/employee/domain/repositories/employee_repository.dart'
    as _i2;
import 'package:whale_staff/features/employee/domain/use_cases/bonus_use_cases.dart'
    as _i12;
import 'package:whale_staff/features/employee/domain/use_cases/employee_use_cases.dart'
    as _i7;
import 'package:whale_staff/features/employee/presentation/bloc/bonus_cubit.dart'
    as _i27;
import 'package:whale_staff/features/employee/presentation/bloc/bonus_state.dart'
    as _i13;
import 'package:whale_staff/features/employee/presentation/bloc/deduction_cubit.dart'
    as _i29;
import 'package:whale_staff/features/employee/presentation/bloc/deduction_state.dart'
    as _i14;
import 'package:whale_staff/features/employee/presentation/bloc/employee_cubit.dart'
    as _i22;
import 'package:whale_staff/features/employee/presentation/bloc/employee_state.dart'
    as _i8;
import 'package:whale_staff/features/leave/domain/entities/leave.dart' as _i26;
import 'package:whale_staff/features/leave/domain/repositories/leave_repository.dart'
    as _i3;
import 'package:whale_staff/features/leave/presentation/bloc/leave_cubit.dart'
    as _i25;
import 'package:whale_staff/features/leave/presentation/bloc/leave_state.dart'
    as _i11;
import 'package:whale_staff/features/salary/domain/entities/salary.dart'
    as _i16;
import 'package:whale_staff/features/salary/domain/repositories/salary_repository.dart'
    as _i15;
import 'package:whale_staff/features/salary/domain/use_cases/calculate_salary.dart'
    as _i9;
import 'package:whale_staff/features/salary/presentation/bloc/salary_cubit.dart'
    as _i24;
import 'package:whale_staff/features/salary/presentation/bloc/salary_state.dart'
    as _i10;

class _FakeEmployeeRepository_0 extends _i1.SmartFake
    implements _i2.EmployeeRepository {
  _FakeEmployeeRepository_0(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeLeaveRepository_1 extends _i1.SmartFake
    implements _i3.LeaveRepository {
  _FakeLeaveRepository_1(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeBonusRepository_2 extends _i1.SmartFake
    implements _i4.BonusRepository {
  _FakeBonusRepository_2(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeDeductionRepository_3 extends _i1.SmartFake
    implements _i5.DeductionRepository {
  _FakeDeductionRepository_3(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeDashboardState_4 extends _i1.SmartFake
    implements _i6.DashboardState {
  _FakeDashboardState_4(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeGetEmployees_5 extends _i1.SmartFake implements _i7.GetEmployees {
  _FakeGetEmployees_5(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeAddEmployee_6 extends _i1.SmartFake implements _i7.AddEmployee {
  _FakeAddEmployee_6(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeUpdateEmployee_7 extends _i1.SmartFake
    implements _i7.UpdateEmployee {
  _FakeUpdateEmployee_7(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeDeleteEmployee_8 extends _i1.SmartFake
    implements _i7.DeleteEmployee {
  _FakeDeleteEmployee_8(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeEmployeeState_9 extends _i1.SmartFake implements _i8.EmployeeState {
  _FakeEmployeeState_9(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeCalculateSalary_10 extends _i1.SmartFake
    implements _i9.CalculateSalary {
  _FakeCalculateSalary_10(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeSalaryState_11 extends _i1.SmartFake implements _i10.SalaryState {
  _FakeSalaryState_11(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeLeaveState_12 extends _i1.SmartFake implements _i11.LeaveState {
  _FakeLeaveState_12(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeAddBonus_13 extends _i1.SmartFake implements _i12.AddBonus {
  _FakeAddBonus_13(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeGetEmployeeBonuses_14 extends _i1.SmartFake
    implements _i12.GetEmployeeBonuses {
  _FakeGetEmployeeBonuses_14(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeGetAllBonuses_15 extends _i1.SmartFake
    implements _i12.GetAllBonuses {
  _FakeGetAllBonuses_15(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeDeleteBonus_16 extends _i1.SmartFake implements _i12.DeleteBonus {
  _FakeDeleteBonus_16(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeBonusState_17 extends _i1.SmartFake implements _i13.BonusState {
  _FakeBonusState_17(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeDeductionState_18 extends _i1.SmartFake
    implements _i14.DeductionState {
  _FakeDeductionState_18(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeSalaryRepository_19 extends _i1.SmartFake
    implements _i15.SalaryRepository {
  _FakeSalaryRepository_19(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeSalary_20 extends _i1.SmartFake implements _i16.Salary {
  _FakeSalary_20(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class MockThemeCubit extends _i1.Mock implements _i17.ThemeCubit {
  MockThemeCubit() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i18.ThemeMode get state =>
      (super.noSuchMethod(
            Invocation.getter(#state),
            returnValue: _i18.ThemeMode.system,
          )
          as _i18.ThemeMode);

  @override
  _i19.Stream<_i18.ThemeMode> get stream =>
      (super.noSuchMethod(
            Invocation.getter(#stream),
            returnValue: _i19.Stream<_i18.ThemeMode>.empty(),
          )
          as _i19.Stream<_i18.ThemeMode>);

  @override
  bool get isClosed =>
      (super.noSuchMethod(Invocation.getter(#isClosed), returnValue: false)
          as bool);

  @override
  _i19.Future<void> toggleTheme() =>
      (super.noSuchMethod(
            Invocation.method(#toggleTheme, []),
            returnValue: _i19.Future<void>.value(),
            returnValueForMissingStub: _i19.Future<void>.value(),
          )
          as _i19.Future<void>);

  @override
  _i19.Future<void> setTheme(_i18.ThemeMode? mode) =>
      (super.noSuchMethod(
            Invocation.method(#setTheme, [mode]),
            returnValue: _i19.Future<void>.value(),
            returnValueForMissingStub: _i19.Future<void>.value(),
          )
          as _i19.Future<void>);

  @override
  void emit(_i18.ThemeMode? state) => super.noSuchMethod(
    Invocation.method(#emit, [state]),
    returnValueForMissingStub: null,
  );

  @override
  void onChange(_i20.Change<_i18.ThemeMode>? change) => super.noSuchMethod(
    Invocation.method(#onChange, [change]),
    returnValueForMissingStub: null,
  );

  @override
  void addError(Object? error, [StackTrace? stackTrace]) => super.noSuchMethod(
    Invocation.method(#addError, [error, stackTrace]),
    returnValueForMissingStub: null,
  );

  @override
  void onError(Object? error, StackTrace? stackTrace) => super.noSuchMethod(
    Invocation.method(#onError, [error, stackTrace]),
    returnValueForMissingStub: null,
  );

  @override
  _i19.Future<void> close() =>
      (super.noSuchMethod(
            Invocation.method(#close, []),
            returnValue: _i19.Future<void>.value(),
            returnValueForMissingStub: _i19.Future<void>.value(),
          )
          as _i19.Future<void>);
}

class MockDashboardCubit extends _i1.Mock implements _i21.DashboardCubit {
  MockDashboardCubit() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.EmployeeRepository get employeeRepository =>
      (super.noSuchMethod(
            Invocation.getter(#employeeRepository),
            returnValue: _FakeEmployeeRepository_0(
              this,
              Invocation.getter(#employeeRepository),
            ),
          )
          as _i2.EmployeeRepository);

  @override
  _i3.LeaveRepository get leaveRepository =>
      (super.noSuchMethod(
            Invocation.getter(#leaveRepository),
            returnValue: _FakeLeaveRepository_1(
              this,
              Invocation.getter(#leaveRepository),
            ),
          )
          as _i3.LeaveRepository);

  @override
  _i4.BonusRepository get bonusRepository =>
      (super.noSuchMethod(
            Invocation.getter(#bonusRepository),
            returnValue: _FakeBonusRepository_2(
              this,
              Invocation.getter(#bonusRepository),
            ),
          )
          as _i4.BonusRepository);

  @override
  _i5.DeductionRepository get deductionRepository =>
      (super.noSuchMethod(
            Invocation.getter(#deductionRepository),
            returnValue: _FakeDeductionRepository_3(
              this,
              Invocation.getter(#deductionRepository),
            ),
          )
          as _i5.DeductionRepository);

  @override
  _i6.DashboardState get state =>
      (super.noSuchMethod(
            Invocation.getter(#state),
            returnValue: _FakeDashboardState_4(this, Invocation.getter(#state)),
          )
          as _i6.DashboardState);

  @override
  _i19.Stream<_i6.DashboardState> get stream =>
      (super.noSuchMethod(
            Invocation.getter(#stream),
            returnValue: _i19.Stream<_i6.DashboardState>.empty(),
          )
          as _i19.Stream<_i6.DashboardState>);

  @override
  bool get isClosed =>
      (super.noSuchMethod(Invocation.getter(#isClosed), returnValue: false)
          as bool);

  @override
  _i19.Future<void> loadDashboardData() =>
      (super.noSuchMethod(
            Invocation.method(#loadDashboardData, []),
            returnValue: _i19.Future<void>.value(),
            returnValueForMissingStub: _i19.Future<void>.value(),
          )
          as _i19.Future<void>);

  @override
  void emit(_i6.DashboardState? state) => super.noSuchMethod(
    Invocation.method(#emit, [state]),
    returnValueForMissingStub: null,
  );

  @override
  void onChange(_i20.Change<_i6.DashboardState>? change) => super.noSuchMethod(
    Invocation.method(#onChange, [change]),
    returnValueForMissingStub: null,
  );

  @override
  void addError(Object? error, [StackTrace? stackTrace]) => super.noSuchMethod(
    Invocation.method(#addError, [error, stackTrace]),
    returnValueForMissingStub: null,
  );

  @override
  void onError(Object? error, StackTrace? stackTrace) => super.noSuchMethod(
    Invocation.method(#onError, [error, stackTrace]),
    returnValueForMissingStub: null,
  );

  @override
  _i19.Future<void> close() =>
      (super.noSuchMethod(
            Invocation.method(#close, []),
            returnValue: _i19.Future<void>.value(),
            returnValueForMissingStub: _i19.Future<void>.value(),
          )
          as _i19.Future<void>);
}

class MockEmployeeCubit extends _i1.Mock implements _i22.EmployeeCubit {
  MockEmployeeCubit() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.GetEmployees get getEmployeesUseCase =>
      (super.noSuchMethod(
            Invocation.getter(#getEmployeesUseCase),
            returnValue: _FakeGetEmployees_5(
              this,
              Invocation.getter(#getEmployeesUseCase),
            ),
          )
          as _i7.GetEmployees);

  @override
  _i7.AddEmployee get addEmployeeUseCase =>
      (super.noSuchMethod(
            Invocation.getter(#addEmployeeUseCase),
            returnValue: _FakeAddEmployee_6(
              this,
              Invocation.getter(#addEmployeeUseCase),
            ),
          )
          as _i7.AddEmployee);

  @override
  _i7.UpdateEmployee get updateEmployeeUseCase =>
      (super.noSuchMethod(
            Invocation.getter(#updateEmployeeUseCase),
            returnValue: _FakeUpdateEmployee_7(
              this,
              Invocation.getter(#updateEmployeeUseCase),
            ),
          )
          as _i7.UpdateEmployee);

  @override
  _i7.DeleteEmployee get deleteEmployeeUseCase =>
      (super.noSuchMethod(
            Invocation.getter(#deleteEmployeeUseCase),
            returnValue: _FakeDeleteEmployee_8(
              this,
              Invocation.getter(#deleteEmployeeUseCase),
            ),
          )
          as _i7.DeleteEmployee);

  @override
  _i8.EmployeeState get state =>
      (super.noSuchMethod(
            Invocation.getter(#state),
            returnValue: _FakeEmployeeState_9(this, Invocation.getter(#state)),
          )
          as _i8.EmployeeState);

  @override
  _i19.Stream<_i8.EmployeeState> get stream =>
      (super.noSuchMethod(
            Invocation.getter(#stream),
            returnValue: _i19.Stream<_i8.EmployeeState>.empty(),
          )
          as _i19.Stream<_i8.EmployeeState>);

  @override
  bool get isClosed =>
      (super.noSuchMethod(Invocation.getter(#isClosed), returnValue: false)
          as bool);

  @override
  _i19.Future<void> loadEmployees() =>
      (super.noSuchMethod(
            Invocation.method(#loadEmployees, []),
            returnValue: _i19.Future<void>.value(),
            returnValueForMissingStub: _i19.Future<void>.value(),
          )
          as _i19.Future<void>);

  @override
  void searchEmployees(String? query) => super.noSuchMethod(
    Invocation.method(#searchEmployees, [query]),
    returnValueForMissingStub: null,
  );

  @override
  _i19.Future<void> addEmployee(_i23.Employee? employee) =>
      (super.noSuchMethod(
            Invocation.method(#addEmployee, [employee]),
            returnValue: _i19.Future<void>.value(),
            returnValueForMissingStub: _i19.Future<void>.value(),
          )
          as _i19.Future<void>);

  @override
  _i19.Future<void> updateEmployee(_i23.Employee? employee) =>
      (super.noSuchMethod(
            Invocation.method(#updateEmployee, [employee]),
            returnValue: _i19.Future<void>.value(),
            returnValueForMissingStub: _i19.Future<void>.value(),
          )
          as _i19.Future<void>);

  @override
  _i19.Future<void> deleteEmployee(String? id) =>
      (super.noSuchMethod(
            Invocation.method(#deleteEmployee, [id]),
            returnValue: _i19.Future<void>.value(),
            returnValueForMissingStub: _i19.Future<void>.value(),
          )
          as _i19.Future<void>);

  @override
  void emit(_i8.EmployeeState? state) => super.noSuchMethod(
    Invocation.method(#emit, [state]),
    returnValueForMissingStub: null,
  );

  @override
  void onChange(_i20.Change<_i8.EmployeeState>? change) => super.noSuchMethod(
    Invocation.method(#onChange, [change]),
    returnValueForMissingStub: null,
  );

  @override
  void addError(Object? error, [StackTrace? stackTrace]) => super.noSuchMethod(
    Invocation.method(#addError, [error, stackTrace]),
    returnValueForMissingStub: null,
  );

  @override
  void onError(Object? error, StackTrace? stackTrace) => super.noSuchMethod(
    Invocation.method(#onError, [error, stackTrace]),
    returnValueForMissingStub: null,
  );

  @override
  _i19.Future<void> close() =>
      (super.noSuchMethod(
            Invocation.method(#close, []),
            returnValue: _i19.Future<void>.value(),
            returnValueForMissingStub: _i19.Future<void>.value(),
          )
          as _i19.Future<void>);
}

class MockSalaryCubit extends _i1.Mock implements _i24.SalaryCubit {
  MockSalaryCubit() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i9.CalculateSalary get calculateSalaryUseCase =>
      (super.noSuchMethod(
            Invocation.getter(#calculateSalaryUseCase),
            returnValue: _FakeCalculateSalary_10(
              this,
              Invocation.getter(#calculateSalaryUseCase),
            ),
          )
          as _i9.CalculateSalary);

  @override
  _i10.SalaryState get state =>
      (super.noSuchMethod(
            Invocation.getter(#state),
            returnValue: _FakeSalaryState_11(this, Invocation.getter(#state)),
          )
          as _i10.SalaryState);

  @override
  _i19.Stream<_i10.SalaryState> get stream =>
      (super.noSuchMethod(
            Invocation.getter(#stream),
            returnValue: _i19.Stream<_i10.SalaryState>.empty(),
          )
          as _i19.Stream<_i10.SalaryState>);

  @override
  bool get isClosed =>
      (super.noSuchMethod(Invocation.getter(#isClosed), returnValue: false)
          as bool);

  @override
  _i19.Future<void> calculateEmployeeSalary(
    String? employeeId, {
    double? bonus = 0.0,
  }) =>
      (super.noSuchMethod(
            Invocation.method(
              #calculateEmployeeSalary,
              [employeeId],
              {#bonus: bonus},
            ),
            returnValue: _i19.Future<void>.value(),
            returnValueForMissingStub: _i19.Future<void>.value(),
          )
          as _i19.Future<void>);

  @override
  _i19.Future<void> saveSalary(_i16.Salary? salary) =>
      (super.noSuchMethod(
            Invocation.method(#saveSalary, [salary]),
            returnValue: _i19.Future<void>.value(),
            returnValueForMissingStub: _i19.Future<void>.value(),
          )
          as _i19.Future<void>);

  @override
  void emit(_i10.SalaryState? state) => super.noSuchMethod(
    Invocation.method(#emit, [state]),
    returnValueForMissingStub: null,
  );

  @override
  void onChange(_i20.Change<_i10.SalaryState>? change) => super.noSuchMethod(
    Invocation.method(#onChange, [change]),
    returnValueForMissingStub: null,
  );

  @override
  void addError(Object? error, [StackTrace? stackTrace]) => super.noSuchMethod(
    Invocation.method(#addError, [error, stackTrace]),
    returnValueForMissingStub: null,
  );

  @override
  void onError(Object? error, StackTrace? stackTrace) => super.noSuchMethod(
    Invocation.method(#onError, [error, stackTrace]),
    returnValueForMissingStub: null,
  );

  @override
  _i19.Future<void> close() =>
      (super.noSuchMethod(
            Invocation.method(#close, []),
            returnValue: _i19.Future<void>.value(),
            returnValueForMissingStub: _i19.Future<void>.value(),
          )
          as _i19.Future<void>);
}

class MockLeaveCubit extends _i1.Mock implements _i25.LeaveCubit {
  MockLeaveCubit() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.LeaveRepository get leaveRepository =>
      (super.noSuchMethod(
            Invocation.getter(#leaveRepository),
            returnValue: _FakeLeaveRepository_1(
              this,
              Invocation.getter(#leaveRepository),
            ),
          )
          as _i3.LeaveRepository);

  @override
  _i11.LeaveState get state =>
      (super.noSuchMethod(
            Invocation.getter(#state),
            returnValue: _FakeLeaveState_12(this, Invocation.getter(#state)),
          )
          as _i11.LeaveState);

  @override
  _i19.Stream<_i11.LeaveState> get stream =>
      (super.noSuchMethod(
            Invocation.getter(#stream),
            returnValue: _i19.Stream<_i11.LeaveState>.empty(),
          )
          as _i19.Stream<_i11.LeaveState>);

  @override
  bool get isClosed =>
      (super.noSuchMethod(Invocation.getter(#isClosed), returnValue: false)
          as bool);

  @override
  _i19.Future<void> loadLeaves(String? employeeId) =>
      (super.noSuchMethod(
            Invocation.method(#loadLeaves, [employeeId]),
            returnValue: _i19.Future<void>.value(),
            returnValueForMissingStub: _i19.Future<void>.value(),
          )
          as _i19.Future<void>);

  @override
  _i19.Future<void> loadAllLeaves() =>
      (super.noSuchMethod(
            Invocation.method(#loadAllLeaves, []),
            returnValue: _i19.Future<void>.value(),
            returnValueForMissingStub: _i19.Future<void>.value(),
          )
          as _i19.Future<void>);

  @override
  void searchLeaves(String? query, Map<String, String>? employeeNames) =>
      super.noSuchMethod(
        Invocation.method(#searchLeaves, [query, employeeNames]),
        returnValueForMissingStub: null,
      );

  @override
  _i19.Future<void> applyLeave(_i26.Leave? leave) =>
      (super.noSuchMethod(
            Invocation.method(#applyLeave, [leave]),
            returnValue: _i19.Future<void>.value(),
            returnValueForMissingStub: _i19.Future<void>.value(),
          )
          as _i19.Future<void>);

  @override
  _i19.Future<void> updateLeaveStatus(String? id, _i26.LeaveStatus? status) =>
      (super.noSuchMethod(
            Invocation.method(#updateLeaveStatus, [id, status]),
            returnValue: _i19.Future<void>.value(),
            returnValueForMissingStub: _i19.Future<void>.value(),
          )
          as _i19.Future<void>);

  @override
  void emit(_i11.LeaveState? state) => super.noSuchMethod(
    Invocation.method(#emit, [state]),
    returnValueForMissingStub: null,
  );

  @override
  void onChange(_i20.Change<_i11.LeaveState>? change) => super.noSuchMethod(
    Invocation.method(#onChange, [change]),
    returnValueForMissingStub: null,
  );

  @override
  void addError(Object? error, [StackTrace? stackTrace]) => super.noSuchMethod(
    Invocation.method(#addError, [error, stackTrace]),
    returnValueForMissingStub: null,
  );

  @override
  void onError(Object? error, StackTrace? stackTrace) => super.noSuchMethod(
    Invocation.method(#onError, [error, stackTrace]),
    returnValueForMissingStub: null,
  );

  @override
  _i19.Future<void> close() =>
      (super.noSuchMethod(
            Invocation.method(#close, []),
            returnValue: _i19.Future<void>.value(),
            returnValueForMissingStub: _i19.Future<void>.value(),
          )
          as _i19.Future<void>);
}

class MockBonusCubit extends _i1.Mock implements _i27.BonusCubit {
  MockBonusCubit() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i12.AddBonus get addBonusUseCase =>
      (super.noSuchMethod(
            Invocation.getter(#addBonusUseCase),
            returnValue: _FakeAddBonus_13(
              this,
              Invocation.getter(#addBonusUseCase),
            ),
          )
          as _i12.AddBonus);

  @override
  _i12.GetEmployeeBonuses get getEmployeeBonusesUseCase =>
      (super.noSuchMethod(
            Invocation.getter(#getEmployeeBonusesUseCase),
            returnValue: _FakeGetEmployeeBonuses_14(
              this,
              Invocation.getter(#getEmployeeBonusesUseCase),
            ),
          )
          as _i12.GetEmployeeBonuses);

  @override
  _i12.GetAllBonuses get getAllBonusesUseCase =>
      (super.noSuchMethod(
            Invocation.getter(#getAllBonusesUseCase),
            returnValue: _FakeGetAllBonuses_15(
              this,
              Invocation.getter(#getAllBonusesUseCase),
            ),
          )
          as _i12.GetAllBonuses);

  @override
  _i12.DeleteBonus get deleteBonusUseCase =>
      (super.noSuchMethod(
            Invocation.getter(#deleteBonusUseCase),
            returnValue: _FakeDeleteBonus_16(
              this,
              Invocation.getter(#deleteBonusUseCase),
            ),
          )
          as _i12.DeleteBonus);

  @override
  _i13.BonusState get state =>
      (super.noSuchMethod(
            Invocation.getter(#state),
            returnValue: _FakeBonusState_17(this, Invocation.getter(#state)),
          )
          as _i13.BonusState);

  @override
  _i19.Stream<_i13.BonusState> get stream =>
      (super.noSuchMethod(
            Invocation.getter(#stream),
            returnValue: _i19.Stream<_i13.BonusState>.empty(),
          )
          as _i19.Stream<_i13.BonusState>);

  @override
  bool get isClosed =>
      (super.noSuchMethod(Invocation.getter(#isClosed), returnValue: false)
          as bool);

  @override
  _i19.Future<void> loadAllBonuses() =>
      (super.noSuchMethod(
            Invocation.method(#loadAllBonuses, []),
            returnValue: _i19.Future<void>.value(),
            returnValueForMissingStub: _i19.Future<void>.value(),
          )
          as _i19.Future<void>);

  @override
  void searchBonuses(String? query, Map<String, String>? employeeNames) =>
      super.noSuchMethod(
        Invocation.method(#searchBonuses, [query, employeeNames]),
        returnValueForMissingStub: null,
      );

  @override
  _i19.Future<void> addBonus(_i28.Bonus? bonus) =>
      (super.noSuchMethod(
            Invocation.method(#addBonus, [bonus]),
            returnValue: _i19.Future<void>.value(),
            returnValueForMissingStub: _i19.Future<void>.value(),
          )
          as _i19.Future<void>);

  @override
  _i19.Future<void> removeBonus(String? id) =>
      (super.noSuchMethod(
            Invocation.method(#removeBonus, [id]),
            returnValue: _i19.Future<void>.value(),
            returnValueForMissingStub: _i19.Future<void>.value(),
          )
          as _i19.Future<void>);

  @override
  void emit(_i13.BonusState? state) => super.noSuchMethod(
    Invocation.method(#emit, [state]),
    returnValueForMissingStub: null,
  );

  @override
  void onChange(_i20.Change<_i13.BonusState>? change) => super.noSuchMethod(
    Invocation.method(#onChange, [change]),
    returnValueForMissingStub: null,
  );

  @override
  void addError(Object? error, [StackTrace? stackTrace]) => super.noSuchMethod(
    Invocation.method(#addError, [error, stackTrace]),
    returnValueForMissingStub: null,
  );

  @override
  void onError(Object? error, StackTrace? stackTrace) => super.noSuchMethod(
    Invocation.method(#onError, [error, stackTrace]),
    returnValueForMissingStub: null,
  );

  @override
  _i19.Future<void> close() =>
      (super.noSuchMethod(
            Invocation.method(#close, []),
            returnValue: _i19.Future<void>.value(),
            returnValueForMissingStub: _i19.Future<void>.value(),
          )
          as _i19.Future<void>);
}

class MockDeductionCubit extends _i1.Mock implements _i29.DeductionCubit {
  MockDeductionCubit() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.DeductionRepository get repository =>
      (super.noSuchMethod(
            Invocation.getter(#repository),
            returnValue: _FakeDeductionRepository_3(
              this,
              Invocation.getter(#repository),
            ),
          )
          as _i5.DeductionRepository);

  @override
  _i14.DeductionState get state =>
      (super.noSuchMethod(
            Invocation.getter(#state),
            returnValue: _FakeDeductionState_18(
              this,
              Invocation.getter(#state),
            ),
          )
          as _i14.DeductionState);

  @override
  _i19.Stream<_i14.DeductionState> get stream =>
      (super.noSuchMethod(
            Invocation.getter(#stream),
            returnValue: _i19.Stream<_i14.DeductionState>.empty(),
          )
          as _i19.Stream<_i14.DeductionState>);

  @override
  bool get isClosed =>
      (super.noSuchMethod(Invocation.getter(#isClosed), returnValue: false)
          as bool);

  @override
  _i19.Future<void> loadDeductions() =>
      (super.noSuchMethod(
            Invocation.method(#loadDeductions, []),
            returnValue: _i19.Future<void>.value(),
            returnValueForMissingStub: _i19.Future<void>.value(),
          )
          as _i19.Future<void>);

  @override
  void searchDeductions(String? query, Map<String, String>? employeeNames) =>
      super.noSuchMethod(
        Invocation.method(#searchDeductions, [query, employeeNames]),
        returnValueForMissingStub: null,
      );

  @override
  _i19.Future<void> addDeduction(_i30.Deduction? deduction) =>
      (super.noSuchMethod(
            Invocation.method(#addDeduction, [deduction]),
            returnValue: _i19.Future<void>.value(),
            returnValueForMissingStub: _i19.Future<void>.value(),
          )
          as _i19.Future<void>);

  @override
  _i19.Future<void> removeDeduction(String? id) =>
      (super.noSuchMethod(
            Invocation.method(#removeDeduction, [id]),
            returnValue: _i19.Future<void>.value(),
            returnValueForMissingStub: _i19.Future<void>.value(),
          )
          as _i19.Future<void>);

  @override
  void emit(_i14.DeductionState? state) => super.noSuchMethod(
    Invocation.method(#emit, [state]),
    returnValueForMissingStub: null,
  );

  @override
  void onChange(_i20.Change<_i14.DeductionState>? change) => super.noSuchMethod(
    Invocation.method(#onChange, [change]),
    returnValueForMissingStub: null,
  );

  @override
  void addError(Object? error, [StackTrace? stackTrace]) => super.noSuchMethod(
    Invocation.method(#addError, [error, stackTrace]),
    returnValueForMissingStub: null,
  );

  @override
  void onError(Object? error, StackTrace? stackTrace) => super.noSuchMethod(
    Invocation.method(#onError, [error, stackTrace]),
    returnValueForMissingStub: null,
  );

  @override
  _i19.Future<void> close() =>
      (super.noSuchMethod(
            Invocation.method(#close, []),
            returnValue: _i19.Future<void>.value(),
            returnValueForMissingStub: _i19.Future<void>.value(),
          )
          as _i19.Future<void>);
}

class MockSalaryRepository extends _i1.Mock implements _i15.SalaryRepository {
  MockSalaryRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i19.Future<List<_i16.Salary>> getSalaryHistory(String? employeeId) =>
      (super.noSuchMethod(
            Invocation.method(#getSalaryHistory, [employeeId]),
            returnValue: _i19.Future<List<_i16.Salary>>.value(<_i16.Salary>[]),
          )
          as _i19.Future<List<_i16.Salary>>);

  @override
  _i19.Future<List<_i16.Salary>> getAllSalaries() =>
      (super.noSuchMethod(
            Invocation.method(#getAllSalaries, []),
            returnValue: _i19.Future<List<_i16.Salary>>.value(<_i16.Salary>[]),
          )
          as _i19.Future<List<_i16.Salary>>);

  @override
  _i19.Future<void> saveSalary(_i16.Salary? salary) =>
      (super.noSuchMethod(
            Invocation.method(#saveSalary, [salary]),
            returnValue: _i19.Future<void>.value(),
            returnValueForMissingStub: _i19.Future<void>.value(),
          )
          as _i19.Future<void>);

  @override
  _i19.Future<_i16.Salary?> getLatestSalary(String? employeeId) =>
      (super.noSuchMethod(
            Invocation.method(#getLatestSalary, [employeeId]),
            returnValue: _i19.Future<_i16.Salary?>.value(),
          )
          as _i19.Future<_i16.Salary?>);
}

class MockCalculateSalary extends _i1.Mock implements _i9.CalculateSalary {
  MockCalculateSalary() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i15.SalaryRepository get salaryRepository =>
      (super.noSuchMethod(
            Invocation.getter(#salaryRepository),
            returnValue: _FakeSalaryRepository_19(
              this,
              Invocation.getter(#salaryRepository),
            ),
          )
          as _i15.SalaryRepository);

  @override
  _i2.EmployeeRepository get employeeRepository =>
      (super.noSuchMethod(
            Invocation.getter(#employeeRepository),
            returnValue: _FakeEmployeeRepository_0(
              this,
              Invocation.getter(#employeeRepository),
            ),
          )
          as _i2.EmployeeRepository);

  @override
  _i4.BonusRepository get bonusRepository =>
      (super.noSuchMethod(
            Invocation.getter(#bonusRepository),
            returnValue: _FakeBonusRepository_2(
              this,
              Invocation.getter(#bonusRepository),
            ),
          )
          as _i4.BonusRepository);

  @override
  _i5.DeductionRepository get deductionRepository =>
      (super.noSuchMethod(
            Invocation.getter(#deductionRepository),
            returnValue: _FakeDeductionRepository_3(
              this,
              Invocation.getter(#deductionRepository),
            ),
          )
          as _i5.DeductionRepository);

  @override
  _i19.Future<_i16.Salary> call(
    String? employeeId, {
    double? extraBonus = 0.0,
    bool? shouldSave = true,
  }) =>
      (super.noSuchMethod(
            Invocation.method(
              #call,
              [employeeId],
              {#extraBonus: extraBonus, #shouldSave: shouldSave},
            ),
            returnValue: _i19.Future<_i16.Salary>.value(
              _FakeSalary_20(
                this,
                Invocation.method(
                  #call,
                  [employeeId],
                  {#extraBonus: extraBonus, #shouldSave: shouldSave},
                ),
              ),
            ),
          )
          as _i19.Future<_i16.Salary>);
}
