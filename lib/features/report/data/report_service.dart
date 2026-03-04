import 'dart:typed_data';
import 'package:excel/excel.dart';
import 'package:file_saver/file_saver.dart';
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

  Future<void> exportSalaryReportToWord(List<Salary> salaries) async {}
}
