import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../cubit/expense_form_cubit.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ExpenseFormCubit>();
    return BlocBuilder<ExpenseFormCubit, ExpenseFormState>(
      buildWhen: (previous, current) => previous.isSubmitting != current.isSubmitting,
      builder: (context, state) {
        return FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: AppColor.primary,
            minimumSize: Size(double.infinity, 48.h),
          ),
          onPressed: state.isSubmitting ? null : cubit.submit,
          child: state.isSubmitting
              ? SizedBox(
                  height: 18.r,
                  width: 18.r,
                  child: const CircularProgressIndicator(strokeWidth: 2, color: AppColor.white),
                )
              : Text(
                  cubit.isEditing ? 'Yadda saxla' : 'Əlavə et',
                  style: TextStyle(fontSize: 14.sp, color: AppColor.white),
                ),
        );
      },
    );
  }
}
