import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import 'package:expense_tracker/features/expense/presentation/cubit/expense_cubit.dart';
import '../../data/models/expense_model.dart';
import 'delete_confirm_dialog.dart';

class ExpenseTile extends StatelessWidget {
  final Expense expense;
  final VoidCallback onTap;

  const ExpenseTile({super.key, required this.expense, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final currency = NumberFormat.currency(locale: 'az_AZ', symbol: '₼');
    final cubit = context.read<ExpenseCubit>();

    return Dismissible(
      key: ValueKey(expense.id),
      direction: DismissDirection.endToStart,
      confirmDismiss: (_) => showDeleteConfirmDialog(context, expense.title),
      onDismissed: (_) => cubit.deleteExpense(expense.id),
      background: Container(
        color: AppColor.danger,
        alignment: Alignment.centerRight,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Icon(Icons.delete, color: AppColor.white, size: 22.r),
      ),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: AppColor.primaryLight,
          child: Text(expense.category.label[0], style: const TextStyle(color: AppColor.primary)),
        ),
        title: Text(expense.title,
            maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 14.sp)),
        subtitle: Text(
          '${expense.category.label} • ${DateFormat('dd.MM.yyyy').format(expense.date)}',
          style: TextStyle(fontSize: 12.sp, color: AppColor.textSecondary),
        ),
        trailing: Text(
          currency.format(expense.amount),
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp, color: AppColor.textPrimary),
        ),
      ),
    );
  }
}
