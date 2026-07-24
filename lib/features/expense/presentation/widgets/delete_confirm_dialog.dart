import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

Future<bool> showDeleteConfirmDialog(BuildContext context, String expenseTitle) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('Silinsin?'),
      content: Text(
          '"$expenseTitle" xərcini silmək istədiyinizə əminsiniz? Bu əməliyyat geri qaytarıla bilməz.'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(ctx).pop(false),
          child: const Text('İmtina'),
        ),
        FilledButton.tonal(
          style: FilledButton.styleFrom(foregroundColor: AppColor.danger),
          onPressed: () => Navigator.of(ctx).pop(true),
          child: const Text('Sil'),
        ),
      ],
    ),
  );
  return result ?? false;
}
