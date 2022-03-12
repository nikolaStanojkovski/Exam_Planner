import 'package:exam_planner/model/exam.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'date_utils.dart';

class NotificationApi {
  static const String notificationTitle = 'Exam Reminder';
  static const String notificationPayload = 'exam.reminder';
  static int notificationCounter = 0;

  static final _notifications = FlutterLocalNotificationsPlugin();

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

  static scheduleTimeNotifications(List<Exam> exams) {
    for (var element in exams) {
      scheduleNotification(element);
    }
  }

  static Future showLocationNotification(
      String subjectName, String distance) async {
    String notificationBody =
        'You are $distance close to the location of the exam for subject $subjectName';

    _notifications.show(
      notificationCounter++,
      notificationTitle,
      notificationBody,
      await _notificationDetails(),
      payload: notificationPayload,
    );
  }

  static void cancelNotifications() => _notifications.cancelAll();
}
