part of 'maintenance_bloc.dart';

abstract class MaintenanceEvent {
  MaintenanceEvent();

  List<Object?> get props => [];
}

class AddMaintenanceEvent extends MaintenanceEvent {
  final BuildContext? context;
  final String? projectId;
  final String? maintenanceId;
  final String? beforeImage;
  final String? beforeDescription;
  final bool? videoType;

  AddMaintenanceEvent({
    this.context,
    this.projectId = '',
    this.maintenanceId = '',
    this.beforeDescription = '',
    this.beforeImage = '',
    this.videoType = false,
  });
}

class ResolveMaintenanceEvent extends MaintenanceEvent {
  final BuildContext? context;
  final String? maintenanceId;
  final String? afterImage;
  final String? afterDescription;
  final bool? videoType;

  ResolveMaintenanceEvent({
    this.context,
    this.maintenanceId = '',
    this.afterDescription = '',
    this.afterImage = '',
    this.videoType = false,
  });
}

class ViewMaintenanceEvent extends MaintenanceEvent {
  final BuildContext? context;
  final String? maintenanceId;

  ViewMaintenanceEvent({
    this.context,
    this.maintenanceId = '',
  });
}
