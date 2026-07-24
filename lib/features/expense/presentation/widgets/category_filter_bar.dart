import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import 'package:expense_tracker/features/expense/presentation/cubit/expense_cubit.dart';
import '../../data/models/expense_model.dart';

class CategoryFilterBar extends StatelessWidget {
  const CategoryFilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48.h,
      child: BlocBuilder<ExpenseCubit, ExpenseState>(
        buildWhen: (previous, current) =>
            previous.filterCategory != current.filterCategory,
        builder: (context, state) {
          return ListView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
            children: [
              _FilterChip(
                label: 'Hamısı',
                selected: state.filterCategory == null,
                onTap: () => context.read<ExpenseCubit>().filterByCategory(null),
              ),
              ...ExpenseCategory.values.map(
                (c) => _FilterChip(
                  label: c.label,
                  selected: state.filterCategory == c,
                  onTap: () => context.read<ExpenseCubit>().filterByCategory(c),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _FilterChip({required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: ChoiceChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) => onTap(),
        selectedColor: AppColor.chipSelectedBg,
        backgroundColor: AppColor.chipUnselectedBg,
        labelStyle: TextStyle(
          fontSize: 13.sp,
          color: selected ? AppColor.chipSelectedText : AppColor.chipUnselectedText,
        ),
      ),
    );
  }
}
