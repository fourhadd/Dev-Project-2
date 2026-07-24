import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../expense/data/models/expense_model.dart';
import '../../cubit/expense_form_cubit.dart';

class CategoryDropdownField extends StatelessWidget {
  const CategoryDropdownField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseFormCubit, ExpenseFormState>(
      buildWhen: (previous, current) => previous.category != current.category,
      builder: (context, state) {
        return DropdownButtonFormField<ExpenseCategory>(
          value: state.category,
          style: TextStyle(fontSize: 14.sp, color: AppColor.textPrimary),
          decoration: const InputDecoration(
            labelText: 'Kateqoriya',
            border: OutlineInputBorder(),
          ),
          items: ExpenseCategory.values
              .map((c) => DropdownMenuItem(value: c, child: Text(c.label)))
              .toList(),
          onChanged: (value) {
            if (value != null) context.read<ExpenseFormCubit>().changeCategory(value);
          },
        );
      },
    );
  }
}
