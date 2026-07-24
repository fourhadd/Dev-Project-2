import 'package:equatable/equatable.dart';

enum ExpenseCategory { food, transport, entertainment, bills, health, shopping, other }

extension ExpenseCategoryX on ExpenseCategory {
  String get label {
    switch (this) {
      case ExpenseCategory.food:
        return 'Yemək';
      case ExpenseCategory.transport:
        return 'Nəqliyyat';
      case ExpenseCategory.entertainment:
        return 'Əyləncə';
      case ExpenseCategory.bills:
        return 'Hesablar';
      case ExpenseCategory.health:
        return 'Sağlamlıq';
      case ExpenseCategory.shopping:
        return 'Alış-veriş';
      case ExpenseCategory.other:
        return 'Digər';
    }
  }
}

enum SortType { dateDesc, dateAsc, amountDesc, amountAsc }

class Expense extends Equatable {
  final String id;
  final String title;
  final double amount;
  final ExpenseCategory category;
  final DateTime date;
  final String? note;

  const Expense({
    required this.id,
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
    this.note,
  });

  Expense copyWith({
    String? title,
    double? amount,
    ExpenseCategory? category,
    DateTime? date,
    String? note,
  }) {
    return Expense(
      id: id,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      category: category ?? this.category,
      date: date ?? this.date,
      note: note ?? this.note,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'category': category.name,
      'date': date.toIso8601String(),
      'note': note,
    };
  }

  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map['id'] as String,
      title: map['title'] as String,
      amount: (map['amount'] as num).toDouble(),
      category: ExpenseCategory.values.firstWhere(
        (e) => e.name == map['category'],
        orElse: () => ExpenseCategory.other,
      ),
      date: DateTime.parse(map['date'] as String),
      note: map['note'] as String?,
    );
  }

  @override
  List<Object?> get props => [id, title, amount, category, date, note];
}
