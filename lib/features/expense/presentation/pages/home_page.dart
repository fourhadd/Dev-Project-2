// features/expense/presentation/pages/home_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routes/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../data/models/expense_model.dart';
import '../cubit/expense_cubit.dart';
import '../widgets/category_filter_bar.dart';
import '../widgets/expense_list_view.dart';
import '../widgets/sort_menu_button.dart';
import '../widgets/total_summary_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _openForm(BuildContext context, {Expense? existing}) {
    context.pushNamed(AppRoutes.expenseFormName, extra: existing);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ExpenseCubit, ExpenseState>(
      listenWhen: (previous, current) =>
          current.skippedCount > 0 &&
          current.skippedCount != previous.skippedCount,
      listener: (context, state) {
        final count = state.skippedCount;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              count == 1
                  ? '1 xərc bərpa oluna bilmədi'
                  : '$count xərc bərpa oluna bilmədi',
            ),
            duration: const Duration(seconds: 4),
          ),
        );

        context.read<ExpenseCubit>().acknowledgeSkippedEntries();
      },
      child: Scaffold(
        backgroundColor: AppColor.background,
        appBar: AppBar(
          title: const Text('Xərc İzləyici'),
          backgroundColor: AppColor.primary,
          foregroundColor: AppColor.white,
          actions: const [SortMenuButton()],
        ),
        body: Column(
          children: [
            const CategoryFilterBar(),
            const TotalSummaryBar(),
            Expanded(
              child: ExpenseListView(
                onTileTap: (ctx, expense) =>
                    _openForm(ctx, existing: expense as Expense),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColor.primary,
          onPressed: () => _openForm(context),
          child: const Icon(Icons.add, color: AppColor.white),
        ),
      ),
    );
  }
}
