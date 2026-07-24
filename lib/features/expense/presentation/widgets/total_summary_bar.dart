import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../cubit/expense_cubit.dart';

class TotalSummaryBar extends StatelessWidget {
  const TotalSummaryBar({super.key});

  @override
  Widget build(BuildContext context) {
    final currency = NumberFormat.currency(locale: 'az_AZ', symbol: '₼');

    return BlocBuilder<ExpenseCubit, ExpenseState>(
      buildWhen: (previous, current) => previous.totalAmount != current.totalAmount,
      builder: (context, state) {
        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          color: AppColor.surfaceVariant,
          child: Text(
            'Cəmi: ${currency.format(state.totalAmount)}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.sp,
              color: AppColor.textPrimary,
            ),
          ),
        );
      },
    );
  }
}
