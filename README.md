# Xərc İzləyici — Flutter (Cubit + GetStorage)

Qeydlər/Xərc izləmə ekranlarını əhatə edən, lokal state və lokal saxlama
əsaslı Flutter tətbiqi. Fokus CRUD, filtrasiya/sıralama və state
idarəetməsindədir.

## Ekran görüntüləri

| | | |
|---|---|---|
| ![](screenshots/Simulator%20Screenshot%20-%20iPhone%2017%20Pro%20Max%20-%202026-07-24%20at%2013.59.01.png) | ![](screenshots/Simulator%20Screenshot%20-%20iPhone%2017%20Pro%20Max%20-%202026-07-24%20at%2013.59.04.png) | ![](screenshots/Simulator%20Screenshot%20-%20iPhone%2017%20Pro%20Max%20-%202026-07-24%20at%2014.00.04.png) |
| Boş vəziyyət (ilkin ekran) | Yeni xərc formu (boş) | Yeni xərc formu (doldurulmuş) |
| ![](screenshots/Simulator%20Screenshot%20-%20iPhone%2017%20Pro%20Max%20-%202026-07-24%20at%2014.00.06.png) | ![](screenshots/Simulator%20Screenshot%20-%20iPhone%2017%20Pro%20Max%20-%202026-07-24%20at%2014.01.43.png) | ![](screenshots/Simulator%20Screenshot%20-%20iPhone%2017%20Pro%20Max%20-%202026-07-24%20at%2014.01.45.png) |
| Əlavə olunandan sonra siyahı | Bir neçə xərc, "Hamısı" filtri | "Yemək" kateqoriyası üzrə filtr |
| ![](screenshots/Simulator%20Screenshot%20-%20iPhone%2017%20Pro%20Max%20-%202026-07-24%20at%2014.01.47.png) | ![](screenshots/Simulator%20Screenshot%20-%20iPhone%2017%20Pro%20Max%20-%202026-07-24%20at%2014.01.50.png) | ![](screenshots/Simulator%20Screenshot%20-%20iPhone%2017%20Pro%20Max%20-%202026-07-24%20at%2014.01.57.png) |
| "Əyləncə" kateqoriyası üzrə filtr | "Sağlamlıq" kateqoriyası üzrə filtr | "Nəqliyyat" filtri — boş nəticə |
| ![](screenshots/Simulator%20Screenshot%20-%20iPhone%2017%20Pro%20Max%20-%202026-07-24%20at%2014.01.59.png) | ![](screenshots/Simulator%20Screenshot%20-%20iPhone%2017%20Pro%20Max%20-%202026-07-24%20at%2014.02.07.png) | |
| Sıralama menyusu (tarix/məbləğ) | Swipe-to-delete (sürüşdürmə) | |

## Quraşdırma

```bash
flutter pub get
flutter run
```

## İstifadə olunan paketlər

| Paket | Məqsəd |
|---|---|
| `flutter_bloc` + `equatable` | State management (Cubit) |
| `get_storage` | Lokal verilənlər bazası (key-value, xərclərin saxlanması) |
| `go_router` | Ekranlar arası naviqasiya |
| `flutter_screenutil` | Responsiv ölçülər (`.w .h .sp .r`) |
| `uuid` | Hər xərc üçün unikal ID |
| `intl` | Tarix və valyuta formatlaşdırması |

## Struktur (feature-first)

```
lib/
  main.dart                             # ScreenUtilInit + GetStorage.init + BlocProvider
  core/
    theme/
      app_colors.dart                   # AppColor
    routes/
      app_routes.dart                   # Route adları/path-ləri (sabitlər)
      app_router.dart                   # GoRouter konfiqurasiyası
      page_transitions.dart             # CustomTransitionPage (slide + fade)
  features/
    expense/
      data/
        models/
          expense_model.dart            # Expense, ExpenseCategory, SortType
      cubit/
        expense_cubit.dart              # CRUD + GetStorage
        expense_state.dart              # filtrasiya/sıralama + total
      presentation/
        pages/
          home_page.dart
        widgets/
          category_filter_bar.dart
          sort_menu_button.dart
          total_summary_bar.dart
          expense_list_view.dart
          expense_tile.dart
          fade_slide_in.dart
          empty_state_view.dart
          delete_confirm_dialog.dart
    expense_form/
      cubit/
        expense_form_cubit.dart         # controller-lər + validasiya + submit
        expense_form_state.dart
      presentation/
        pages/
          expense_form_page.dart
        widgets/
          title_field.dart
          amount_field.dart
          category_dropdown_field.dart
          date_picker_field.dart
          note_field.dart
          submit_button.dart
```

Hər feature daxilində:
- **data/** — modellər (`Expense`, `ExpenseCategory`, `SortType`)
- **cubit/** — state idarəetməsi (CRUD, filtrasiya, sıralama, form validasiyası)
- **presentation/** — `pages` (ekranlar), `widgets` (yenidən istifadə olunan komponentlər)

## Qeydlər

- Bütün page-lər `StatelessWidget`, state Cubit-də saxlanılır. Form
  sahələrinin `TextEditingController`-ləri, seçilmiş kateqoriya/tarix və
  xəta mesajları `ExpenseFormCubit` daxilində saxlanılır — page özü heç
  bir state saxlamır.
- Rənglər yalnız `AppColor` sinfindən (`core/theme/app_colors.dart`)
  istifadə olunur, heç yerdə hardcoded `Color(...)` yoxdur.
- Hər `BlocBuilder` `buildWhen` ilə yalnız özünə aid state sahəsi
  dəyişəndə rebuild olur (məs. `TitleField` yalnız `titleError`,
  `TotalSummaryBar` yalnız `totalAmount` dəyişəndə).
- **go_router**: bütün naviqasiya `core/routes/app_router.dart`-dakı
  `appRouter` üzərindən idarə olunur. Route adları/path-ləri
  `core/routes/app_routes.dart`-da sabit saxlanılır (`AppRoutes.home`,
  `AppRoutes.expenseFormName`) — hardcoded string yoxdur. `HomePage`
  `context.pushNamed(..., extra: existing)`, `ExpenseFormPage` isə uğurlu
  submit-dən sonra `context.pop()` istifadə edir.
- Səhifə keçidi (`CustomTransitionPage` + `buildSmoothTransition`) və
  siyahı elementləri (`FadeSlideIn`) yumşaq fade/slide animasiyaları ilə
  göstərilir.
- Silmədən əvvəl `AlertDialog` təsdiqi + swipe-to-delete (`Dismissible`).
- Async gap qoruması: `showDatePicker` və verilənlər bazası çağırışlarından
  sonra `BuildContext` istifadəsindən əvvəl `mounted`/state yoxlaması edilib.

## Əskik olan / qərar tələb edən məqamlar

1. **AppColor sinfi sıfırdan yaradılıb** — dəqiq brend/dizayn-sistem hex
   kodları verilmədiyi üçün Material indigo əsaslı defolt palitra seçilib.
2. Route arqumentlərində tip-safe generasiya (`go_router_builder`/code-gen)
   istifadə olunmayıb — `Expense` obyekti sadəcə `extra` parametri kimi
   ötürülür (path parametrləri/deep-link dəstəyi yoxdur).
3. Kateqoriya üzrə fərqli rəng/ikon sxemi tələb olunmadığı üçün sadə
   hərf-avatar (`CircleAvatar` + ilk hərf) saxlanılıb.
4. Real backend/API inteqrasiyası yoxdur — bütün data `GetStorage` ilə
   yalnız lokal saxlanılır.
5. Silmə təsdiq dialoqunun (`AlertDialog`) ekran görüntüsü fayl olaraq
   göndərilmədiyi üçün README-də yoxdur — istəsən `screenshots/` qovluğuna
   əlavə edib cədvələ yeni sətir kimi qoşa bilərsən.
# Dev-Project-2
