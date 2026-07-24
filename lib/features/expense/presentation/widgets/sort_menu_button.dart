// features/expense/presentation/widgets/sort_menu_button.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../cubit/expense_cubit.dart';
import '../../data/models/expense_model.dart';

class SortMenuButton extends StatelessWidget {
  const SortMenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<SortType>(
      icon: const Icon(Icons.sort, color: AppColor.white),
      onSelected: (type) => context.read<ExpenseCubit>().changeSort(type),
      itemBuilder: (_) => const [
        PopupMenuItem(
          value: SortType.dateDesc,
          child: Text('Tarix (yeni → köhnə)'),
        ),
        PopupMenuItem(
          value: SortType.dateAsc,
          child: Text('Tarix (köhnə → yeni)'),
        ),
        PopupMenuItem(
          value: SortType.amountDesc,
          child: Text('Məbləğ (böyük → kiçik)'),
        ),
        PopupMenuItem(
          value: SortType.amountAsc,
          child: Text('Məbləğ (kiçik → böyük)'),
        ),
      ],
    );
  }
}
