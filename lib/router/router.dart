import 'package:go_router/go_router.dart';
import 'package:playground/cupertino_date_range_picker.dart/cupertino_date_range_picker.dart';
import 'package:playground/eat_what_ho/eat_what_ho.dart';
import 'package:playground/main.dart';
import 'package:playground/scroll_view/scroll_view.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) =>
          const MyHomePage(title: 'Flutter Demo Home Page'),
      routes: [
        GoRoute(
          path: 'scrollView',
          builder: (context, state) => const NScrollView(),
        ),
        GoRoute(
          path: 'eatWhatHo',
          builder: (context, state) => EatWhatHo(
            spinnerType:
                int.tryParse(state.uri.queryParameters['spinnerType'] ?? ''),
          ),
        ),
        GoRoute(
          path: 'datePicker',
          builder: (context, state) => const CupertinoDateRangePicker(),
        ),
      ],
    ),
  ],
);
