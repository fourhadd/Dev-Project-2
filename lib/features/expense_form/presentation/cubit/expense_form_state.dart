part of 'expense_form_cubit.dart';

class ExpenseFormState extends Equatable {
  final ExpenseCategory category;
  final DateTime date;
  final String? titleError;
  final String? amountError;
  final bool isSubmitting;
  final bool success;

  const ExpenseFormState({
    required this.category,
    required this.date,
    this.titleError,
    this.amountError,
    this.isSubmitting = false,
    this.success = false,
  });

  ExpenseFormState copyWith({
    ExpenseCategory? category,
    DateTime? date,
    String? titleError,
    bool clearTitleError = false,
    String? amountError,
    bool clearAmountError = false,
    bool? isSubmitting,
    bool? success,
  }) {
    return ExpenseFormState(
      category: category ?? this.category,
      date: date ?? this.date,
      titleError: clearTitleError ? null : (titleError ?? this.titleError),
      amountError: clearAmountError ? null : (amountError ?? this.amountError),
      isSubmitting: isSubmitting ?? this.isSubmitting,
      success: success ?? this.success,
    );
  }

  @override
  List<Object?> get props =>
      [category, date, titleError, amountError, isSubmitting, success];
}
