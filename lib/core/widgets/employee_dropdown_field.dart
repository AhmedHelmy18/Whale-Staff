import 'package:flutter/material.dart';
import '../../features/employee/domain/entities/employee.dart';
import '../constants/app_colors.dart';

class EmployeeDropdownField extends StatelessWidget {
  final List<Employee> employees;
  final String? selectedEmployeeId;
  final ValueChanged<String?> onSelected;
  final String? errorText;

  const EmployeeDropdownField({
    super.key,
    required this.employees,
    required this.selectedEmployeeId,
    required this.onSelected,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return PopupMenuButton<String>(
          offset: const Offset(0, 50),
          color: const Color(0xFF0F0F0F),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: Colors.white.withValues(alpha: 0.1),
              width: 0.5,
            ),
          ),
          constraints: BoxConstraints(
            minWidth: constraints.maxWidth,
            maxWidth: constraints.maxWidth,
            maxHeight: 300,
          ),
          onSelected: onSelected,
          itemBuilder: (BuildContext context) {
            final List<PopupMenuEntry<String>> items = [];
            for (int i = 0; i < employees.length; i++) {
              items.add(
                PopupMenuItem<String>(
                  value: employees[i].id,
                  height: 40,
                  child: Text(
                    employees[i].name,
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              );
              if (i < employees.length - 1) {
                items.add(const PopupMenuDivider(height: 1));
              }
            }
            return items;
          },
          child: SizedBox(
            height: 50,
            child: InputDecorator(
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.backgroundDark,
                errorText: errorText,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.white12),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.white12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: AppColors.primaryLight),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 0,
                ),
                suffixIcon: const Icon(
                  Icons.arrow_drop_down,
                  color: AppColors.primaryLight,
                ),
              ),
              child: Text(
                selectedEmployeeId == null
                    ? 'Select Employee'
                    : employees
                          .firstWhere((e) => e.id == selectedEmployeeId)
                          .name,
                style: TextStyle(
                  color: selectedEmployeeId == null
                      ? Colors.white54
                      : Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
