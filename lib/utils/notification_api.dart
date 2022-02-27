import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:lab_03/model/exam.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

import 'date_utils.dart';

class NotificationApi {
  static final _notifications = FlutterLocalNotificationsPlugin();
  static int notificationCounter = 0;

  static Future _notificationDetails() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'channel id',
        'channel name',
        channelDescription: 'channel description',
        importance: Importance.max,
        playSound: true,
        ongoing: true,
        styleInformation: BigTextStyleInformation(''),
      ),
      iOS: IOSNotificationDetails(),
    );
  }

  static init() {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = IOSInitializationSettings();
    const settings = InitializationSettings(android: android, iOS: ios);

    _notifications.initialize(settings);
    tz.initializeTimeZones();
  }

  static Future _showScheduledNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
    required DateTime scheduledDate,
  }) async {
    if (DateTime.now().isBefore(scheduledDate) ||
        DateTime.now().isAtSameMomentAs(scheduledDate)) {
      _notifications.zonedSchedule(
          id,
          title,
          body,
          tz.TZDateTime.from(
            scheduledDate,
            tz.local,
          ),
          await _notificationDetails(),
          payload: payload,
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime);
    }
  }

  static scheduleNotification(Exam exam) {
    DateTime examDate = DateTimeUtils.createDateTime(exam.date);
    String notificationTitle = 'Exam Reminder';
    String notificationPayload = 'exam.reminder';

    _showScheduledNotification(
      id: notificationCounter++,
        title: notificationTitle,
        body:
            'An exam is starting in 30 minutes for the subject ${exam.subjectName}, which will last ${exam.time}',
        payload: notificationPayload,
        scheduledDate: examDate.subtract(const Duration(minutes: 30)));
    _showScheduledNotification(
      id: notificationCounter++,
        title: notificationTitle,
        body:
            'An exam is starting in 5 minutes for the subject ${exam.subjectName}, which will last ${exam.time}',
        payload: notificationPayload,
        scheduledDate: examDate.subtract(const Duration(minutes: 5)));
    _showScheduledNotification(
      id: notificationCounter++,
        title: notificationTitle,
        body:
            'Ann exam starting right now for the subject ${exam.subjectName}, which will last ${exam.time}',
        payload: notificationPayload,
        scheduledDate: examDate);
    _showScheduledNotification(
      id: notificationCounter++,
        title: notificationTitle,
        body:
            'An exam just finished for the subject ${exam.subjectName}, which lasted ${exam.time}',
        payload: notificationPayload,
        scheduledDate: examDate.add(Duration(
            hours: int.parse(exam.time.split(":")[0]),
            minutes: int.parse(exam.time.split(":")[1]))));
  }

  static scheduleNotifications(List<Exam> exams) {
    for (var element in exams) {
      scheduleNotification(element);
    }
  }

  static void cancelNotifications() => _notifications.cancelAll();
}
