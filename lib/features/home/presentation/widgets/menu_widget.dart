import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nosrah/features/ansar_magazine/presentation/pages/ansar_magazine_page.dart';
import 'package:nosrah/features/notification/domain/repositories/notification_repository.dart';
import 'package:nosrah/features/notification/infrastructure/repositories/notification_repository_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuWidget extends StatelessWidget {
  MenuWidget({
    Key? key,
  }) : super(key: key);

  final NotificationRepository notificationRepository =
      NotificationRepositoryImpl();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
            ),
            child: Image.asset(
              'assets/images/muhammad_peace_be_upon_him.png',
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(right: 10.w),
              child: TextButton(
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  DatePicker.showTime12hPicker(
                    context,
                    locale: LocaleType.ar,
                    showTitleActions: true,
                    theme: DatePickerTheme(
                      doneStyle:
                          Theme.of(context).textTheme.bodyLarge!.copyWith(
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                    ),
                    onConfirm: (date) async {
                      await notificationRepository.scheduleNotification(
                          time: date);

                      await prefs.setString(
                        'notification_time',
                        date.toString(),
                      );
                    },
                    currentTime: prefs.getString('notification_time') == null
                        ? DateTime.now()
                        : DateTime.parse(
                            prefs.getString('notification_time')!,
                          ),
                  );
                },
                child: Text(
                  'وقت التذكير اليومي بالنصرة',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ),
          ),
          Divider(
            color: Theme.of(context).colorScheme.secondary,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(right: 10.w),
              child: TextButton(
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AnsarMagazinePage(),
                    ),
                  );
                },
                child: Text(
                  'مجلة أنصار النبي ﷺ',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ),
          ),
          Divider(
            color: Theme.of(context).colorScheme.secondary,
          ),
        ],
      ),
    );
  }
}
