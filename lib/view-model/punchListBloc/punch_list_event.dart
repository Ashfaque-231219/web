part of 'punch_list_bloc.dart';

abstract class PunchListEvent extends Equatable {
  const PunchListEvent();

  @override
  List<Object?> get props => [];
}

class AddReportEvent extends PunchListEvent {
  final String? punchListId;
  final String? image;
  final String? description;
  final int? projectId;
  final String? date;
  final BuildContext context;

  const AddReportEvent({
    required this.punchListId,
    required this.image,
    required this.description,
    required this.projectId,
    required this.date,
    required this.context,
  });
}

class EditReportEvent extends PunchListEvent {
  final int? id;
  final String? image;
  final String? description;
  final BuildContext context;

  const EditReportEvent({
    required this.id,
    required this.image,
    required this.description,
    required this.context,
  });
}

class ViewReportEvent extends PunchListEvent {
  final int? id;
  final BuildContext context;

  const ViewReportEvent({
    required this.id,
    required this.context,
  });
}
