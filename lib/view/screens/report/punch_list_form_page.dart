import 'dart:convert';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:web/helper/constants/color_constants.dart';
import 'package:web/helper/constants/colors.dart';
import 'package:web/helper/constants/dimen.dart';
import 'package:web/helper/constants/images.dart';
import 'package:web/helper/constants/size_constants.dart';
import 'package:web/helper/constants/string.dart';
import 'package:web/helper/utils/common_methods.dart';
import 'package:web/helper/utils/utils.dart';
import 'package:web/view-model/punchListBloc/punch_list_bloc.dart';
import 'package:web/view/shared_widget/custom_dialog.dart';
import 'package:web/view/shared_widget/custom_label.dart';
import 'package:web/view/shared_widget/custom_raised_button.dart';
import 'package:web/view/shared_widget/custom_text_field.dart';

class PunchList extends StatefulWidget {
  final int projectId;

  const PunchList({
    Key? key,
    @PathParam("id") required this.projectId,
  }) : super(key: key);

  @override
  State<PunchList> createState() => _PunchListState();
}

class _PunchListState extends State<PunchList> {
  TextEditingController idController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController expectedDateController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  String date = '';
  File? _pickedImage;
  Uint8List webImage = Uint8List(8);

  triggerPunchListEvent(PunchListEvent event) {
    context.read<PunchListBloc>().add(event);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return BlocBuilder<PunchListBloc, PunchListState>(
      builder: (context, state) {
        return LayoutBuilder(builder: (BuildContext ctx, BoxConstraints constraints) {
          if (width > SizeConstants.tabWidth) {
            return Scaffold(
              body: SingleChildScrollView(
                child: Center(
                  child: Container(
                    width: width * 0.5,
                    margin: EdgeInsets.all(appDimen.sp20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                // context.router.navigateBack();
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
                                text: 'Punch List',
                                size: appDimen.sp16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: width * 0.5,
                          padding: EdgeInsets.all(appDimen.sp10),
                          margin: EdgeInsets.all(appDimen.sp10),
                          decoration: BoxDecoration(
                            color: Color(appColors.white),
                            borderRadius: BorderRadius.all(Radius.circular(appDimen.sp5)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                offset: const Offset(0.0, 2.0), //(x,y)
                                blurRadius: appDimen.sp5,
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: CustomLabel(
                                  text: 'Punch List ID',
                                  size: appDimen.sp13,
                                  color: Color(appColors.grey7A7A7A),
                                ),
                              ),
                              SizedBox(
                                width: width * 0.2,
                                child: CustomTextField(
                                  onTextChanged: idController,
                                  borderRadius: appDimen.sp5,
                                  hintText: appString.idHint,
                                  maxLength: 10,
                                ),
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
                                            _pickImage();
                                          },
                                          child: DottedBorder(
                                              dashPattern: const [4, 4],
                                              strokeWidth: 1,
                                              color: Color(appColors.greyA5A5A5),
                                              radius: Radius.circular(appDimen.sp5),
                                              child: _pickedImage == null
                                                  ? SizedBox(
                                                      height: height * 0.25,
                                                      width: width * 0.2,
                                                      child: Icon(
                                                        Icons.camera_alt_outlined,
                                                        size: appDimen.sp40,
                                                        color: Color(
                                                          appColors.greyA5A5A5,
                                                        ),
                                                      ),
                                                    )
                                                  : SizedBox(
                                                      width: width * 0.2,
                                                      height: height * 0.25,
                                                      child: Image.memory(
                                                        webImage,
                                                        fit: BoxFit.fill,
                                                      ))),
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
                                          SizedBox(
                                            height: height * 0.25,
                                            child: CustomTextField(
                                              onTextChanged: descriptionController,
                                              borderRadius: appDimen.sp5,
                                              maxLines: null,
                                              maxLength: 100,
                                              inputType: TextInputType.multiline,
                                              expands: true,
                                              hintText: appString.descriptionHint,
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
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: CustomLabel(
                                  text: 'Expected Completion Date',
                                  size: appDimen.sp13,
                                  color: Color(appColors.grey7A7A7A),
                                ),
                              ),
                              SizedBox(
                                height: appDimen.sp5,
                              ),
                              InkWell(
                                onTap: () async {
                                  selectedDate = await CommonMethods.selectDate(context, selectedDate);
                                  var formattedDate = CommonMethods.dateFormatterDDMMYYYY(selectedDate.toString());
                                  date = formattedDate.toString();
                                  setState(() {});
                                },
                                child: Container(
                                  width: appDimen.sp150,
                                  decoration: BoxDecoration(
                                    color: Color(appColors.white),
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
                              // Visibility(
                              //   visible: !widget.resolve,
                              //   child: Column(
                              //     children: [
                              //       SizedBox(
                              //         height: appDimen.sp15,
                              //       ),
                              //       CustomRaisedButton(
                              //         width: width * 0.15,
                              //         text: 'Save',
                              //         color: Colors.white,
                              //         textColor: Color(appColors.brown840000),
                              //         sideColor: Color(appColors.brown840000),
                              //         onPressed: () {},
                              //       ),
                              //       SizedBox(
                              //         height: appDimen.sp15,
                              //       ),
                              //     ],
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: appDimen.sp60),
                            child: CustomRaisedButton(
                              text: "Raise Issue",
                              color: ColorConstants.darkBrown,
                              onPressed: () {
                                if (checkUploads() && widget.projectId != null) {
                                  String base64Image = base64Encode(webImage);
                                  triggerPunchListEvent(
                                    AddReportEvent(
                                        punchListId: idController.text,
                                        image: base64Image,
                                        description: descriptionController.text,
                                        projectId: widget.projectId,
                                        date: selectedDate.toString(),
                                        context: context),
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Scaffold(
              body: SingleChildScrollView(
                child: Center(
                  child: Container(
                    width: width * 0.9,
                    // height: height,
                    margin: EdgeInsets.all(appDimen.sp20),
                    child: Column(
                      children: [
                        Row(
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
                                text: 'Punch List',
                                size: appDimen.sp16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: width * 0.9,
                          padding: EdgeInsets.all(appDimen.sp10),
                          margin: EdgeInsets.all(appDimen.sp10),
                          decoration: BoxDecoration(
                            color: Color(appColors.white),
                            borderRadius: BorderRadius.all(Radius.circular(appDimen.sp5)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                offset: const Offset(0.0, 2.0), //(x,y)
                                blurRadius: appDimen.sp5,
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: CustomLabel(
                                  text: 'Punch List ID',
                                  size: appDimen.sp13,
                                  color: Color(appColors.grey7A7A7A),
                                ),
                              ),
                              SizedBox(
                                width: width * 0.86,
                                child: CustomTextField(
                                  onTextChanged: idController,
                                  borderRadius: appDimen.sp5,
                                  hintText: appString.idHint,
                                  maxLength: 10,
                                ),
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
                                  _pickImage();
                                },
                                child: DottedBorder(
                                  dashPattern: const [4, 4],
                                  strokeWidth: 1,
                                  color: Color(appColors.greyA5A5A5),
                                  radius: Radius.circular(appDimen.sp5),
                                  child: _pickedImage == null
                                      ? SizedBox(
                                          height: height * 0.25,
                                          width: width * 0.86,
                                          child: Icon(
                                            Icons.camera_alt_outlined,
                                            size: appDimen.sp40,
                                            color: Color(
                                              appColors.greyA5A5A5,
                                            ),
                                          ),
                                        )
                                      : SizedBox(
                                          width: width * 0.86,
                                          height: height * 0.25,
                                          child: Image.memory(
                                            webImage,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
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
                              SizedBox(
                                height: height * 0.3,
                                child: CustomTextField(
                                  onTextChanged: descriptionController,
                                  borderRadius: appDimen.sp5,
                                  maxLines: null,
                                  maxLength: 100,
                                  inputType: TextInputType.multiline,
                                  expands: true,
                                  hintText: appString.descriptionHint,
                                ),
                              ),
                              SizedBox(
                                height: appDimen.sp5,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: CustomLabel(
                                  text: 'Expected Completion Date',
                                  size: appDimen.sp13,
                                  color: Color(appColors.grey7A7A7A),
                                ),
                              ),
                              SizedBox(
                                height: appDimen.sp5,
                              ),
                              InkWell(
                                onTap: () async {
                                  selectedDate = await CommonMethods.selectDate(context, selectedDate);
                                  var formattedDate = CommonMethods.dateFormatterDDMMYYYY(selectedDate.toString());
                                  date = formattedDate.toString();
                                  setState(() {});
                                },
                                child: Container(
                                  width: appDimen.sp150,
                                  decoration: BoxDecoration(
                                    color: Color(appColors.white),
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
                            ],
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: appDimen.sp60),
                            child: CustomRaisedButton(
                              text: "Raise Issue",
                              color: ColorConstants.darkBrown,
                              onPressed: () {
                                print(widget.projectId != null);
                                if (checkUploads() && widget.projectId != null) {
                                  String base64Image = base64Encode(webImage);
                                  triggerPunchListEvent(
                                    AddReportEvent(
                                        punchListId: idController.text,
                                        image: base64Image,
                                        description: descriptionController.text,
                                        projectId: widget.projectId,
                                        date: selectedDate.toString(),
                                        context: context),
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
        });
      },
    );
  }

  Future<void> _pickImage() async {
    if (!kIsWeb) {
      final ImagePicker picker = ImagePicker();
      XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var selected = File(image.path);
        if (CommonMethods.isImagePngJpeg(image.path)) {
          setState(() {
            _pickedImage = selected;
            debugPrint("THe picked images if ${_pickedImage?.path}");
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
            _pickedImage = File(image.path);
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
    if (idController.text.isEmpty) {
      validate = '$validate \u2022 Punch List ID.\n';
    }
    if (_pickedImage == null) {
      validate = '$validate \u2022 Image.\n';
    }
    if (descriptionController.text.isEmpty) {
      validate = '$validate \u2022 Description.\n';
    }
    if (date.isEmpty) {
      validate = '$validate \u2022 Expected Completion Date.\n';
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
