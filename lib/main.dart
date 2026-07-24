// main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';

import 'core/routes/app_router.dart';
import 'core/theme/app_colors.dart';
import 'package:expense_tracker/features/expense/presentation/cubit/expense_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) {
        return BlocProvider(
          create: (_) => ExpenseCubit(),
          child: MaterialApp.router(
            title: 'Xərc İzləyici',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              useMaterial3: true,
              colorSchemeSeed: AppColor.primary,
              scaffoldBackgroundColor: AppColor.background,
            ),
            routerConfig: appRouter,
          ),
        );
      },
    );
  }
}
