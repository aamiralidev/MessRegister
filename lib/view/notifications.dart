import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:mess_record_app/view/utilities.dart';

Future<void> createNotification() async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: createUniqueId(),
      channelKey: 'basic_channel',
      title: 'Did you had your meal',
    ),
    actionButtons: [
      NotificationActionButton(
        key: 'Mark Attendance',
        label: 'Mark Attendance',
      ),
    ],
  );
}

Future<void> scheduleNotification(NotificationWeekAndTime notificationSchedule,
    {int? id, String? mealName}) async {
  print(
      "scheduling notification at day ${notificationSchedule.dayOfTheWeek} hour ${notificationSchedule.timeOfDay.hour} and minute ${notificationSchedule.timeOfDay.minute}");
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: id ?? createUniqueId(),
      channelKey: 'basic_channel',
      title: 'Did you had ' + (mealName ?? 'meal'),
      notificationLayout: NotificationLayout.Default,
    ),
    actionButtons: [
      NotificationActionButton(
        key: 'MARK_DONE',
        label: 'Mark Attandance',
      ),
    ],
    schedule: NotificationCalendar(
      weekday: notificationSchedule.dayOfTheWeek,
      hour: notificationSchedule.timeOfDay.hour,
      minute: notificationSchedule.timeOfDay.minute,
      second: 0,
      millisecond: 0,
      repeats: true,
    ),
  );
}

Future<void> cancelScheduledNotifications() async {
  await AwesomeNotifications().cancelAllSchedules();
}

Future<void> cancelScheduledNotification(int id) async {
  await AwesomeNotifications().cancelSchedule(id);
}
