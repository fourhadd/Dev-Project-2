import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:uuid/uuid.dart';

import '../../data/models/expense_model.dart';

part 'expense_state.dart';

class ExpenseCubit extends Cubit<ExpenseState> {
  final GetStorage _box = GetStorage();
  static const String _storageKey = 'expenses';
  static const _uuid = Uuid();

  ExpenseCubit() : super(const ExpenseState()) {
    _loadExpenses();
  }

  Future<void> _loadExpenses() async {
    emit(state.copyWith(isLoading: true));
    final raw = _box.read<List>(_storageKey) ?? [];
    final expenses = raw
        .map((e) => Expense.fromMap(Map<String, dynamic>.from(e as Map)))
        .toList();
    emit(state.copyWith(allExpenses: expenses, isLoading: false));
  }

  Future<void> _persist(List<Expense> expenses) async {
    await _box.write(_storageKey, expenses.map((e) => e.toMap()).toList());
  }

  Future<void> addExpense({
    required String title,
    required double amount,
    required ExpenseCategory category,
    required DateTime date,
    String? note,
  }) async {
    final newExpense = Expense(
      id: _uuid.v4(),
      title: title,
      amount: amount,
      category: category,
      date: date,
      note: note,
    );
    final updated = [...state.allExpenses, newExpense];
    await _persist(updated);
    emit(state.copyWith(allExpenses: updated));
  }

  Future<void> updateExpense(Expense updatedExpense) async {
    final updated = state.allExpenses
        .map((e) => e.id == updatedExpense.id ? updatedExpense : e)
        .toList();
    await _persist(updated);
    emit(state.copyWith(allExpenses: updated));
  }

  Future<void> deleteExpense(String id) async {
    final updated = state.allExpenses.where((e) => e.id != id).toList();
    await _persist(updated);
    emit(state.copyWith(allExpenses: updated));
  }

  void filterByCategory(ExpenseCategory? category) {
    if (category == null) {
      emit(state.copyWith(clearFilter: true));
    } else {
      emit(state.copyWith(filterCategory: category));
    }
  }

  void changeSort(SortType type) {
    emit(state.copyWith(sortType: type));
  }
}
