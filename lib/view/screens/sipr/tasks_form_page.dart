import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_network/image_network.dart';
import 'package:image_picker/image_picker.dart';
import 'package:web/helper/constants/colors.dart';
import 'package:web/helper/constants/dimen.dart';
import 'package:web/helper/constants/size_constants.dart';
import 'package:web/helper/constants/string.dart';
import 'package:web/helper/utils/common_methods.dart';
import 'package:web/helper/utils/utils.dart';
import 'package:web/models/response/project_details_modal.dart';
import 'package:web/view-model/event_status.dart';
import 'package:web/view-model/task_report_bloc/task_report_bloc.dart';
import 'package:web/view-model/task_report_bloc/task_report_event.dart';
import 'package:web/view/shared_widget/custom_dialog.dart';
import 'package:web/view/shared_widget/custom_label.dart';
import 'package:web/view/shared_widget/custom_raised_button.dart';
import 'package:web/view/shared_widget/custom_text_field.dart';
import 'package:web/view/shared_widget/loading_widget.dart';

import '../../../view-model/task_report_bloc/task_report_state.dart';

class TasksFormPage extends StatefulWidget {
  const TasksFormPage(
      {this.view = false, this.edit = true, this.taskList, this.projectId, this.refresh, this.saveTask, Key? key})
      : super(key: key);
  final bool view;
  final bool edit;
  final TaskList? taskList;
  final String? projectId;
  final Function? refresh;
  final Function? saveTask;

  @override
  State<TasksFormPage> createState() => _TasksFormPageState();
}

class _TasksFormPageState extends State<TasksFormPage> {
  TextEditingController idController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController expectedDateController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  String date = '';
  Uint8List? webImage;
  String taskImage = '';
  bool view = false;
  bool edit = true;
  TaskList? taskList;
  bool refresh = false;

  @override
  void initState() {
    super.initState();
    view = widget.view;
    edit = widget.edit;
    taskList = widget.taskList;
    setData();
  }

  setData() async {
    // if (view) {
    descriptionController.text = taskList!.description!;
    date = CommonMethods.formatDateToString(taskList!.date!);
    taskImage = taskList!.image.toString();
    // }
  }

  triggerTaskEvent(TaskReportEvent event) {
    context.read<TaskBloc>().add(event);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return BlocBuilder<TaskBloc, TaskReportState>(
      builder: (context, state) {
        if (state.stateStatus is StateLoaded) {
          if (widget.refresh != null && refresh) {
            refresh = false;
            widget.refresh!();
          }
        }

        return LoadingWidget(
          status: state.viewStateStatus,
          child: LayoutBuilder(builder: (BuildContext ctx, BoxConstraints constraints) {
            if (width > SizeConstants.tabWidth) {
              return SingleChildScrollView(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      /*Visibility(
                    visible: !view,
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            context.router.navigateBack();
                          },
                          child: SvgPicture.asset(
                            appImages.backBlack,
                            width: appDimen.sp40,
                            height: appDimen.sp40,
                          ),
                        ),
                        SizedBox(
                          width: appDimen.sp20,
                        ),
                        Expanded(
                          child: CustomLabel(
                            text: 'Add Task',
                            size: appDimen.sp16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),*/
                      Container(
                        padding: EdgeInsets.all(appDimen.sp10),
                        decoration: BoxDecoration(
                          color: view ? Color(appColors.greyDFDFDF) : Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(appDimen.sp5)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                  child: CustomLabel(
                                    text: 'Date',
                                    size: appDimen.sp13,
                                    color: Color(appColors.grey7A7A7A),
                                  ),
                                ),
                                Visibility(
                                  visible: view && edit,
                                  child: Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          view = false;
                                          setState(() {});
                                          // context.pushRoute(route.TasksFormPage());
                                        },
                                        icon: const Icon(Icons.edit_outlined),
                                        splashRadius: appDimen.sp10,
                                      ),
                                      Visibility(
                                        visible: widget.saveTask == null,
                                        child: IconButton(
                                          onPressed: () {
                                            refresh = true;
                                            triggerTaskEvent(DeleteTaskReportEvent(
                                                context: context, taskId: taskList?.id.toString()));
                                          },
                                          icon: const Icon(Icons.delete_outline_outlined),
                                          splashRadius: appDimen.sp10,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: appDimen.sp5,
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
                            SizedBox(
                              height: appDimen.sp5,
                            ),
                            SizedBox(
                              // width: width * 0.35,
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                                        child: CustomLabel(
                                          text: 'Add Image',
                                          size: appDimen.sp13,
                                          color: Color(appColors.grey7A7A7A),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          if (!view) {
                                            _pickImage();
                                          }
                                        },
                                        child: DottedBorder(
                                          dashPattern: const [4, 4],
                                          strokeWidth: 1,
                                          color: Color(appColors.greyA5A5A5),
                                          radius: Radius.circular(appDimen.sp5),
                                          child: webImage == null && taskImage.isEmpty
                                              ? Container(
                                                  height: height * 0.25,
                                                  width: width * 0.2,
                                                  color: view ? Color(appColors.greyF1F1F1) : Color(appColors.white),
                                                  child: Icon(
                                                    Icons.camera_alt_outlined,
                                                    size: appDimen.sp40,
                                                    color: Color(
                                                      appColors.greyA5A5A5,
                                                    ),
                                                  ),
                                                )
                                              : webImage != null
                                                  ? Container(
                                                      width: width * 0.2,
                                                      height: height * 0.25,
                                                      color:
                                                          view ? Color(appColors.greyF1F1F1) : Color(appColors.white),
                                                      child: Image.memory(
                                                        webImage!,
                                                        fit: BoxFit.fill,
                                                      ))
                                                  : SizedBox(
                                                      width: width * 0.2,
                                                      height: height * 0.25,
                                                      child: ImageNetwork(
                                                          image: taskImage,
                                                          height: height * 0.25,
                                                          width: width * 0.2,
                                                          imageCache: CachedNetworkImageProvider(
                                                              taskImage)) /*Image.network(
                                                        taskImage,
                                                        fit: BoxFit.fill,
                                                      ),*/
                                                      ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    width: appDimen.sp10,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                                          child: CustomLabel(
                                            text: 'Description',
                                            size: appDimen.sp13,
                                            color: Color(appColors.grey7A7A7A),
                                          ),
                                        ),
                                        Container(
                                          height: height * 0.25,
                                          color: view ? Color(appColors.greyF1F1F1) : Color(appColors.white),
                                          child: CustomTextField(
                                            onTextChanged: descriptionController,
                                            borderRadius: appDimen.sp5,
                                            maxLines: null,
                                            maxLength: 100,
                                            inputType: TextInputType.multiline,
                                            expands: true,
                                            hintText: appString.descriptionHint,
                                            readonly: view,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: appDimen.sp5,
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
                                      if (checkUploads() && widget.projectId != null) {
                                        refresh = true;
                                        String base64Image = webImage != null ? base64Encode(webImage!) : '';
                                        if (widget.saveTask != null) {
                                          view = true;
                                          setState(() {});
                                        }
                                        taskList == null
                                            ? triggerTaskEvent(AddTaskReportEvent(
                                                context: context,
                                                projectId: widget.projectId,
                                                image: base64Image,
                                                description: descriptionController.text,
                                                date: selectedDate.toString()))
                                            : triggerTaskEvent(EditTaskReportEvent(
                                                context: context,
                                                taskId: taskList?.id.toString(),
                                                image: base64Image,
                                                description: descriptionController.text,
                                                date: selectedDate.toString()));
                                      }
                                    }),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return SingleChildScrollView(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      /*Visibility(
                    visible: !view,
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            context.router.navigateBack();
                          },
                          child: SvgPicture.asset(
                            appImages.backBlack,
                            width: appDimen.sp40,
                            height: appDimen.sp40,
                          ),
                        ),
                        SizedBox(
                          width: appDimen.sp20,
                        ),
                        Expanded(
                          child: CustomLabel(
                            text: 'Add Task',
                            size: appDimen.sp16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),*/
                      Container(
                        padding: EdgeInsets.all(appDimen.sp10),
                        decoration: BoxDecoration(
                          color: view ? Color(appColors.greyDFDFDF) : Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(appDimen.sp5)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                  child: CustomLabel(
                                    text: 'Date',
                                    size: appDimen.sp13,
                                    color: Color(appColors.grey7A7A7A),
                                  ),
                                ),
                                Visibility(
                                  visible: view && edit,
                                  child: Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          view = false;
                                          setState(() {});
                                          // context.pushRoute(route.TasksFormPage());
                                        },
                                        icon: const Icon(Icons.edit_outlined),
                                        splashRadius: appDimen.sp10,
                                      ),
                                      Visibility(
                                        visible: widget.saveTask == null,
                                        child: IconButton(
                                          onPressed: () {
                                            refresh = true;
                                            triggerTaskEvent(DeleteTaskReportEvent(
                                                context: context, taskId: taskList?.id.toString()));
                                          },
                                          icon: const Icon(Icons.delete_outline_outlined),
                                          splashRadius: appDimen.sp10,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: appDimen.sp5,
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
                            SizedBox(
                              height: appDimen.sp5,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: CustomLabel(
                                text: 'Add Image',
                                size: appDimen.sp16,
                                color: Color(appColors.grey7A7A7A),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                if (!view) {
                                  _pickImage();
                                }
                              },
                              child: DottedBorder(
                                dashPattern: const [4, 4],
                                strokeWidth: 1,
                                color: Color(appColors.greyA5A5A5),
                                radius: Radius.circular(appDimen.sp5),
                                child: webImage == null && taskImage.isEmpty
                                    ? Container(
                                        height: height * 0.25,
                                        width: width * 0.86,
                                        color: view ? Color(appColors.greyF1F1F1) : Color(appColors.white),
                                        child: Icon(
                                          Icons.camera_alt_outlined,
                                          size: appDimen.sp40,
                                          color: Color(
                                            appColors.greyA5A5A5,
                                          ),
                                        ),
                                      )
                                    : webImage != null
                                        ? Container(
                                            width: width * 0.86,
                                            height: height * 0.28,
                                            color: view ? Color(appColors.greyF1F1F1) : Color(appColors.white),
                                            child: Image.memory(
                                              webImage!,
                                              fit: BoxFit.fill,
                                            ))
                                        : SizedBox(
                                            width: width * 0.86,
                                            height: height * 0.28,
                                            child: ImageNetwork(
                                                image: taskImage,
                                                height: height * 0.28,
                                                width: width * 0.86,
                                                imageCache: CachedNetworkImageProvider(taskImage))),
                              ),
                            ),
                            SizedBox(
                              height: appDimen.sp10,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: CustomLabel(
                                text: 'Description',
                                size: appDimen.sp16,
                                color: Color(appColors.grey7A7A7A),
                              ),
                            ),
                            Container(
                              height: height * 0.3,
                              color: view ? Color(appColors.greyF1F1F1) : Color(appColors.white),
                              child: CustomTextField(
                                onTextChanged: descriptionController,
                                borderRadius: appDimen.sp5,
                                maxLines: null,
                                maxLength: 100,
                                inputType: TextInputType.multiline,
                                expands: true,
                                hintText: appString.descriptionHint,
                                readonly: view,
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
                                    if (checkUploads() && widget.projectId != null) {
                                      refresh = true;
                                      String base64Image = webImage != null ? base64Encode(webImage!) : '';
                                      if (widget.saveTask != null) {
                                        view = true;
                                        setState(() {});
                                      }
                                      taskList == null
                                          ? triggerTaskEvent(AddTaskReportEvent(
                                              context: context,
                                              projectId: widget.projectId,
                                              image: base64Image,
                                              description: descriptionController.text,
                                              date: selectedDate.toString()))
                                          : triggerTaskEvent(EditTaskReportEvent(
                                              context: context,
                                              taskId: taskList?.id.toString(),
                                              image: base64Image,
                                              description: descriptionController.text,
                                              date: selectedDate.toString()));
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          }),
        );
      },
    );
    //   },
    // );
  }

  Future<void> _pickImage() async {
    if (!kIsWeb) {
      final ImagePicker picker = ImagePicker();
      XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var selected = File(image.path);
        if (CommonMethods.isImagePngJpeg(image.path)) {
          setState(() {
            // _pickedImage = selected;
            // debugPrint("THe picked images if ${_pickedImage?.path}");
          });
        } else {
          showErrorSnackBar(context, "Image Type is not supported. Supported Types are jpg,jpeg and png)");
        }
      } else {
        debugPrint('No image has been picked');
      }
    } else if (kIsWeb) {
      final ImagePicker picker = ImagePicker();
      XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var f = await image.readAsBytes();
        debugPrint(image.mimeType);
        print("fileExtension");
        print(image.path);
        if (CommonMethods.isImagePngJpeg(image.mimeType.toString())) {
          setState(() {
            webImage = f;
            // _pickedImage = File(image.path);
          });
        } else {
          showErrorSnackBar(context, "Image Type is not supported. Supported Types are jpg,jpeg and png).");
        }
      } else {
        debugPrint('No image has been picked');
      }
    } else {
      debugPrint('Something went wrong');
    }
  }

  bool checkUploads() {
    String validate = '';
    if (date.isEmpty) {
      validate = '$validate \u2022 Date.\n';
    }
    if (webImage == null && taskImage.isEmpty) {
      validate = '$validate \u2022 Image.\n';
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
