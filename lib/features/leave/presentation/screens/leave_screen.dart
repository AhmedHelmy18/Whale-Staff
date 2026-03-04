import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whale_staff/core/widgets/employee_dropdown_field.dart';
import 'package:whale_staff/features/leave/presentation/bloc/leave_cubit.dart';
import 'package:whale_staff/features/leave/presentation/bloc/leave_state.dart';
import 'package:whale_staff/features/leave/domain/entities/leave.dart';
import 'package:whale_staff/features/employee/presentation/bloc/employee_cubit.dart';
import 'package:whale_staff/features/employee/presentation/bloc/employee_state.dart';
import 'package:intl/intl.dart';
import 'package:whale_staff/features/employee/domain/entities/employee.dart';
import 'package:whale_staff/core/widgets/custom_date_picker_field.dart';

class LeaveScreen extends StatelessWidget {
  const LeaveScreen({super.key});

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
                'Leaves & Vacations',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () => _showLeaveDialog(context),
                icon: const Icon(Icons.add),
                label: const Text('Add Leave'),
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
                  return BlocBuilder<LeaveCubit, LeaveState>(
                    builder: (context, state) {
                      if (state is LeaveLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (state is LeaveLoaded) {
                        if (state.leaves.isEmpty) {
                          return const Center(
                            child: Text('No leave requests found.'),
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
                              DataColumn(label: Text('Start Date')),
                              DataColumn(label: Text('End Date')),
                              DataColumn(label: Text('Days')),
                              DataColumn(label: Text('Reason')),
                              DataColumn(label: Text('Status')),
                              DataColumn(label: Text('Actions')),
                            ],
                            rows: state.leaves.map((leave) {
                              final employeeName =
                                  employees[leave.employeeId] ?? 'Unknown';
                              final dateFormat = DateFormat('yyyy-MM-dd');

                              return DataRow(
                                cells: [
                                  DataCell(Text(employeeName)),
                                  DataCell(
                                    Text(dateFormat.format(leave.startDate)),
                                  ),
                                  DataCell(
                                    Text(dateFormat.format(leave.endDate)),
                                  ),
                                  DataCell(Text('${leave.durationInDays}')),
                                  DataCell(Text(leave.reason)),
                                  DataCell(
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: _getStatusColor(
                                          leave.status,
                                        ).withValues(alpha: 0.1),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        leave.status.name.toUpperCase(),
                                        style: TextStyle(
                                          color: _getStatusColor(leave.status),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Row(
                                      children: [
                                        if (leave.status ==
                                            LeaveStatus.pending) ...[
                                          IconButton(
                                            icon: const Icon(
                                              Icons.check_circle_outline,
                                              color: Colors.green,
                                            ),
                                            onPressed: () => context
                                                .read<LeaveCubit>()
                                                .updateLeaveStatus(
                                                  leave.id,
                                                  LeaveStatus.approved,
                                                ),
                                          ),
                                          IconButton(
                                            icon: const Icon(
                                              Icons.cancel_outlined,
                                              color: Colors.red,
                                            ),
                                            onPressed: () => context
                                                .read<LeaveCubit>()
                                                .updateLeaveStatus(
                                                  leave.id,
                                                  LeaveStatus.rejected,
                                                ),
                                          ),
                                        ],
                                      ],
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

  Color _getStatusColor(LeaveStatus status) {
    switch (status) {
      case LeaveStatus.approved:
        return Colors.green;
      case LeaveStatus.rejected:
        return Colors.red;
      case LeaveStatus.pending:
        return Colors.orange;
    }
  }

  void _showLeaveDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (diagContext) => BlocProvider.value(
        value: context.read<LeaveCubit>(),
        child: BlocProvider.value(
          value: context.read<EmployeeCubit>(),
          child: const _LeaveDialog(),
        ),
      ),
    );
  }
}

class _LeaveDialog extends StatefulWidget {
  const _LeaveDialog();

  @override
  State<_LeaveDialog> createState() => _LeaveDialogState();
}

class _LeaveDialogState extends State<_LeaveDialog> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedEmployeeId;
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(const Duration(days: 1));
  final _reasonController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Leave Request'),
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
                      if (employees.isEmpty) {
                        return const Text('No employees found.');
                      }

                      return FormField<String>(
                        initialValue: _selectedEmployeeId,
                        validator: (value) => value == null ? 'Required' : null,
                        builder: (fieldState) {
                          return EmployeeDropdownField(
                            employees: employees,
                            selectedEmployeeId: _selectedEmployeeId,
                            errorText: fieldState.errorText,
                            onSelected: (newValue) {
                              setState(() {
                                _selectedEmployeeId = newValue;
                                fieldState.didChange(newValue);
                              });
                            },
                          );
                        },
                      );
                    }
                    return const Text('Loading employees...');
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: CustomDatePickerField(
                        label: 'Start Date',
                        selectedDate: _startDate,
                        onDateSelected: (date) =>
                            setState(() => _startDate = date),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: CustomDatePickerField(
                        label: 'End Date',
                        selectedDate: _endDate,
                        onDateSelected: (date) =>
                            setState(() => _endDate = date),
                        firstDate: _startDate,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _reasonController,
                  decoration: const InputDecoration(labelText: 'Reason'),
                  validator: (val) => val!.isEmpty ? 'Required' : null,
                ),
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
              final leave = Leave(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                employeeId: _selectedEmployeeId!,
                startDate: _startDate,
                endDate: _endDate,
                reason: _reasonController.text,
                status: LeaveStatus.pending,
              );
              context.read<LeaveCubit>().applyLeave(leave);
              Navigator.pop(context);
            }
          },
          child: const Text('Apply'),
        ),
      ],
    );
  }
}
