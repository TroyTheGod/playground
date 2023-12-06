import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class _ZhCupertinoLocalDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const _ZhCupertinoLocalDelegate();
  @override
  bool isSupported(Locale locale) {
    return locale.languageCode == 'zh';
  }

  @override
  Future<CupertinoLocalizations> load(Locale locale) {
    return ZhCupertinoLocal.load(locale);
  }

  @override
  bool shouldReload(
      covariant LocalizationsDelegate<CupertinoLocalizations> old) {
    return false;
  }
}

class ZhCupertinoLocal implements CupertinoLocalizations {
  const ZhCupertinoLocal();

  static const List<String> _shortWeekdays = <String>[
    '周一',
    '周二',
    '周三',
    '周四',
    '周五',
    '周六',
    '周日'
  ];

  static const List<String> _shortMonths = <String>[
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];

  static const List<String> _months = <String>[
    '01月',
    '02月',
    '03月',
    '04月',
    '05月',
    '06月',
    '07月',
    '08月',
    '09月',
    '10月',
    '11月',
    '12月'
  ];

  @override
  String datePickerYear(int yearIndex) => "$yearIndex年";

  @override
  String datePickerMonth(int monthIndex) => _months[monthIndex - 1];

  @override
  String datePickerDayOfMonth(int dayIndex, [int? weekDay]) => "$dayIndex日";

  @override
  String datePickerHour(int hour) => hour.toString();

  @override
  String datePickerHourSemanticsLabel(int hour) => "$hour 小时";

  @override
  String datePickerMinute(int minute) => minute.toString().padLeft(2, '0');

  @override
  String datePickerMinuteSemanticsLabel(int minute) => '1 分钟';

  @override
  String datePickerMediumDate(DateTime date) {
    return '${_shortWeekdays[date.weekday - DateTime.monday]} '
        '${_shortMonths[date.month - DateTime.january]} '
        '${date.day.toString().padRight(2)}';
  }

  @override
  DatePickerDateOrder get datePickerDateOrder => DatePickerDateOrder.ymd;

  @override
  DatePickerDateTimeOrder get datePickerDateTimeOrder =>
      DatePickerDateTimeOrder.date_time_dayPeriod;

  @override
  String get anteMeridiemAbbreviation => 'AM';

  @override
  String get postMeridiemAbbreviation => 'PM';

  @override
  String get alertDialogLabel => '提示信息';

  @override
  String timerPickerHour(int hour) => hour.toString();

  @override
  String timerPickerMinute(int minute) => minute.toString();

  @override
  String timerPickerSecond(int second) => second.toString();

  @override
  String timerPickerHourLabel(int hour) => '时';

  @override
  String timerPickerMinuteLabel(int minute) => '分';

  @override
  String timerPickerSecondLabel(int second) => '秒';

  @override
  String get cutButtonLabel => '剪切';

  @override
  String get copyButtonLabel => '复制';

  @override
  String get pasteButtonLabel => '粘贴';

  @override
  String get selectAllButtonLabel => '全选';

  @override
  String get todayLabel => "今天";

  @override
  String get modalBarrierDismissLabel => "取消";

  @override
  String tabSemanticsLabel({required int tabIndex, required int tabCount}) =>
      "";

  @override
  String get searchTextFieldPlaceholderLabel => "";

  @override
  List<String> get timerPickerHourLabels => [];

  @override
  List<String> get timerPickerMinuteLabels => [];

  @override
  List<String> get timerPickerSecondLabels => [];

  @override
  String get noSpellCheckReplacementsLabel => "";

  @override
  String datePickerStandaloneMonth(int monthIndex) {
    return '$monthIndex月';
  }

  @override
  String get lookUpButtonLabel => '查找';

  @override
  String get menuDismissLabel => '关闭';

  @override
  String get searchWebButtonLabel => '搜索';

  @override
  String get shareButtonLabel => '分享';

  static Future<CupertinoLocalizations> load(Locale locale) {
    return SynchronousFuture<CupertinoLocalizations>(const ZhCupertinoLocal());
  }

  static const LocalizationsDelegate<CupertinoLocalizations> delegate =
      _ZhCupertinoLocalDelegate();
}
