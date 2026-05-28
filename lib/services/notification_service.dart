import 'package:flutter/foundation.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  Future<void> init() async {
    debugPrint('NotificationService initialized (web-safe no-op mode).');
  }

  Future<void> showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async {
    debugPrint('NotificationService.showNotification(id: $id, title: $title, body: $body, payload: $payload)');
  }

  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
  }) async {
    debugPrint('NotificationService.scheduleNotification(id: $id, title: $title, body: $body, scheduledDate: $scheduledDate)');
  }

  Future<void> cancelAll() async {
    debugPrint('NotificationService.cancelAll()');
  }
}
