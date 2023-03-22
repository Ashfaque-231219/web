part of 'contact_admin_bloc.dart';


abstract class ContactAdminEvent extends Equatable {
  const ContactAdminEvent();
  @override
  List<Object?> get props => [];

}
class GetContactAdminEvent extends ContactAdminEvent{
 final BuildContext ?context;
 final String ?questions ;
 const GetContactAdminEvent({ this.context,this.questions = ''});

}
