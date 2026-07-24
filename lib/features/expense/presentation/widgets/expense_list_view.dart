import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:expense_tracker/features/expense/presentation/cubit/expense_cubit.dart';
import 'empty_state_view.dart';
import 'expense_tile.dart';
import 'fade_slide_in.dart';

class ExpenseListView extends StatelessWidget {
  final void Function(BuildContext context, dynamic expense) onTileTap;

  const ExpenseListView({super.key, required this.onTileTap});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseCubit, ExpenseState>(
      buildWhen: (previous, current) =>
          previous.visibleExpenses != current.visibleExpenses ||
          previous.isLoading != current.isLoading,
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        final expenses = state.visibleExpenses;
        if (expenses.isEmpty) {
          return EmptyStateView(
            message: state.filterCategory == null
                ? 'Hələ heç bir xərc əlavə edilməyib'
                : 'Bu kateqoriyada xərc tapılmadı',
          );
        }

        return ListView.separated(
          itemCount: expenses.length,
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemBuilder: (context, index) {
            final expense = expenses[index];
            return FadeSlideIn(
              index: index,
              child: ExpenseTile(
                expense: expense,
                onTap: () => onTileTap(context, expense),
              ),
            );
          },
        );
      },
    );
  }
}
