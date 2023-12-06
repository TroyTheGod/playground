import 'package:flutter/Cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:playground/cupertino_date_range_picker.dart/custom_date_picker.dart';
import 'package:playground/local/zh_cupertino_local.dart';

class CupertinoDateRangePicker extends StatefulWidget {
  const CupertinoDateRangePicker({Key? key}) : super(key: key);

  @override
  State<CupertinoDateRangePicker> createState() =>
      _CupertinoDateRangePickerState();
}

class _CupertinoDateRangePickerState extends State<CupertinoDateRangePicker> {
  late CustomDatePickerController controller;

  @override
  void initState() {
    super.initState();
    controller = CustomDatePickerController(
      minimumDate: DateTime(1900),
      maximumDate: DateTime(2100),
      initialDateTime: DateTime.now(),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CupertinoNavigationBar(
        middle: Text('Date Range Picker(Cupertino)'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            height: 250.0,
            width: MediaQuery.of(context).size.width - 40.0,
            child: CustomDatePicker(
              controller: controller,
              onDateTimeChange: (newDate) {
                print(newDate);
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              controller.animatedToDate(
                DateTime(2023, 10, 8),
              );
            },
            child: const Text('date animated'),
          ),
          const SizedBox(
            height: 50.0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Spacer(),
                Text('取消'),
                Spacer(flex: 5),
                Text('选择时间'),
                Spacer(flex: 5),
                Text('确定'),
                Spacer(),
              ],
            ),
          ),
          const SizedBox(
            height: 50.0,
            width: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Spacer(),
                Text('2022.12.12'),
                Spacer(),
                Text('至'),
                Spacer(),
                Text('2022.12.13'),
                Spacer(),
              ],
            ),
          ),
          SizedBox(
            height: 250.0,
            width: double.infinity,
            child: Localizations(
              locale: const Locale('zh'),
              delegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                DefaultCupertinoLocalizations.delegate,
                ZhCupertinoLocal.delegate,
              ],
              child: Row(
                children: [
                  const SizedBox(width: 12.0),
                  Expanded(
                    child: CupertinoTheme(
                      data: const CupertinoThemeData(
                        textTheme: CupertinoTextThemeData(
                          dateTimePickerTextStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                      child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.date,
                        itemExtent: 50,
                        onDateTimeChanged: (dateTime) {},
                      ),
                    ),
                  ),
                  const SizedBox(width: 12.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
