import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whale_staff/features/employee/presentation/bloc/employee_cubit.dart';
import 'package:whale_staff/features/employee/presentation/bloc/employee_state.dart';
import 'package:whale_staff/features/salary/presentation/bloc/salary_cubit.dart';
import 'package:whale_staff/features/salary/presentation/bloc/salary_state.dart';

class SalaryScreen extends StatelessWidget {
  const SalaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Salary Management',
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth < 800) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 400, child: _EmployeeSalaryList()),
                        const SizedBox(height: 24),
                        _SalaryDetailsPanel(),
                      ],
                    ),
                  );
                }
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 1, child: _EmployeeSalaryList()),
                    const SizedBox(width: 24),
                    Expanded(flex: 2, child: _SalaryDetailsPanel()),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _EmployeeSalaryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: BlocBuilder<EmployeeCubit, EmployeeState>(
        builder: (context, state) {
          if (state is EmployeeLoaded) {
            return ListView.separated(
              itemCount: state.employees.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                final employee = state.employees[index];
                return ListTile(
                  title: Text(employee.name),
                  subtitle: Text(employee.position),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    context.read<SalaryCubit>().calculateEmployeeSalary(
                      employee.id,
                    );
                  },
                );
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class _SalaryDetailsPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<SalaryCubit, SalaryState>(
      builder: (context, state) {
        if (state is SalaryCalculated) {
          final salary = state.salary;
          return Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Salary Breakdown',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 32),
                _SalaryRow(
                  label: 'Base Salary',
                  value: '\$${salary.baseSalary.toStringAsFixed(2)}',
                ),
                _SalaryRow(
                  label: 'Bonus',
                  value: '\$${salary.bonus.toStringAsFixed(2)}',
                  color: Colors.green,
                ),
                _SalaryRow(
                  label: 'Deductions',
                  value: '-\$${salary.deductions.toStringAsFixed(2)}',
                  color: Colors.red,
                ),
                const Divider(height: 48),
                _SalaryRow(
                  label: 'Total Salary',
                  value: '\$${salary.finalSalary.toStringAsFixed(2)}',
                  isBold: true,
                  fontSize: 24,
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Confirm & Save'),
                  ),
                ),
              ],
            ),
          );
        }
        return const Center(
          child: Text('Select an employee to view salary calculation'),
        );
      },
    );
  }
}

class _SalaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;
  final double? fontSize;
  final Color? color;

  const _SalaryRow({
    required this.label,
    required this.value,
    this.isBold = false,
    this.fontSize,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: fontSize ?? 16,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: fontSize ?? 16,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
