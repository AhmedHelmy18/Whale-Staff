import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:whale_staff/features/employee/data/models/employee_model.dart';
import 'package:whale_staff/features/leave/data/models/leave_model.dart';
import 'package:whale_staff/features/salary/data/models/salary_model.dart';

class HiveService {
  static Future<void> init() async {
    final directory = await getApplicationDocumentsDirectory();
    await Hive.initFlutter(directory.path);
    Hive.registerAdapter(EmployeeModelAdapter());
    Hive.registerAdapter(SalaryModelAdapter());
    Hive.registerAdapter(LeaveModelAdapter());
  }
}
