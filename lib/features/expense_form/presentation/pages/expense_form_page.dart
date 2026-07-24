import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../expense/cubit/expense_cubit.dart';
import '../../../expense/data/models/expense_model.dart';
import '../../cubit/expense_form_cubit.dart';
import '../widgets/amount_field.dart';
import '../widgets/category_dropdown_field.dart';
import '../widgets/date_picker_field.dart';
import '../widgets/note_field.dart';
import '../widgets/submit_button.dart';
import '../widgets/title_field.dart';

class ExpenseFormPage extends StatelessWidget {
  final Expense? existing;

  const ExpenseFormPage({super.key, this.existing});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ExpenseFormCubit(
        expenseCubit: context.read<ExpenseCubit>(),
        existing: existing,
      ),
      child: const _ExpenseFormView(),
    );
  }
}

class _ExpenseFormView extends StatelessWidget {
  const _ExpenseFormView();

  @override
  Widget build(BuildContext context) {
    final isEditing = context.read<ExpenseFormCubit>().isEditing;

    return BlocListener<ExpenseFormCubit, ExpenseFormState>(
      listenWhen: (previous, current) => !previous.success && current.success,
      listener: (context, state) => context.pop(),
      child: Scaffold(
        backgroundColor: AppColor.background,
        appBar: AppBar(
          title: Text(isEditing ? 'Xərci redaktə et' : 'Yeni xərc'),
          backgroundColor: AppColor.primary,
          foregroundColor: AppColor.white,
        ),
        body: ListView(
          padding: EdgeInsets.all(16.w),
          children: [
            const TitleField(),
            SizedBox(height: 16.h),
            const AmountField(),
            SizedBox(height: 16.h),
            const CategoryDropdownField(),
            SizedBox(height: 16.h),
            const DatePickerField(),
            SizedBox(height: 16.h),
            const NoteField(),
            SizedBox(height: 24.h),
            const SubmitButton(),
          ],
        ),
      ),
    );
  }
}
