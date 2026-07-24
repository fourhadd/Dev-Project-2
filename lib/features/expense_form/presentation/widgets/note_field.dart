import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../cubit/expense_form_cubit.dart';

/// Validasiya olunmadığı (istəyə bağlı sahə) və heç bir state-dən asılı
/// olmadığı üçün bloc-a bağlanmır — yalnız controller-i oxuyur.
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
