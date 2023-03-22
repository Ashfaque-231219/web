part of 'notification_bloc.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();
  @override
  List<Object?> get props => [];
}

class ViewNotificationsEvent extends NotificationEvent {
  final BuildContext context;

  const ViewNotificationsEvent({
    required this.context,
  });
}