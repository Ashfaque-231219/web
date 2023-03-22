import 'package:flutter/material.dart';

abstract class NotificationRepository {
  Future notifications(Map req, BuildContext context);
}
