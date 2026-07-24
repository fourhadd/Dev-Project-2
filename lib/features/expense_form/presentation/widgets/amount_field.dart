import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import 'package:expense_tracker/features/expense_form/presentation/cubit/expense_form_cubit.dart';

class AmountField extends StatelessWidget {
  const AmountField({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ExpenseFormCubit>();
    return BlocBuilder<ExpenseFormCubit, ExpenseFormState>(
      buildWhen: (previous, current) => previous.amountError != current.amountError,
      builder: (context, state) {
        return TextFormField(
          controller: cubit.amountController,
          style: TextStyle(fontSize: 14.sp, color: AppColor.textPrimary),
          decoration: InputDecoration(
            labelText: 'Məbləğ (₼)',
            errorText: state.amountError,
            border: const OutlineInputBorder(),
          ),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
        );
      },
    );
  }
}
