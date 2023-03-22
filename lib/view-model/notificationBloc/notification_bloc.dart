import 'dart:async';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web/Repository/notification_repository.dart';
import 'package:web/helper/utils/shared_pref.dart';
import 'package:web/helper/utils/utils.dart';
import 'package:web/models/notification/notification_model.dart';
import 'package:web/services/request_body.dart';
import 'package:web/view/shared_widget/custom_progress_indicator.dart';

part 'notification_event.dart';

part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationRepository notificationRepository;
  Dio? dio;

  NotificationBloc({required this.notificationRepository, this.dio}) : super(NotificationInitial()) {
    on<ViewNotificationsEvent>((event, emit) async {
      await _viewNotificationsEvent(event, emit);
    });
  }

  _viewNotificationsEvent(ViewNotificationsEvent event, Emitter<NotificationState> emit) async {
    emit(Loading());
    late BuildContext dialogContext; // global declaration
    Future.delayed(Duration.zero, () {
      return showDialog(
          context: event.context,
          builder: (context) {
            dialogContext = context;
            return const SizedBox(width: 50, height: 50, child: CustomProgressIndicator());
          });
    });

    try {
      int userId = await SharedPref.getInt(key: "user-id");
      Map req = RequestBody.notificationList(
        userId: userId,
      );

      NotificationModel? notifications = await notificationRepository.notifications(req, event.context);
      if (notifications!.success!) {
        Future.delayed(Duration.zero, () {
          Navigator.pop(dialogContext);
        });
        emit(ViewNotificationListState(notification: notifications));
      } else {
        Future.delayed(Duration.zero, () {
          Navigator.pop(dialogContext);
          checkStatus(event.context);
        });
        debugPrint("error");
      }
    } catch (e) {
      Future.delayed(Duration.zero, () {
        Navigator.pop(dialogContext);
        checkStatus(event.context);
      });
      debugPrint(e.toString());
    }
  }
}
