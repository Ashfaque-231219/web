import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web/helper/constants/colors.dart';
import 'package:web/helper/constants/dimen.dart';
import 'package:web/helper/constants/size_constants.dart';
import 'package:web/helper/constants/string.dart';
import 'package:web/helper/utils/common_methods.dart';
import 'package:web/models/response/project_details_modal.dart';
import 'package:web/view-model/event_status.dart';
import 'package:web/view-model/schedule_bloc/schedule_bloc.dart';
import 'package:web/view-model/schedule_bloc/schedule_event.dart';
import 'package:web/view/shared_widget/custom_dialog.dart';
import 'package:web/view/shared_widget/custom_label.dart';
import 'package:web/view/shared_widget/custom_raised_button.dart';
import 'package:web/view/shared_widget/custom_text_field.dart';

import '../../shared_widget/loading_widget.dart';

class ScheduleFormPage extends StatefulWidget {
  const ScheduleFormPage({this.view = false, this.projectId = '', this.scheduleList, this.refresh, Key? key}) : super(key: key);

  final bool view;
  final String? projectId;
  final ScheduleList? scheduleList;
  final Function? refresh;

  @override
  State<ScheduleFormPage> createState() => _ScheduleFormPageState();
}

class _ScheduleFormPageState extends State<ScheduleFormPage> {
  TextEditingController descriptionController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  String date = '';
  bool view = false;
  ScheduleList? scheduleList;

  bool refresh = false;

  @override
  void initState() {
    super.initState();
    scheduleList = widget.scheduleList;
    view = widget.view;
    if (view) {
      descriptionController.text = scheduleList!.description!;
      date = CommonMethods.formatDateToString(scheduleList!.date!);
    }

    print("Id======== ${widget.projectId}");
  }

  triggerScheduleEvent(ScheduleEvent event) {
    context.read<ScheduleBloc>().add(event);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return BlocBuilder<ScheduleBloc, ScheduleState>(
      builder: (context, state) {
        if (state.stateStatus is StateLoaded) {
          if (widget.refresh != null && refresh) {
            widget.refresh!();
            refresh = false;
          }
        }
        if (width > SizeConstants.tabWidth) {
          return LoadingWidget(
            status: state.viewStateStatus,
            child: Container(
              decoration: BoxDecoration(
                color: view ? Color(appColors.greyDFDFDF) : Colors.white,
                borderRadius: BorderRadius.circular(appDimen.sp5),
              ),
              padding: EdgeInsets.all(appDimen.sp10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: appDimen.sp15, bottom: appDimen.sp10),
                        child: CustomLabel(
                          text: 'Date',
                          color: Color(appColors.grey7A7A7A),
                          fontWeight: FontWeight.w500,
                          size: appDimen.sp12,
                        ),
                      ),
                      Visibility(
                        visible: view,
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                view = false;
                                setState(() {});
                              },
                              icon: const Icon(Icons.edit_outlined),
                              splashRadius: appDimen.sp10,
                            ),
                            IconButton(
                              onPressed: () {
                                refresh = true;
                                triggerScheduleEvent(
                                    DeleteScheduleReportEvent(context: context, id: scheduleList!.id.toString(), projectId: widget.projectId));
                              },
                              icon: const Icon(Icons.delete_outline_outlined),
                              splashRadius: appDimen.sp10,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () async {
                      if (!view) {
                        selectedDate = await CommonMethods.selectDate(context, selectedDate);
                        var formattedDate = CommonMethods.dateFormatterYYYYMMDD(selectedDate.toString());
                        date = formattedDate.toString();
                        setState(() {});
                      }
                    },
                    child: Container(
                      width: appDimen.sp150,
                      decoration: BoxDecoration(
                        color: view ? Color(appColors.greyF1F1F1) : Color(appColors.white),
                        borderRadius: BorderRadius.all(
                          Radius.circular(appDimen.sp5),
                        ),
                        border: Border.all(
                          color: Color(appColors.greyA5A5A5),
                        ),
                      ),
                      padding: EdgeInsets.all(appDimen.sp10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomLabel(
                            text: date.isEmpty ? 'dd/mm/yyyy' : date,
                            color: date.isEmpty ? Color(appColors.greyA5A5A5) : Colors.black,
                          ),
                          Icon(
                            Icons.calendar_today,
                            color: Color(appColors.greyA5A5A5),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: appDimen.sp15, bottom: appDimen.sp10),
                    child: CustomLabel(
                      text: 'Description',
                      color: Color(appColors.grey7A7A7A),
                      fontWeight: FontWeight.w500,
                      size: appDimen.sp12,
                    ),
                  ),
                  Container(
                    height: height * 0.25,
                    width: width * 0.45,
                    color: view ? Color(appColors.greyF1F1F1) : Color(appColors.white),
                    child: CustomTextField(
                      onTextChanged: descriptionController,
                      borderRadius: appDimen.sp5,
                      maxLines: null,
                      maxLength: 100,
                      inputType: TextInputType.multiline,
                      expands: true,
                      readonly: view,
                      hintText: appString.descriptionHint,
                    ),
                  ),
                  Visibility(
                    visible: !view,
                    child: Container(
                      width: width * 0.2,
                      padding: EdgeInsets.only(top: appDimen.sp15, bottom: appDimen.sp10),
                      child: CustomRaisedButton(
                        text: 'Save',
                        color: Color(appColors.white),
                        textColor: Color(appColors.brown840000),
                        sideColor: Color(appColors.brown840000),
                        onPressed: () {
                          if (checkUploads()) {
                            refresh = true;
                            scheduleList == null
                                ? triggerScheduleEvent(AddScheduleEvent(
                                    context: context,
                                    projectId: widget.projectId,
                                    description: descriptionController.text,
                                    date: selectedDate.toString()))
                                : triggerScheduleEvent(EditScheduleReportEvent(
                                    context: context,
                                    date: selectedDate.toString(),
                                    description: descriptionController.text,
                                    id: scheduleList!.id.toString()));
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return LoadingWidget(
            status: state.viewStateStatus,
            child: Container(
              decoration: BoxDecoration(
                color: view ? Color(appColors.greyDFDFDF) : Colors.white,
                borderRadius: BorderRadius.circular(appDimen.sp5),
              ),
              padding: EdgeInsets.all(appDimen.sp10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: appDimen.sp15, bottom: appDimen.sp10),
                        child: CustomLabel(
                          text: 'Date',
                          color: Color(appColors.grey7A7A7A),
                          fontWeight: FontWeight.w500,
                          size: appDimen.sp12,
                        ),
                      ),
                      Visibility(
                        visible: view,
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                view = false;
                                setState(() {});
                              },
                              icon: const Icon(Icons.edit_outlined),
                              splashRadius: appDimen.sp10,
                            ),
                            IconButton(
                              onPressed: () {
                                refresh = true;
                                triggerScheduleEvent(DeleteScheduleReportEvent(
                                  context: context,
                                  id: scheduleList!.id.toString(),
                                  projectId: widget.projectId,
                                ));
                              },
                              icon: const Icon(Icons.delete_outline_outlined),
                              splashRadius: appDimen.sp10,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () async {
                      if (!view) {
                        selectedDate = await CommonMethods.selectDate(context, selectedDate);
                        var formattedDate = CommonMethods.dateFormatterYYYYMMDD(selectedDate.toString());
                        date = formattedDate.toString();
                        setState(() {});
                      }
                    },
                    child: Container(
                      width: appDimen.sp150,
                      decoration: BoxDecoration(
                        color: view ? Color(appColors.greyF1F1F1) : Color(appColors.white),
                        borderRadius: BorderRadius.all(
                          Radius.circular(appDimen.sp5),
                        ),
                        border: Border.all(
                          color: Color(appColors.greyA5A5A5),
                        ),
                      ),
                      padding: EdgeInsets.all(appDimen.sp10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomLabel(
                            text: date.isEmpty ? 'dd/mm/yyyy' : date,
                            color: date.isEmpty ? Color(appColors.greyA5A5A5) : Colors.black,
                          ),
                          Icon(
                            Icons.calendar_today,
                            color: Color(appColors.greyA5A5A5),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: appDimen.sp15, bottom: appDimen.sp10),
                    child: CustomLabel(
                      text: 'Description',
                      color: Color(appColors.grey7A7A7A),
                      fontWeight: FontWeight.w500,
                      size: appDimen.sp12,
                    ),
                  ),
                  Container(
                    height: height * 0.25,
                    // width: width * 0.8,
                    color: view ? Color(appColors.greyF1F1F1) : Color(appColors.white),
                    child: CustomTextField(
                      onTextChanged: descriptionController,
                      borderRadius: appDimen.sp5,
                      maxLines: null,
                      maxLength: 100,
                      inputType: TextInputType.multiline,
                      expands: true,
                      readonly: view,
                      hintText: appString.descriptionHint,
                    ),
                  ),
                  Visibility(
                    visible: !view,
                    child: Container(
                      // width: width * 0.8,
                      padding: EdgeInsets.only(top: appDimen.sp15, bottom: appDimen.sp10),
                      child: CustomRaisedButton(
                        text: 'Save',
                        color: Color(appColors.white),
                        textColor: Color(appColors.brown840000),
                        sideColor: Color(appColors.brown840000),
                        onPressed: () {
                          if (checkUploads()) {
                            refresh = true;
                            scheduleList == null
                                ? triggerScheduleEvent(AddScheduleEvent(
                                    context: context,
                                    projectId: widget.projectId,
                                    description: descriptionController.text,
                                    date: selectedDate.toString()))
                                : triggerScheduleEvent(EditScheduleReportEvent(
                                    context: context,
                                    date: selectedDate.toString(),
                                    description: descriptionController.text,
                                    id: scheduleList!.id.toString()));
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  bool checkUploads() {
    String validate = '';
    if (date.isEmpty) {
      validate = '$validate \u2022 Date.\n';
    }
    if (descriptionController.text.isEmpty) {
      validate = '$validate \u2022 Description.\n';
    }

    if (validate.isNotEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return CustomDialog(
            text: 'Following field(s) are required: \n$validate',
          );
        },
      );
      return false;
    } else {
      return true;
    }
  }
}
