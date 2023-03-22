import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web/Repository/contact_us_repo.dart';
import 'package:web/helper/utils/utils.dart';
import 'package:web/models/response/contact_us_model/contact_us_model.dart';
import 'package:web/services/request_body.dart';
import 'package:web/view-model/event_status.dart';
import 'package:web/view/shared_widget/custom_dialog.dart';

part 'contact_admin_event.dart';

part 'contact_admin_state.dart';

class ContactAdminBloc extends Bloc<ContactAdminEvent, ContactAdminState> {
  ContactUsRepository contactUsRepository;
  Dio? dio;

  ContactAdminBloc({required this.contactUsRepository, this.dio}) : super(ContactAdminState()) {
    on<GetContactAdminEvent>((event, emit) async {
      await _getContactAdminEvent(event, emit);
    });
  }

  _getContactAdminEvent(GetContactAdminEvent event, Emitter<ContactAdminState> emit) async {
    try {
      emit(state.copyWith(stateStatus: StateLoading()));
      Map req = RequestBody.contactAdmin(question: event.questions);
      ContactUSModel contactUSModel = await contactUsRepository.contactAdmin(req, event.context!);
      if (contactUSModel.success!) {
        emit(state.copyWith(stateStatus: StateLoaded(successMessage: contactUSModel.message.toString())));
        bool? check = await showDialog(
            context: event.context!,
            builder: (context) {
              return CustomDialog(
                text: contactUSModel.message.toString(),
                doneAdmin: true,
              );
            },
            barrierDismissible: false);
        if (check != null) {
          event.context!.router.navigateBack();
        }
      } else {
        emit(state.copyWith(stateStatus: StateFailed(errorMessage: contactUSModel.message.toString())));
        checkStatus(event.context!);
      }
    } catch (e) {
      checkStatus(event.context!);
      debugPrint(e.toString());
    }
  }
}
