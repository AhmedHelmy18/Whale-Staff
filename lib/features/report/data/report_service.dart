import 'dart:typed_data';
import 'package:excel/excel.dart';
import 'package:file_saver/file_saver.dart';
import 'package:intl/intl.dart';
import 'package:whale_staff/features/employee/domain/entities/employee.dart';
import 'package:whale_staff/features/salary/domain/entities/salary.dart';

class ReportService {
  Future<void> exportEmployeesToExcel(List<Employee> employees) async {
    var excel = Excel.createExcel();
    Sheet sheetObject = excel['Employees'];

    sheetObject.appendRow([
      TextCellValue('ID'),
      TextCellValue('Name'),
      TextCellValue('Email'),
      TextCellValue('Position'),
      TextCellValue('Base Salary'),
    ]);
    for (var emp in employees) {
      sheetObject.appendRow([
        TextCellValue(emp.id),
        TextCellValue(emp.name),
        TextCellValue(emp.email),
        TextCellValue(emp.position),
        DoubleCellValue(emp.baseSalary),
      ]);
    }

    final bytes = excel.encode();
    if (bytes != null) {
      await FileSaver.instance.saveFile(
        name: 'EmployeeList.xlsx',
        bytes: Uint8List.fromList(bytes),
        mimeType: MimeType.microsoftExcel,
      );
    }
  }

  Future<void> exportSalaryReportToWord(
    List<Salary> salaries,
    Map<String, String> employeeNames,
  ) async {
    var excel = Excel.createExcel();
    Sheet sheetObject = excel['Payroll Report'];

    sheetObject.appendRow([
      TextCellValue('Date'),
      TextCellValue('Employee'),
      TextCellValue('Base Salary'),
      TextCellValue('Bonus'),
      TextCellValue('Deductions'),
      TextCellValue('Net Salary'),
    ]);

    for (var salary in salaries) {
      final employeeName = employeeNames[salary.employeeId] ?? 'Unknown';
      sheetObject.appendRow([
        TextCellValue(DateFormat('yyyy-MM-dd').format(salary.calculationDate)),
        TextCellValue(employeeName),
        DoubleCellValue(salary.baseSalary),
        DoubleCellValue(salary.bonus),
        DoubleCellValue(salary.deductions),
        DoubleCellValue(salary.finalSalary),
      ]);
    }

    final bytes = excel.encode();
    if (bytes != null) {
      await FileSaver.instance.saveFile(
        name:
            'PayrollReport_${DateFormat('yyyyMM').format(DateTime.now())}.xlsx',
        bytes: Uint8List.fromList(bytes),
        mimeType: MimeType.microsoftExcel,
      );
    }
  }
}
