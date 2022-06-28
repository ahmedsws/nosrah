abstract class NotificationRepository {
  Future<void> scheduleNotification({DateTime? time});

  Future<void> configureLocalTimeZone();
}
