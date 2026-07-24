import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';

class EmptyStateView extends StatelessWidget {
  final String message;
  const EmptyStateView({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.receipt_long_outlined, size: 72.r, color: AppColor.disabled),
          SizedBox(height: 16.h),
          Text(
            message,
            style: TextStyle(fontSize: 15.sp, color: AppColor.disabled),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4.h),
          Text(
            'Əlavə etmək üçün aşağıdakı + düyməsinə basın',
            style: TextStyle(fontSize: 12.sp, color: AppColor.disabled),
          ),
        ],
      ),
    );
  }
}
