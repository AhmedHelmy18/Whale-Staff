import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whale_staff/features/employee/domain/entities/employee.dart';
import 'package:whale_staff/features/employee/presentation/bloc/employee_cubit.dart';
import 'package:whale_staff/features/employee/presentation/bloc/employee_state.dart';

class EmployeeListScreen extends StatelessWidget {
  const EmployeeListScreen({super.key});

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
                'Employees',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () => _showEmployeeDialog(context),
                icon: const Icon(Icons.add),
                label: const Text('Add Employee'),
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
                builder: (context, state) {
                  if (state is EmployeeLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is EmployeeLoaded) {
                    if (state.employees.isEmpty) {
                      return Center(
                        child: Text(
                          state.searchQuery.isEmpty
                              ? 'No employees found.'
                              : 'No employees matching "${state.searchQuery}"',
                        ),
                      );
                    }
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: const [
                          DataColumn(label: Text('Name')),
                          DataColumn(label: Text('Position')),
                          DataColumn(label: Text('Email')),
                          DataColumn(label: Text('Base Salary')),
                          DataColumn(label: Text('Actions')),
                        ],
                        rows: state.employees.map((employee) {
                          return DataRow(
                            cells: [
                              DataCell(Text(employee.name)),
                              DataCell(Text(employee.position)),
                              DataCell(Text(employee.email)),
                              DataCell(
                                Text(
                                  '\$${employee.baseSalary.toStringAsFixed(2)}',
                                ),
                              ),
                              DataCell(
                                Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(
                                        Icons.edit_outlined,
                                        color: Colors.blue,
                                      ),
                                      onPressed: () => _showEmployeeDialog(
                                        context,
                                        employee: employee,
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.delete_outline,
                                        color: Colors.red,
                                      ),
                                      onPressed: () {
                                        context
                                            .read<EmployeeCubit>()
                                            .deleteEmployee(employee.id);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    );
                  }
                  if (state is EmployeeError) {
                    return Center(child: Text('Error: ${state.message}'));
                  }
                  return const SizedBox();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showEmployeeDialog(BuildContext context, {Employee? employee}) {
    showDialog(
      context: context,
      builder: (diagContext) => _EmployeeDialog(
        employee: employee,
        onSave: (newEmployee) {
          if (employee == null) {
            context.read<EmployeeCubit>().addEmployee(newEmployee);
          } else {
            context.read<EmployeeCubit>().updateEmployee(newEmployee);
          }
        },
      ),
    );
  }
}

class _EmployeeDialog extends StatefulWidget {
  final Employee? employee;
  final Function(Employee) onSave;

  const _EmployeeDialog({this.employee, required this.onSave});

  @override
  State<_EmployeeDialog> createState() => _EmployeeDialogState();
}

class _EmployeeDialogState extends State<_EmployeeDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _positionController;
  late TextEditingController _salaryController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.employee?.name ?? '');
    _emailController = TextEditingController(
      text: widget.employee?.email ?? '',
    );
    _phoneController = TextEditingController(
      text: widget.employee?.phone ?? '',
    );
    _positionController = TextEditingController(
      text: widget.employee?.position ?? '',
    );
    _salaryController = TextEditingController(
      text: widget.employee?.baseSalary.toString() ?? '',
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.employee == null ? 'Add Employee' : 'Edit Employee'),
      content: SizedBox(
        width: 500,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(labelText: 'Email'),
                      validator: (value) => value!.isEmpty ? 'Required' : null,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: _phoneController,
                      decoration: const InputDecoration(labelText: 'Phone'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _positionController,
                decoration: const InputDecoration(labelText: 'Position'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _salaryController,
                decoration: const InputDecoration(labelText: 'Base Salary'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    double.tryParse(value!) == null ? 'Invalid number' : null,
              ),
            ],
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
              final newEmployee = Employee(
                id:
                    widget.employee?.id ??
                    DateTime.now().millisecondsSinceEpoch.toString(),
                name: _nameController.text,
                email: _emailController.text,
                phone: _phoneController.text,
                position: _positionController.text,
                baseSalary: double.parse(_salaryController.text),
                hireDate: widget.employee?.hireDate ?? DateTime.now(),
                bonusPercentage: widget.employee?.bonusPercentage ?? 0.0,
              );
              widget.onSave(newEmployee);
              Navigator.pop(context);
            }
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
