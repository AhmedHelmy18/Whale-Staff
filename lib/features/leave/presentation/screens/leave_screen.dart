import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whale_staff/features/leave/presentation/bloc/leave_cubit.dart';
import 'package:whale_staff/features/leave/presentation/bloc/leave_state.dart';
import 'package:whale_staff/features/leave/domain/entities/leave.dart';

class LeaveScreen extends StatelessWidget {
  const LeaveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Leaves & Vacations',
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(16),
              ),
              child: BlocBuilder<LeaveCubit, LeaveState>(
                builder: (context, state) {
                  if (state is LeaveLoaded) {
                    if (state.leaves.isEmpty) {
                      return const Center(
                        child: Text('No leave requests found.'),
                      );
                    }
                    return ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemCount: state.leaves.length,
                      separatorBuilder: (context, index) => const Divider(),
                      itemBuilder: (context, index) {
                        final leave = state.leaves[index];
                        return ListTile(
                          title: Text('Leave ID: ${leave.id}'),
                          subtitle: Text('Reason: ${leave.reason}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                leave.status.name.toUpperCase(),
                                style: TextStyle(
                                  color: leave.status == LeaveStatus.approved
                                      ? Colors.green
                                      : (leave.status == LeaveStatus.rejected
                                            ? Colors.red
                                            : Colors.orange),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 16),
                              if (leave.status == LeaveStatus.pending) ...[
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
                        );
                      },
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
