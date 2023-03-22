part of 'notification_bloc.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();
  @override
  List<Object?> get props => [];
}

class NotificationInitial extends NotificationState {}

class Loading extends NotificationState {}

class ViewNotificationListState extends NotificationState {
  final NotificationModel? notification;

  const ViewNotificationListState({this.notification});

  ViewNotificationListState copyWith({
    final NotificationModel? notification,
  }) {
    return ViewNotificationListState(notification: notification ?? this.notification);
  }

  @override
  String toString() {
    return "State{notification:$notification}";
  }
}
