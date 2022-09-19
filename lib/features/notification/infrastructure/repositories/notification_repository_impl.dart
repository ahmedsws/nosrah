import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:nosrah/features/notification/domain/repositories/notification_repository.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationRepositoryImpl implements NotificationRepository {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  @override
  Future<void> scheduleNotification({
    DateTime? time,
  }) async {
    await configureLocalTimeZone();

    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'هل نصرت نبيك اليوم؟',
      'لإن فاتك شرف الصحبة، فلا يفوتنك شرف النصرة!',
      time != null
          ? tz.TZDateTime(
              tz.local, 2022, DateTime.april, 29, time.hour, time.minute)
          : tz.TZDateTime(tz.local, 2022, DateTime.april, 29, 18, 0),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'Channel ID',
          'Nosrah channel',
          channelDescription: 'your channel description',
          importance: Importance.max,
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  @override
  Future<void> configureLocalTimeZone() async {
    if (kIsWeb || Platform.isLinux) {
      return;
    }
    tz.initializeTimeZones();
    final String? timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName!));
  }
}
