// features/expense_form/presentation/cubit/expense_form_cubit.dart
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../expense/cubit/expense_cubit.dart';
import '../../expense/data/models/expense_model.dart';

part 'expense_form_state.dart';

class ExpenseFormCubit extends Cubit<ExpenseFormState> {
  final ExpenseCubit _expenseCubit;
  final Expense? existing;

  late final TextEditingController titleController;
  late final TextEditingController amountController;
  late final TextEditingController noteController;

  bool get isEditing => existing != null;

  ExpenseFormCubit({required ExpenseCubit expenseCubit, this.existing})
    : _expenseCubit = expenseCubit,
      super(
        ExpenseFormState(
          category: existing?.category ?? ExpenseCategory.other,
          date: existing?.date ?? DateTime.now(),
        ),
      ) {
    titleController = TextEditingController(text: existing?.title ?? '');
    amountController = TextEditingController(
      text: existing != null ? existing!.amount.toString() : '',
    );
    noteController = TextEditingController(text: existing?.note ?? '');
  }

  void changeCategory(ExpenseCategory category) {
    emit(state.copyWith(category: category));
  }

  void changeDate(DateTime date) {
    emit(state.copyWith(date: date));
  }

  Future<void> submit() async {
    final title = titleController.text.trim();
    final amountText = amountController.text.trim();
    final amount = double.tryParse(amountText);

    String? titleError;
    String? amountError;

    if (title.isEmpty) titleError = 'Başlıq boş ola bilməz';

    if (amountText.isEmpty) {
      amountError = 'Məbləğ boş ola bilməz';
    } else if (amount == null) {
      amountError = 'Düzgün rəqəm daxil edin (məs: 12.50)';
    } else if (amount <= 0) {
      amountError = 'Məbləğ 0-dan böyük olmalıdır';
    }

    if (titleError != null || amountError != null) {
      emit(
        state.copyWith(
          titleError: titleError,
          clearTitleError: titleError == null,
          amountError: amountError,
          clearAmountError: amountError == null,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        isSubmitting: true,
        clearTitleError: true,
        clearAmountError: true,
      ),
    );

    final note = noteController.text.trim();
    if (isEditing) {
      await _expenseCubit.updateExpense(
        existing!.copyWith(
          title: title,
          amount: amount,
          category: state.category,
          date: state.date,
          note: note.isEmpty ? null : note,
        ),
      );
    } else {
      await _expenseCubit.addExpense(
        title: title,
        amount: amount!,
        category: state.category,
        date: state.date,
        note: note.isEmpty ? null : note,
      );
    }

    emit(state.copyWith(isSubmitting: false, success: true));
  }

  @override
  Future<void> close() {
    titleController.dispose();
    amountController.dispose();
    noteController.dispose();
    return super.close();
  }
}
