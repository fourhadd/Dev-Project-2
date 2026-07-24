// features/expense_form/presentation/widgets/date_picker_field.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../cubit/expense_form_cubit.dart';

class DatePickerField extends StatelessWidget {
  const DatePickerField({super.key});

  Future<void> _pickDate(BuildContext context, DateTime current) async {
    final cubit = context.read<ExpenseFormCubit>();
    final picked = await showDatePicker(
      context: context,
      initialDate: current,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      cubit.changeDate(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseFormCubit, ExpenseFormState>(
      buildWhen: (previous, current) => previous.date != current.date,
      builder: (context, state) {
        return ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(
            'Tarix',
            style: TextStyle(fontSize: 14.sp, color: AppColor.textPrimary),
          ),
          subtitle: Text(
            '${state.date.day}.${state.date.month}.${state.date.year}',
            style: TextStyle(fontSize: 13.sp, color: AppColor.textSecondary),
          ),
          trailing: Icon(
            Icons.calendar_today,
            size: 20.r,
            color: AppColor.primary,
          ),
          onTap: () => _pickDate(context, state.date),
        );
      },
    );
  }
}
