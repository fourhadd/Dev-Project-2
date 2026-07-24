import 'package:go_router/go_router.dart';

import '../../features/expense/data/models/expense_model.dart';
import '../../features/expense/presentation/pages/home_page.dart';
import '../../features/expense_form/presentation/pages/expense_form_page.dart';
import 'app_routes.dart';
import 'page_transitions.dart';

/// Tətbiqin bütün naviqasiyası bu router üzərindən idarə olunur.
/// Redaktə ediləcək `Expense` `extra` parametri kimi ötürülür.
final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.home,
  routes: [
    GoRoute(
      path: AppRoutes.home,
      name: AppRoutes.homeName,
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: AppRoutes.expenseForm,
      name: AppRoutes.expenseFormName,
      pageBuilder: (context, state) {
        final existing = state.extra as Expense?;
        return CustomTransitionPage(
          key: state.pageKey,
          transitionDuration: smoothTransitionDuration,
          reverseTransitionDuration: smoothReverseTransitionDuration,
          child: ExpenseFormPage(existing: existing),
          transitionsBuilder: buildSmoothTransition,
        );
      },
    ),
  ],
);
