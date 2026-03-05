import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whale_staff/features/employee/presentation/bloc/employee_cubit.dart';
import 'package:whale_staff/features/employee/presentation/bloc/employee_state.dart';
import 'package:whale_staff/features/salary/presentation/bloc/salary_cubit.dart';
import 'package:whale_staff/features/report/data/report_service.dart';
import 'package:whale_staff/core/widgets/whale_toast.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Reports',
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 24,
            runSpacing: 24,
            children: [
              _ReportCard(
                title: 'Employee List',
                description: 'Export all employee records to Excel',
                icon: Icons.table_chart,
                onTap: () {
                  final state = context.read<EmployeeCubit>().state;
                  if (state is EmployeeLoaded) {
                    ReportService().exportEmployeesToExcel(state.employees);
                    WhaleToast.show(
                      context,
                      'Employee list exported successfully',
                      type: ToastType.success,
                    );
                  }
                },
              ),
              _ReportCard(
                title: 'Salary Report',
                description: 'Export monthly salary details to Word',
                icon: Icons.description,
                onTap: () async {
                  final employees = context.read<EmployeeCubit>().state;
                  if (employees is EmployeeLoaded) {
                    final employeeNames = {
                      for (var emp in employees.employees) emp.id: emp.name,
                    };

                    final salaries = await context
                        .read<SalaryCubit>()
                        .calculateSalaryUseCase
                        .salaryRepository
                        .getAllSalaries();

                    if (salaries.isEmpty) {
                      if (context.mounted) {
                        WhaleToast.show(
                          context,
                          'No salaries found to export. Please calculate and save some salaries first.',
                          type: ToastType.info,
                        );
                      }
                      return;
                    }

                    await ReportService().exportSalaryReportToWord(
                      salaries,
                      employeeNames,
                    );

                    if (context.mounted) {
                      WhaleToast.show(
                        context,
                        'Salary report exported successfully',
                        type: ToastType.success,
                      );
                    }
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ReportCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final VoidCallback onTap;

  const _ReportCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 300,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 40, color: theme.colorScheme.primary),
            const SizedBox(height: 20),
            Text(
              title,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
