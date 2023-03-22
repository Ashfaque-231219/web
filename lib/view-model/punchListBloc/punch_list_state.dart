part of 'punch_list_bloc.dart';

abstract class PunchListState extends Equatable {
  const PunchListState();

  @override
  List<Object?> get props => [];
}

class PunchListInitial extends PunchListState {}

class Loading extends PunchListState {}

class AddPunchListState extends PunchListState {
  final PunchListModal? report;

  const AddPunchListState({this.report});

  AddPunchListState copyWith({
    final PunchListModal? reportName,
  }) {
    return AddPunchListState(report: reportName ?? report);
  }

  @override
  String toString() {
    return "State{reportName:$report}";
  }
}

class EditPunchListState extends PunchListState {
  final PunchListModal? report;

  const EditPunchListState({this.report});

  EditPunchListState copyWith({
    final PunchListModal? report,
  }) {
    return EditPunchListState(report: report ?? this.report);
  }

  @override
  String toString() {
    return "State{reportName:$report}";
  }
}

class ViewPunchListState extends PunchListState {
  final PunchListModal? report;

  const ViewPunchListState({this.report});

  ViewPunchListState copyWith({
    final PunchListModal? report,
  }) {
    return ViewPunchListState(report: report ?? this.report);
  }

  @override
  String toString() {
    return "State{reportName:$report}";
  }
}
