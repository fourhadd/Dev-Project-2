// features/expense_form/presentation/widgets/note_field.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import 'package:expense_tracker/features/expense_form/presentation/cubit/expense_form_cubit.dart';

class NoteField extends StatelessWidget {
  const NoteField({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ExpenseFormCubit>();
    return TextFormField(
      controller: cubit.noteController,
      style: TextStyle(fontSize: 14.sp, color: AppColor.textPrimary),
      decoration: const InputDecoration(
        labelText: 'Qeyd (istəyə bağlı)',
        border: OutlineInputBorder(),
      ),
      maxLines: 3,
    );
  }
}
