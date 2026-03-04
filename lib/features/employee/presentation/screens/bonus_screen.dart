import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:whale_staff/core/widgets/employee_dropdown_field.dart';
import 'package:whale_staff/features/employee/domain/entities/employee.dart';
import 'package:whale_staff/features/employee/domain/entities/bonus.dart';
import 'package:whale_staff/features/employee/presentation/bloc/employee_cubit.dart';
import 'package:whale_staff/features/employee/presentation/bloc/employee_state.dart';
import 'package:whale_staff/features/employee/presentation/bloc/bonus_cubit.dart';
import 'package:whale_staff/features/employee/presentation/bloc/bonus_state.dart';
import 'package:whale_staff/core/widgets/custom_date_picker_field.dart';

class BonusScreen extends StatelessWidget {
  const BonusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Bonus Management',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () => _showAddBonusDialog(context),
                icon: const Icon(Icons.add),
                label: const Text('Add Bonus'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(16),
              ),
              child: BlocBuilder<EmployeeCubit, EmployeeState>(
                builder: (context, employeeState) {
                  return BlocBuilder<BonusCubit, BonusState>(
                    builder: (context, state) {
                      if (state is BonusLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (state is BonusLoaded) {
                        if (state.bonuses.isEmpty) {
                          return const Center(
                            child: Text('No manual bonuses found.'),
                          );
                        }

                        final employees = employeeState is EmployeeLoaded
                            ? {
                                for (var e in employeeState.employees)
                                  e.id: e.name,
                              }
                            : <String, String>{};

                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            columns: const [
                              DataColumn(label: Text('Employee')),
                              DataColumn(label: Text('Amount')),
                              DataColumn(label: Text('Reason')),
                              DataColumn(label: Text('Date')),
                              DataColumn(label: Text('Actions')),
                            ],
                            rows: state.bonuses.map((bonus) {
                              final employeeName =
                                  employees[bonus.employeeId] ?? 'Unknown';
                              return DataRow(
                                cells: [
                                  DataCell(Text(employeeName)),
                                  DataCell(
                                    Text(
                                      '\$${bonus.amount.toStringAsFixed(2)}',
                                      style: const TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  DataCell(Text(bonus.reason)),
                                  DataCell(
                                    Text(
                                      DateFormat(
                                        'yyyy-MM-dd',
                                      ).format(bonus.date),
                                    ),
                                  ),
                                  DataCell(
                                    IconButton(
                                      icon: const Icon(
                                        Icons.delete_outline,
                                        color: Colors.red,
                                      ),
                                      onPressed: () => context
                                          .read<BonusCubit>()
                                          .removeBonus(bonus.id),
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                          ),
                        );
                      }
                      return const SizedBox();
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddBonusDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (diagContext) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: context.read<BonusCubit>()),
          BlocProvider.value(value: context.read<EmployeeCubit>()),
        ],
        child: const _AddBonusDialog(),
      ),
    );
  }
}

class _AddBonusDialog extends StatefulWidget {
  const _AddBonusDialog();

  @override
  State<_AddBonusDialog> createState() => _AddBonusDialogState();
}

class _AddBonusDialogState extends State<_AddBonusDialog> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedEmployeeId;
  final _amountController = TextEditingController();
  final _reasonController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Employee Bonus'),
      content: SingleChildScrollView(
        child: SizedBox(
          width: 400,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                BlocBuilder<EmployeeCubit, EmployeeState>(
                  builder: (context, state) {
                    if (state is EmployeeLoaded) {
                      final employees = state.employees
                          .cast<Employee>()
                          .toList();
                      return FormField<String>(
                        validator: (value) => value == null ? 'Required' : null,
                        builder: (fieldState) {
                          return EmployeeDropdownField(
                            employees: employees,
                            selectedEmployeeId: _selectedEmployeeId,
                            errorText: fieldState.errorText,
                            onSelected: (val) {
                              setState(() {
                                _selectedEmployeeId = val;
                                fieldState.didChange(val);
                              });
                            },
                          );
                        },
                      );
                    }
                    return const CircularProgressIndicator();
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _amountController,
                  decoration: InputDecoration(
                    labelText: 'Bonus Amount (\$)',
                    prefixText: '\$ ',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (val) {
                    if (val == null || val.isEmpty) return 'Required';
                    if (double.tryParse(val) == null) return 'Invalid amount';
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _reasonController,
                  decoration: const InputDecoration(labelText: 'Reason'),
                  validator: (val) => val!.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 16),
                CustomDatePickerField(
                  label: 'Bonus Date',
                  selectedDate: _selectedDate,
                  onDateSelected: (date) =>
                      setState(() => _selectedDate = date),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final bonus = Bonus(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                employeeId: _selectedEmployeeId!,
                amount: double.parse(_amountController.text),
                reason: _reasonController.text,
                date: _selectedDate,
              );
              context.read<BonusCubit>().addBonus(bonus);
              Navigator.pop(context);
            }
          },
          child: const Text('Add Bonus'),
        ),
      ],
    );
  }
}
