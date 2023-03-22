part of 'contact_admin_bloc.dart';

class ContactAdminState {
  final ContactUSModel? contactUSModel;
  final StateStatus stateStatus;


  ContactAdminState({this.contactUSModel,  this.stateStatus = const StateLoaded(successMessage: 'This is meess')});

  ContactAdminState copyWith({
    final ContactUSModel? contactUSModel,
   final StateStatus? stateStatus,

  }) {
    return ContactAdminState(
      contactUSModel: contactUSModel ?? this.contactUSModel,
      stateStatus: stateStatus ?? this.stateStatus,
    );
  }

  @override
  String toString() {
    return "ContactAdminState{contactUSModel:$contactUSModel,stateStatus:$stateStatus}";
  }
}
