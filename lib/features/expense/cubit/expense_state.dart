part of 'expense_cubit.dart';

class ExpenseState extends Equatable {
  final List<Expense> allExpenses;
  final ExpenseCategory? filterCategory;
  final SortType sortType;
  final bool isLoading;

  const ExpenseState({
    this.allExpenses = const [],
    this.filterCategory,
    this.sortType = SortType.dateDesc,
    this.isLoading = true,
  });

  List<Expense> get visibleExpenses {
    var list = allExpenses.where((e) {
      if (filterCategory == null) return true;
      return e.category == filterCategory;
    }).toList();

    switch (sortType) {
      case SortType.dateDesc:
        list.sort((a, b) => b.date.compareTo(a.date));
        break;
      case SortType.dateAsc:
        list.sort((a, b) => a.date.compareTo(b.date));
        break;
      case SortType.amountDesc:
        list.sort((a, b) => b.amount.compareTo(a.amount));
        break;
      case SortType.amountAsc:
        list.sort((a, b) => a.amount.compareTo(b.amount));
        break;
    }
    return list;
  }

  double get totalAmount => visibleExpenses.fold(0.0, (sum, e) => sum + e.amount);

  ExpenseState copyWith({
    List<Expense>? allExpenses,
    ExpenseCategory? filterCategory,
    bool clearFilter = false,
    SortType? sortType,
    bool? isLoading,
  }) {
    return ExpenseState(
      allExpenses: allExpenses ?? this.allExpenses,
      filterCategory: clearFilter ? null : (filterCategory ?? this.filterCategory),
      sortType: sortType ?? this.sortType,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [allExpenses, filterCategory, sortType, isLoading];
}
