import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routes/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../data/models/expense_model.dart';
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
    return Scaffold(
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
              onTileTap: (ctx, expense) => _openForm(ctx, existing: expense as Expense),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.primary,
        onPressed: () => _openForm(context),
        child: const Icon(Icons.add, color: AppColor.white),
      ),
    );
  }
}
